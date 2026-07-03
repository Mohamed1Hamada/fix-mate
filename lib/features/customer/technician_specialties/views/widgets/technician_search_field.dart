import 'package:easy_localization/easy_localization.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fixmate/core/components/custom_text_form_field.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_specialties/view_models/cubit/technicians_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianSearchField extends StatelessWidget {
  const TechnicianSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TechniciansCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.03,
      ),
      child: CustomTextFormField(
        prefixIcon: Icons.search,
        hintText: 'search_technicians'.tr(),
        onChanged: (value) {
          EasyDebounce.debounce(
            'search-technicians-specialties',
            const Duration(milliseconds: 300),
            () => cubit.searchTechnicians(value),
          );
        },
      ),
    );
  }
}
