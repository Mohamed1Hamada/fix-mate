import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/technician_details_screen_body.dart';
import 'package:flutter/material.dart';

class TechnicianDetailsScreen extends StatelessWidget {
  const TechnicianDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var technician = TechnicianModel.fromJson(args);
    return Scaffold(
      body: TechnicianDetailsScreenBody(
        technician: technician,
      ),
    );
  }
}
