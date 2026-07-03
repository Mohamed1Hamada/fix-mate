import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_specialties/views/widgets/find_nearest_button.dart';
import 'package:fixmate/features/customer/technician_specialties/views/widgets/technician_header.dart';
import 'package:fixmate/features/customer/technician_specialties/views/widgets/technician_search_field.dart';
import 'package:fixmate/features/customer/technician_specialties/views/widgets/technician_specialties_grid_view.dart';
import 'package:flutter/material.dart';

class TechnicianSpecialtiesBody extends StatelessWidget {
  const TechnicianSpecialtiesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TechnicianHeader(),
          SizedBox(height: SizeConfig.height * 0.02),
          const TechnicianSearchField(),
          SizedBox(height: SizeConfig.height * 0.03),
          const Expanded(child: TechnicianSpecialtiesGridView()),
          SizedBox(height: SizeConfig.height * 0.02),
          const FindNearestButton(),
          SizedBox(height: SizeConfig.height * 0.02),
        ],
      ),
    );
  }
}

