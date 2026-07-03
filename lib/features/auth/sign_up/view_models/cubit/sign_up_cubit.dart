import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:fixmate/app/my_app.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/helper/pick_image.dart';
import 'package:fixmate/core/network/supabase/auth/sign_in_with_google.dart';
import 'package:fixmate/core/network/supabase/auth/sign_up_with_password.dart';
import 'package:fixmate/core/network/supabase/database/add_data.dart';
import 'package:fixmate/core/network/supabase/storage/upload_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  // Controllers && Keys && Variables
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;
  //// Methods
  /// Sign Up Method
  signUp() async {
    if (formKey.currentState!.validate()) {
      if (image == null) {
        emit(PickImageFailure(errorMessage: "Please select an image"));
        return;
      }
      try {
        emit(SignUpLoading());
        FocusScope.of(navigatorKey.currentContext!).unfocus();
        await signUpWithPassword(
            email: emailController.text, password: passwordController.text);
        String? fcmToken;

        try {
          if (Platform.isIOS) {
            final apnsToken = await getIt<FirebaseMessaging>().getAPNSToken();

            if (apnsToken != null) {
              fcmToken = await getIt<FirebaseMessaging>().getToken();
            } else {
              print("iOS Simulator detected - skipping FCM token");
            }
          } else {
            fcmToken = await getIt<FirebaseMessaging>().getToken();
          }
        } catch (e) {
          print("Error getting FCM token: $e");
        }

        await addData(
          tableName: "users",
          data: {
            "id": getIt<SupabaseClient>().auth.currentUser!.id,
            "username": userNameController.text,
            "full_name": fullNameController.text,
            "phone_number": phoneController.text,
            "email": emailController.text,
            "role": getIt<CacheHelper>().getData(key: "role"),
            "image": await uploadFileToSupabaseStorage(
              file: image!,
              pucketName: "user-avatars",
            ),
            "tokens": fcmToken != null ? [fcmToken] : [],
          },
        );
        emit(SignUpSuccess(route: RouteNames.signInScreen));
      } on Exception catch (e) {
        log(e.toString());
        emit(SignUpFailure(errorMessage: e.toString()));
      }
    }
  }

  // pick Image Method
  pickProfileImage() {
    pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        image = value;
        emit(PickImageSuccess());
      } else {
        emit(PickImageFailure(errorMessage: "No image selected"));
      }
    });
  }

  // sign in with google
  signUpWithGoogle() async {
    try {
      emit(SignUpWithGoogleLoading());
      await getIt<GoogleAuthService>().signWithGoogle();
      emit(SignUpWithGoogleSuccess());
    } on Exception catch (e) {
      emit(SignUpWithGoogleFailure(errorMessage: e.toString()));
    }
  }

  // Dispose Controllers
  @override
  Future<void> close() {
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    fullNameController.dispose();
    return super.close();
  }
}
