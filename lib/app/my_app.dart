import 'package:easy_localization/easy_localization.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:fixmate/core/app_route/app_routes.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SizeConfig.init(context);
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          builder: DevicePreview.appBuilder,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.kBackgroundColor,
          ),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routes: AppRoutes.routes,
          initialRoute: RouteNames.splashScreen,
        );
      },
    );
  }
}
