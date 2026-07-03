import 'package:fixmate/features/customer/nearest_technicians/views/widgets/nearest_technicians_screen_body.dart';
import 'package:fixmate/features/customer/technician_specialties/models/technician_specialtie_model.dart';
import 'package:flutter/material.dart';

class NearestTechniciansScreen extends StatelessWidget {
  const NearestTechniciansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var technicianSpecialtyModel = TechnicianSpecialtyModel.fromJson(args);
    return Scaffold(
      body: NearestTechniciansScreenBody(
          technicianSpecialtyModel: technicianSpecialtyModel),
    );
  }
}

