import 'dart:developer';

import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:fixmate/features/technician/request_details/views/widgets/customer_request_detail_screen_body.dart';
import 'package:flutter/material.dart';

class CustomerRequestDetailScreen extends StatelessWidget {
  const CustomerRequestDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var request = TechnicianRequestModel.fromJson(args);
    log(request.toJson().toString());
    return Scaffold(
      body: CustomerRequestDetailScreenBody(request: request),
    );
  }
}

