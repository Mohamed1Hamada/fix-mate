import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:fixmate/core/notifications/local_notifications_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:flutter/services.dart' show rootBundle;

class NotificationsHelper {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    importance: Importance.max,
  );

  Future<void> initNotifications() async {
    try {
      // التحقق من أننا ليس في Simulator قبل محاولة الحصول على APNS token
      LocalNotificationsServices.init();

      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      // إعدادات Android
      const AndroidInitializationSettings androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // إعدادات iOS
      const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      // تهيئة قناة الإشعارات للـ Android فقط
      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      }

      // الحصول على التوكن مع معالجة الأخطاء
      try {
        if (Platform.isIOS) {
          String? apnsToken;

          try {
            apnsToken = await _firebaseMessaging.getAPNSToken();
          } catch (_) {
            apnsToken = null;
          }

          if (apnsToken == null) {
            print("iOS Simulator detected - skipping FCM token");
          } else {
            final deviceToken = await _firebaseMessaging.getToken();
            print("Device Token: $deviceToken");
          }
        } else {
          final deviceToken = await _firebaseMessaging.getToken();
          print("Device Token: $deviceToken");
        }
      } catch (e) {
        print("Error getting FCM token: $e");
      }

      // إعداد مستمع الإشعارات
      setupFirebaseMessaging();
    } catch (e) {
      print("Error in initNotifications: $e");
      // في حالة أي خطأ، نحاول تهيئة الإشعارات المحلية فقط
      await _initLocalNotificationsOnly();
    }
  }

  // دالة مساعدة للتحقق من iOS Simulator

  // تهيئة الإشعارات المحلية فقط (بدون Firebase)
  Future<void> _initLocalNotificationsOnly() async {
    try {
      const AndroidInitializationSettings androidInit =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: androidInit,
        iOS: iosInit,
      );

      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      if (Platform.isAndroid) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
      }

      print('Local notifications initialized (without Firebase)');
    } catch (e) {
      print('Error initializing local notifications only: $e');
    }
  }

  void setupFirebaseMessaging() {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          log(message.notification!.title.toString());
          LocalNotificationsServices.showBasicNotification(
            body: message.notification!.body.toString(),
            title: message.notification!.title.toString(),
            id: 1,
          );
        }
      });

      // معالجة الإشعارات في الخلفية
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      print("Error setting up Firebase Messaging: $e");
    }
  }

  // معالج الإشعارات في الخلفية
  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
    // يمكن إضافة منطق هنا لعرض إشعار محلي من الخلفية
  }

  Future<String?> getAccessToken() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/fixmate-fab73.json');
      final serviceAccountJson = jsonDecode(jsonString);
      List<String> scopes = [
        "https://www.googleapis.com/auth/firebase.messaging"
      ];
      var client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
      );
      var credentials = await auth.obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        scopes,
        client,
      );
      client.close();
      return credentials.accessToken.data;
    } catch (e) {
      print("Error getting access token: $e");
      return null;
    }
  }

  Future<void> sendNotification({
    String? topic,
    String? token,
    required String title,
    required String body,
    String? type,
  }) async {
    try {
      if (topic == null && token == null) {
        throw Exception("You must provide either topic or token.");
      }

      String? accessToken = await getAccessToken();
      if (accessToken == null) {
        print("Failed to get access token");
        return;
      }

      const String url =
          "https://fcm.googleapis.com/v1/projects/fixmate-fab73/messages:send";
      Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $accessToken';

      var requestBody = topic != null
          ? getTopicBody(topic: topic, title: title, body: body, type: type)
          : getTokenBody(token: token!, title: title, body: body, type: type);

      var response = await dio.post(url, data: requestBody);
      print('Response Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  Map<String, dynamic> getTopicBody({
    required String topic,
    required String title,
    required String body,
    String? type,
  }) {
    return {
      "message": {
        "topic": topic,
        "notification": {"title": title, "body": body},
        "data": type != null ? {"type": type} : {}
      }
    };
  }

  Map<String, dynamic> getTokenBody({
    required String token,
    required String title,
    required String body,
    String? type,
  }) {
    return {
      "message": {
        "token": token,
        "notification": {"title": title, "body": body},
        "data": type != null ? {"type": type} : {}
      }
    };
  }

  Future<void> subscribeToTopic({required String topic}) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  Future<void> unSubscribeToTopic({required String topic}) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }
}
