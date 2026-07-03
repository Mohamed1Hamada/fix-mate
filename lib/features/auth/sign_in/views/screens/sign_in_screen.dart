import 'package:flutter/material.dart';
import 'package:fixmate/features/auth/sign_in/views/widgets/sign_in_screen_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreenBody(),
    );
  }
}

