import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/network/supabase/database/get_data_with_spacific_id.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fixmate/app/my_app.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/network/supabase/auth/sign_in_with_google.dart';
import 'package:fixmate/core/network/supabase/auth/sign_in_with_password.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'sign_in_state.dart';

enum UserRole { customer, technician }

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final supabase = getIt<SupabaseClient>();
  UserModel? userModel;
  final firebaseMessaging = getIt<FirebaseMessaging>();
  // Sign in Method
  signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(SignInLoading());
        FocusScope.of(navigatorKey.currentContext!).unfocus();
        await signInWithPassword(
            email: emailController.text, password: passwordController.text);
        await getUserData();
        emit(SignInSuccess(route: getScreenRoute()));
      } on Exception catch (e) {
        emit(SignInFailure(message: e.toString()));
      }
    }
  }

  Future<void> getUserData() async {
    try {
      final userData = await getDataWithSpacificId(
        tableName: "users",
        primaryKey: "id",
        id: supabase.auth.currentUser!.id,
      );
      if (userData.isEmpty) {
        throw Exception("User not found");
      }
      userModel = UserModel.fromJson(userData.first);
      await getIt<CacheHelper>().saveUserModel(userModel!);
      await saveToken();
    } catch (e) {
      log(e.toString());
      throw Exception("Failed to fetch user data or user not found");
    }
  }

  // get screen route
  String getScreenRoute() {
    if (userModel!.role == UserRole.customer.name) {
      return RouteNames.customerHomeScreen;
    } else if (userModel!.role == UserRole.technician.name &&
        userModel!.isCompleteProfile) {
      return RouteNames.technicianHomeScreen;
    } else {
      return RouteNames.compleTechnicianProfileScreen;
    }
  }

  // sign in with google
  signInWithGoogle() async {
    try {
      emit(SignInWithGoogleLoading());
      await getIt<GoogleAuthService>().signWithGoogle();
      emit(SignInWithGoogleSuccess(
        route: getScreenRoute(),
      ));
    } on Exception catch (e) {
      emit(SignInWithGoogleFailure(message: e.toString()));
    }
  }

  Future<void> saveToken() async {
    try {
      String? token;

      if (Platform.isIOS) {
        final apnsToken = await firebaseMessaging.getAPNSToken();

        if (apnsToken == null) {
          print("iOS Simulator detected - skipping FCM token");
          return;
        }

        token = await firebaseMessaging.getToken();
      } else {
        token = await firebaseMessaging.getToken();
      }

      if (token == null) {
        return;
      }

      final currentTokens = userModel?.tokens ?? [];

      if (!currentTokens.contains(token)) {
        final updatedTokens = [...currentTokens, token];

        await supabase.from("users").update({"tokens": updatedTokens}).eq(
            "id", supabase.auth.currentUser!.id);
      }
    } catch (e) {
      print("Error saving FCM token: $e");
    }
  }

  // Dispose Controllers
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
