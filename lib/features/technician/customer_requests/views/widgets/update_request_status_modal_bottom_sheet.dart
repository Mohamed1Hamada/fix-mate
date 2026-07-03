import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/technician/customer_requests/models/technician_requests_model.dart';
import 'package:fixmate/features/technician/customer_requests/view_models/cubit/update_request_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateRequestStatusModalBottomSheet extends StatelessWidget {
  const UpdateRequestStatusModalBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UpdateRequestStatusCubit>();
    return BlocListener<UpdateRequestStatusCubit, UpdateRequestStatusState>(
      listener: (context, state) {
        if (state is UpdateRequestStatusSuccess) {
          context.popScreen();
          CustomQuickAlert.success(
            animationType: CustomQuickAlertAnimationType.scale,
            message: "update_status_success".tr(),
            title: "success".tr(),
          );
        }
        if (state is UpdateRequestStatusError) {
          CustomQuickAlert.error(
            animationType: CustomQuickAlertAnimationType.scale,
            message: state.message,
            title: "error".tr(),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.width * 0.05,
          SizeConfig.height * 0.05,
          SizeConfig.width * 0.05,
          SizeConfig.height * 0.05,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: SizeConfig.width * 0.1,
                height: SizeConfig.height * 0.002,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            // Title
            Text('update_request_status'.tr(),
                style: AppTextStyles.title20PrimaryColorW500),
            SizedBox(height: SizeConfig.height * 0.02),
            const Divider(),
            SizedBox(height: SizeConfig.height * 0.02),
            BlocBuilder<UpdateRequestStatusCubit, UpdateRequestStatusState>(
              buildWhen: (previous, current) => current is UpdateSelectedStatus,
              builder: (context, state) {
                return Column(
                  children: RequestStatus.values.map(
                    (status) {
                      final isSelected = cubit.status == status;
                      return CustomRequestStatusCard(
                        isSelected: isSelected,
                        status: status.name.tr(),
                        onTap: () {
                          log(status.name);
                          cubit.updateStatus(status: status);
                        },
                      );
                    },
                  ).toList(),
                );
              },
            ),
            BlocBuilder<UpdateRequestStatusCubit, UpdateRequestStatusState>(
              buildWhen: (previous, current) =>
                  current is UpdateSelectedStatus ||
                  previous is UpdateRequestStatusLoading ||
                  current is UpdateRequestStatusLoading,
              builder: (context, state) {
                if (state is UpdateSelectedStatus) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: SizeConfig.height * 0.02,
                    ),
                    child: CustomElevatedButton(
                      name: "update".tr(),
                      width: double.infinity,
                      hPadding: SizeConfig.height * 0.02,
                      onPressed: () {
                        context
                            .read<UpdateRequestStatusCubit>()
                            .updateRequestStatus();
                      },
                    ),
                  );
                }
                if (state is UpdateRequestStatusLoading) {
                  return const CircularProgressIndicator();
                }
                return SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}

class CustomRequestStatusCard extends StatelessWidget {
  const CustomRequestStatusCard({
    super.key,
    required this.isSelected,
    this.onTap,
    required this.status,
  });

  final bool isSelected;
  final String status;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.01),
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.height * 0.015,
          horizontal: SizeConfig.width * 0.04,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryColor : Colors.grey.shade300,
          ),
          color: isSelected
              ? AppColors.kPrimaryColor.withValues(alpha: 0.08)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                status,
                style: isSelected
                    ? AppTextStyles.title16BlackBold
                    : AppTextStyles.title16Black54,
              ),
            ),
            if (isSelected)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: SizeConfig.height * 0.02,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
