import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/network/supabase/auth/sign_in_with_google.dart';
import 'package:fixmate/core/notifications/fcm_notification.dart';
import 'package:fixmate/core/notifications/local_notifications_services.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerSingleton<CacheHelper>(cacheHelper);
  getIt.registerLazySingleton(() => Supabase.instance.client);
  getIt.registerLazySingleton(() => NotificationsHelper());
  getIt.registerLazySingleton(() => FirebaseMessaging.instance);
  getIt.registerLazySingleton(() => LocalNotificationsServices());

  // ✅ تسجيل GoogleAuthService
  getIt.registerLazySingleton<GoogleAuthService>(() => GoogleAuthService());
}
