import 'package:flutter/material.dart';
import 'package:fixmate/features/auth/sign_up/views/widgets/sign_up_screen_body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpScreenBody(),
    );
  }
}
