import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_text_form_field_with_title.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/features/customer/technician_details/view_models/cubit/technician_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTechnicianRequestForm extends StatelessWidget {
  const AddTechnicianRequestForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TechnicianRequestCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFormFieldWithTitle(
            hintText: "request_title_hint".tr(),
            prefixIcon: Icons.title,
            title: "request_title".tr(),
            controller: cubit.titleController,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          CustomTextFormFieldWithTitle(
            hintText: "request_desc_hint".tr(),
            prefixIcon: Icons.description,
            maxLines: 3,
            controller: cubit.descriptionController,
            title: "request_desc".tr(),
          ),
          SizedBox(height: SizeConfig.height * 0.02),
          Text(
            "request_date_time".tr(),
            style: AppTextStyles.title16BlackW500,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          BlocBuilder<TechnicianRequestCubit, TechnicianRequestState>(
            builder: (context, state) {
              final isSelected =
                  cubit.selectedDate != null && cubit.selectedTime != null;
              final dateText = isSelected
                  ? "${DateFormat.yMd(context.locale.languageCode).format(cubit.selectedDate!)} - ${cubit.selectedTime!.format(context)}"
                  : "select_date_time".tr();
              return GestureDetector(
                onTap: () {
                  cubit.pickRequestDate(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.04,
                    vertical: SizeConfig.height * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Light input background
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.kPrimaryColor
                          : Colors.grey.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: isSelected
                            ? AppColors.kPrimaryColor
                            : Colors.grey[400],
                        size: 20,
                      ),
                      SizedBox(width: SizeConfig.width * 0.03),
                      Text(
                        dateText,
                        style: AppTextStyles.title16BlackW500.copyWith(
                          color: isSelected ? Colors.black : Colors.grey[500],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: Colors.black.withValues(alpha: 0.2),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
