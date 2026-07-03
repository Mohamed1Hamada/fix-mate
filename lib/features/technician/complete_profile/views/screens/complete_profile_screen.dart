import 'package:easy_localization/easy_localization.dart';
import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/components/custom_circular_progress_indecator.dart';
import 'package:fixmate/core/components/custom_drop_down_button_form_field.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/assets/images/app_images.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/technician/complete_profile/view_models/cubit/complete_technician_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteTechnicianProfileScreen extends StatelessWidget {
  const CompleteTechnicianProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CompleteTechnicianProfileCubit>();
    return Scaffold(
      body: CompleteTechnicianProfileScreenBody(cubit: cubit),
    );
  }
}

class CompleteTechnicianProfileScreenBody extends StatelessWidget {
  const CompleteTechnicianProfileScreenBody({
    super.key,
    required this.cubit,
  });

  final CompleteTechnicianProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteTechnicianProfileCubit,
        CompleteTechnicianProfileState>(
      listener: (context, state) {
        if (state is LocationNotSelected) {
          CustomQuickAlert.warning(
            title: 'warning'.tr(),
            message: "select_location_msg".tr(),
            animationType: CustomQuickAlertAnimationType.slideInDown,
          );
        }
        if (state is TechnicianSpecialtyNotSelected) {
          CustomQuickAlert.warning(
            title: 'warning'.tr(),
            message: "select_specialty_msg".tr(),
            animationType: CustomQuickAlertAnimationType.slideInDown,
          );
        }
        if (state is PermissionNotGranted) {
          CustomQuickAlert.warning(
            title: 'warning'.tr(),
            message: "grant_permission_msg".tr(),
            animationType: CustomQuickAlertAnimationType.slideInDown,
          );
        }
        if (state is GetLocationSuccess) {
          CustomQuickAlert.success(
            title: 'success'.tr(),
            message: "location_success".tr(),
            animationType: CustomQuickAlertAnimationType.scale,
          );
        }
        if (state is CompleteTechnicianProfileSuccess) {
          context.pushReplacementScreen(RouteNames.technicianHomeScreen);
          CustomQuickAlert.success(
            title: 'success'.tr(),
            message: "profile_complete_success".tr(),
            animationType: CustomQuickAlertAnimationType.scale,
          );
        }
        if (state is GetLocationError) {
          CustomQuickAlert.error(
            title: 'Error',
            message: state.message,
            animationType: CustomQuickAlertAnimationType.slideInDown,
          );
        }
        if (state is CompleteTechnicianProfileError) {
          CustomQuickAlert.error(
            title: 'error'.tr(),
            message: state.message,
            animationType: CustomQuickAlertAnimationType.slideInDown,
          );
        }
      },
      child: Column(
        children: [
          CustomHeader(icon: Icons.person, title: "complete_profile".tr()),
          SizedBox(height: SizeConfig.height * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppImages.logoImage,
                  height: SizeConfig.height * 0.2,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Center(
                  child: Text(
                    "complete_profile_desc".tr(),
                    style: AppTextStyles.title16PrimaryColorW500,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: SizeConfig.height * 0.03),
                BlocBuilder<CompleteTechnicianProfileCubit,
                    CompleteTechnicianProfileState>(
                  buildWhen: (previous, current) =>
                      current is GetTechnicianSpecialtiesLoading ||
                      previous is GetTechnicianSpecialtiesLoading,
                  builder: (context, state) {
                    return state is GetTechnicianSpecialtiesLoading
                        ? CustomCircularProgresIndecator()
                        : CustomDropDownButtonFormField(
                            items: cubit.technicianSpecialties,
                            itemLabelBuilder: (item) => item.name,
                            title: "tech_specialty".tr(),
                            hintText: "select_specialty".tr(),
                            onChanged: (value) {
                              cubit.selectedTechnicianSpecialty = value;
                            },
                          );
                  },
                ),
                SizedBox(height: SizeConfig.height * 0.02),
                Text(
                  "select_location".tr(),
                  style: AppTextStyles.title18PrimaryColorW500,
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                BlocBuilder<CompleteTechnicianProfileCubit,
                    CompleteTechnicianProfileState>(
                  buildWhen: (previous, current) =>
                      current is GetLocationLoading ||
                      previous is GetLocationLoading,
                  builder: (context, state) {
                    return state is GetLocationLoading
                        ? CustomCircularProgresIndecator()
                        : CustomElevatedButton(
                            name: "select_current_location".tr(),
                            width: double.infinity,
                            hPadding: SizeConfig.width * 0.04,
                            backgroundColor: AppColors.kBackgroundColor,
                            textStyle: AppTextStyles.title18PrimaryColorW500,
                            onPressed: () {
                              cubit.pickLocation();
                            },
                          );
                  },
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                CustomElevatedButton(
                  name: "select_location_map".tr(),
                  width: double.infinity,
                  backgroundColor: AppColors.kBackgroundColor,
                  textStyle: AppTextStyles.title18PrimaryColorW500,
                  hPadding: SizeConfig.width * 0.04,
                  onPressed: () {},
                ),
                SizedBox(height: SizeConfig.height * 0.05),
                BlocBuilder<CompleteTechnicianProfileCubit,
                    CompleteTechnicianProfileState>(
                  buildWhen: (previous, current) =>
                      current is CompleteTechnicianProfileLoading ||
                      previous is CompleteTechnicianProfileLoading,
                  builder: (context, state) {
                    return state is CompleteTechnicianProfileLoading
                        ? CustomCircularProgresIndecator()
                        : CustomElevatedButton(
                            name: "save".tr(),
                            width: double.infinity,
                            hPadding: SizeConfig.width * 0.04,
                            onPressed: () {
                              cubit.completeTechnicianProfile();
                            },
                          );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
