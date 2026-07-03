import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixmate/core/notifications/fcm_notification.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fixmate/app/my_app.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: "https://jivyckntxxyrcijfspbi.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imppdnlja250eHh5cmNpamZzcGJpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjI4NTQ1OTgsImV4cCI6MjA3ODQzMDU5OH0.rZvvPv_jaojxggk_MmI49AO6aRU9wn8lohFHgU85O6M",
  );
  await setupDI();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // تغليف استدعاء الإشعارات بـ try-catch لمنع توقف التطبيق
  try {
    await getIt<NotificationsHelper>().initNotifications();
    getIt<NotificationsHelper>().setupFirebaseMessaging();
  } catch (e) {
    print("Notification Initialization Failed: $e");
    // هنا التطبيق هيكمل عادي حتى لو الإشعارات مفعلتش
  }
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale(
          'ar'), // Starting with Arabic as requested or common in region
      child: DevicePreview(
        enabled: false,
        builder: (context) => const MyApp(),
      ),
    ),
  );
  CustomQuickAlert.initialize(navigatorKey);
}
