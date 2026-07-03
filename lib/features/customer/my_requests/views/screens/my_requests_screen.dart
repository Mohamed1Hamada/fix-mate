import 'package:fixmate/features/customer/my_requests/views/widgets/my_requests_screen_body.dart';
import 'package:flutter/material.dart';

class MyRequestsScreen extends StatelessWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyRequestsScreenBody(),
    );
  }
}
