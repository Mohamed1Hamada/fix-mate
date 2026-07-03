import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/components/custom_text_form_field_with_title.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/core/view_models/review_cubit/review_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewSection extends StatelessWidget {
  const AddReviewSection({
    super.key,
    required this.technicianId,
  });

  final String technicianId;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ReviewCubit>();
    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess) {
          CustomQuickAlert.success(
            title: "success".tr(),
            message: "review_added_successfully".tr(),
            animationType: CustomQuickAlertAnimationType.scale,
          );
        } else if (state is AddReviewFailure) {
          CustomQuickAlert.error(
            title: "error".tr(),
            message: state.error,
            animationType: CustomQuickAlertAnimationType.slideInDown,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.rate_review_rounded,
                      color: AppColors.kPrimaryColor),
                ),
                const SizedBox(width: 12),
                Text(
                  "add_review".tr(),
                  style: AppTextStyles.title20BlackBold,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.height * 0.025),
            Center(
              child: BlocBuilder<ReviewCubit, ReviewState>(
                buildWhen: (previous, current) =>
                    current is AddReviewSuccess || current is ReviewInitial,
                builder: (context, state) {
                  return RatingBar.builder(
                    initialRating: cubit.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    unratedColor: Colors.amber.withValues(alpha: 0.2),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      cubit.rating = rating;
                    },
                  );
                },
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.03),
            CustomTextFormFieldWithTitle(
              hintText: "write_your_comment".tr(),
              prefixIcon: Icons.edit_note_rounded,
              maxLines: 3,
              controller: cubit.commentController,
              title: "comment".tr(),
            ),
            SizedBox(height: SizeConfig.height * 0.025),
            BlocBuilder<ReviewCubit, ReviewState>(
              builder: (context, state) {
                return state is AddReviewLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomElevatedButton(
                        name: "submit_review".tr(),
                        onPressed: () {
                          context.read<ReviewCubit>().addReview(technicianId);
                        },
                        width: double.infinity,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
