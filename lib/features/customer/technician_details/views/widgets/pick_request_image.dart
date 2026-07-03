import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/customer/technician_details/view_models/cubit/technician_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PickRequestImage extends StatelessWidget {
  const PickRequestImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TechnicianRequestCubit>();
    return BlocBuilder<TechnicianRequestCubit, TechnicianRequestState>(
      buildWhen: (previous, current) =>
          current is PickImageLoading ||
          current is PickImageSuccess ||
          current is PickImageFailed,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            cubit.pickRequestImage();
          },
          child: Container(
            width: double.infinity,
            height: SizeConfig.height * 0.23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: cubit.image != null
                  ? Colors.transparent
                  : AppColors.kPrimaryColor.withValues(alpha: 0.05),
              border: cubit.image != null
                  ? Border.all(color: AppColors.kPrimaryColor, width: 2)
                  : Border.all(
                      color: AppColors.kPrimaryColor.withValues(alpha: 0.3),
                      width: 2,
                      style: BorderStyle
                          .solid, // Note: standard Flutter doesn't have easy dashed border without a package, but we can make it look good with opacity
                    ),
              image: cubit.image != null
                  ? DecorationImage(
                      image: FileImage(cubit.image!),
                      fit: BoxFit.cover,
                    )
                  : null,
              boxShadow: cubit.image != null
                  ? [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                  : [],
            ),
            child: cubit.image != null
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                AppColors.kPrimaryColor.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            color: AppColors.kPrimaryColor,
                            size: SizeConfig.height * 0.05,
                          ),
                        ),
                        SizedBox(height: SizeConfig.height * 0.015),
                        Text(
                          "tap_to_upload".tr(),
                          style: AppTextStyles.title16PrimaryColor,
                        ),
                        Text(
                          "image_limit_hint"
                              .tr(), // Suggest adding a key for this if needed
                          style: AppTextStyles.title12Grey,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
