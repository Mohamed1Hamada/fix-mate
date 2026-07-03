import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_specialties/view_models/cubit/technicians_cubit.dart';
import 'package:fixmate/features/customer/technician_specialties/views/widgets/technician_specialty_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianSpecialtiesGridView extends StatelessWidget {
  const TechnicianSpecialtiesGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechniciansCubit, TechniciansState>(
      builder: (context, state) {
        final cubit = context.read<TechniciansCubit>();
        final technicians = cubit.filteredTechnicians;
        final selectedTech = cubit.selectedTechnicianSpecialty;

        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: technicians.length,
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.03),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: SizeConfig.height * 0.015,
            crossAxisSpacing: SizeConfig.width * 0.04,
            childAspectRatio: 0.78,
          ),
          itemBuilder: (context, index) {
            final tech = technicians[index];
            final isSelected = selectedTech?.name == tech.name;
            return TechnicianSpecialtyCard(
              tech: tech,
              isSelected: isSelected,
              onTap: () => cubit.selectTechnician(tech),
            );
          },
        );
      },
    );
  }
}
