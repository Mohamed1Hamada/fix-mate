import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/customer/nearest_technicians/view_models/cubit/nearest_technicians_cubit.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/nearest_technician_list_view.dart';
import 'package:fixmate/features/customer/nearest_technicians/views/widgets/search_field.dart';
import 'package:fixmate/features/customer/technician_specialties/models/technician_specialtie_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearestTechniciansScreenBody extends StatelessWidget {
  const NearestTechniciansScreenBody({
    super.key,
    required this.technicianSpecialtyModel,
  });

  final TechnicianSpecialtyModel technicianSpecialtyModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NearestTechniciansCubit()
        ..getTechnicians(technicianSpecialtyId: technicianSpecialtyModel.id),
      child: SafeArea(
          child: Column(
        children: [
          CustomHeader(
            icon: Icons.location_on_outlined,
            title: "nearest_technicians".tr(),
          ),
          SizedBox(height: SizeConfig.height * 0.02),
          const SearchForTechnicians(),
          SizedBox(height: SizeConfig.height * 0.01),
          NearestTechnicianListView()
        ],
      )),
    );
  }
}
