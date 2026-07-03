import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/core/models/review_model.dart';
import 'package:flutter/material.dart';

class ReviewListItem extends StatelessWidget {
  const ReviewListItem({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                      width: 2),
                ),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      AppColors.kPrimaryColor.withValues(alpha: 0.1),
                  backgroundImage: review.customer?.image != null &&
                          review.customer!.image.isNotEmpty
                      ? NetworkImage(review.customer!.image)
                      : null,
                  child: review.customer?.image == null ||
                          review.customer!.image.isEmpty
                      ? Icon(Icons.person, color: AppColors.kPrimaryColor)
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.customer?.fullName ?? "Unknown User",
                      style: AppTextStyles.title16BlackW500
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      DateFormat.yMMMd(context.locale.languageCode)
                          .format(review.createdAt),
                      style: AppTextStyles.title12Grey,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (review.comment != null && review.comment!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                review.comment!,
                style: AppTextStyles.title14BlackColorW400.copyWith(
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
