import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_specialties/view_models/cubit/technicians_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FindNearestButton extends StatelessWidget {
  const FindNearestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechniciansCubit, TechniciansState>(
      buildWhen: (previous, current) => current is TechnicianSelected,
      builder: (context, state) {
        var cubit = context.read<TechniciansCubit>();
        return cubit.selectedTechnicianSpecialty == null
            ? const SizedBox()
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.width * 0.03,
                ),
                child: CustomElevatedButton(
                    width: double.infinity,
                    hPadding: SizeConfig.height * 0.02,
                    name: "find_nearest".tr(),
                    onPressed: () {
                      log(cubit.selectedTechnicianSpecialty!.toJson().toString());
                      context.pushScreen(
                        RouteNames.nearestTechniciansScreen,
                        arguments: cubit.selectedTechnicianSpecialty!.toJson(),
                      );
                    }),
              );
      },
    );
  }
}
