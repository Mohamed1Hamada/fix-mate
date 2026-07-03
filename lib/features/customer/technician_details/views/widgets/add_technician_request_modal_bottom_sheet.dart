import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_blur_title.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/technician_details/view_models/cubit/technician_request_cubit.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/add_technician_request_button.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/add_technician_request_form.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/pick_request_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTechnicianRequestModalBottomSheet extends StatelessWidget {
  const AddTechnicianRequestModalBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<TechnicianRequestCubit, TechnicianRequestState>(
      listener: (context, state) {
        if (state is ImageNotSelected) {
          CustomQuickAlert.warning(
            animationType: CustomQuickAlertAnimationType.scale,
            message: "please_select_image".tr(),
            title: "warning".tr(),
          );
        }
        if (state is PickImageFailed) {
          CustomQuickAlert.error(
            animationType: CustomQuickAlertAnimationType.scale,
            message: state.error,
            title: "error".tr(),
          );
        }
        if (state is AddTechnicianRequestFailed) {
          CustomQuickAlert.error(
            animationType: CustomQuickAlertAnimationType.scale,
            message: state.error,
            title: "error".tr(),
          );
        }
        if (state is AddTechnicianRequestSuccess) {
          context.popScreen();
          CustomQuickAlert.success(
            animationType: CustomQuickAlertAnimationType.scale,
            message: "request_added_success".tr(),
            title: "success".tr(),
          );
        }
      },
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white, // Light background
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                // Modal Handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width * 0.05,
                          vertical: SizeConfig.height * 0.01,
                        ),
                        child: Column(
                          children: [
                            CustomBlurTitle(
                              title: "request_details".tr(),
                              icon: Icons.receipt_long_rounded,
                            ),
                            SizedBox(height: SizeConfig.height * 0.04),
                            const PickRequestImage(),
                            SizedBox(height: SizeConfig.height * 0.03),
                            const AddTechnicianRequestForm(),
                            SizedBox(height: SizeConfig.height * 0.05),
                            const AddTechnicianRequestButton(),
                            SizedBox(height: SizeConfig.height * 0.03),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
