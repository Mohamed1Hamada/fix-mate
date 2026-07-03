import 'package:easy_localization/easy_localization.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:fixmate/core/components/custom_text_form_field.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/nearest_technicians/view_models/cubit/nearest_technicians_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchForTechnicians extends StatelessWidget {
  const SearchForTechnicians({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.04,
      ),
      child: CustomTextFormField(
        hintText: "search_technicians".tr(),
        prefixIcon: Icons.search,
        onChanged: (value) => EasyDebounce.debounce(
          'search-nearest-technicians',
          const Duration(milliseconds: 300),
          () {
            context.read<NearestTechniciansCubit>().searchTechnicians(value);
          },
        ),
      ),
    );
  }
}
