import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/features/splash/views/widgets/splash_screen_body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    // final supabase = getIt<SupabaseClient>();
    // final user = supabase.auth.currentUser;
    // if (user == null) {
    //   if (mounted) {
    //     context.pushReplacementScreen(RouteNames.onBoardingScreen);
    //   }
    //   return;
    // }

    // try {
    //   final userData = await getDataWithSpacificId(
    //     tableName: "users",
    //     primaryKey: "user_id",
    //     id: getIt<SupabaseClient>().auth.currentUser!.id,
    //   );
    //   if (userData.isNotEmpty) {
    //     var userType = userData.first["user_type"] as String;
    //     String targetRoute;
    //     switch (userType) {
    //       case "customer":
    //         targetRoute = RouteNames.customerHomeScreen;
    //         break;
    //       case "driver":
    //         targetRoute = RouteNames.driverHomeScreen;
    //         break;
    //       case "admin_golfcar":
    //         targetRoute = RouteNames.adminGolfCarHomeScreen;
    //         break;
    //       case "admin_groceries":
    //         targetRoute = RouteNames.adminGroceryHomeScreen;
    //         break;
    //       default:
    //         targetRoute = RouteNames.onBoardingScreen;
    //     }
    //     if (mounted) {
    //       context.pushReplacementScreen(targetRoute);
    //     }
    //   } else {
    //     if (mounted) {
          context.pushReplacementScreen(RouteNames.onBoardingScreen);
      //   }
      // }
    // } catch (e) {
    //   debugPrint("Error while checking user: $e");
    //   if (mounted) {
    //     context.pushReplacementScreen(RouteNames.onBoardingScreen);
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
}
