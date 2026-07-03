import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/technician/technician_profile/views/widgets/info_card.dart';
import 'package:fixmate/core/components/review_list_item.dart';
import 'package:fixmate/core/view_models/review_cubit/review_cubit.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';

class TechnicianProfileScreen extends StatelessWidget {
  const TechnicianProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt<CacheHelper>().getUserModel()!;
    final technician = getIt<CacheHelper>().getTechnicianModel();
    final technicianId = technician?.id ?? user.id;

    return BlocProvider(
      create: (context) => ReviewCubit()..fetchReviews(technicianId),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CustomHeader(title: "profile".tr(), icon: Icons.person),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: SizeConfig.height * 0.02),
            ),
            // Hero background with gradient and avatar
            SliverToBoxAdapter(
              child: Hero(
                tag: 'user_avatar',
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.kPrimaryColor,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: user.image.isNotEmpty
                        ? NetworkImage(user.image)
                        : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 20), // Space for overlapping avatar
            ),
            // User name and handle with subtle shadow
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      user.fullName,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kPrimaryColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@${user.userName}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Rating Section - Premium Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: AppColors.kPrimaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                getIt<CacheHelper>()
                                        .getTechnicianModel()
                                        ?.rating
                                        .toStringAsFixed(1) ??
                                    "0.0",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.kPrimaryColor,
                                ),
                              ),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    Icons.star_rounded,
                                    color: index <
                                            (getIt<CacheHelper>()
                                                    .getTechnicianModel()
                                                    ?.rating ??
                                                0)
                                        ? Colors.amber
                                        : Colors.grey[300],
                                    size: 16,
                                  );
                                }),
                              ),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color:
                                AppColors.kPrimaryColor.withValues(alpha: 0.2),
                          ),
                          // Reviews Summary
                          Column(
                            children: [
                              Icon(Icons.forum_rounded,
                                  color: AppColors.kPrimaryColor),
                              const SizedBox(height: 4),
                              BlocBuilder<ReviewCubit, ReviewState>(
                                builder: (context, state) {
                                  int count = 0;
                                  if (state is FetchReviewsSuccess) {
                                    count = state.reviews.length;
                                  }
                                  return Text(
                                    "$count ${"reviews".tr()}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ).animate().fadeIn().scale(delay: 200.ms),
                    ),
                    const SizedBox(height: 24),
                    // Profile completion badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: user.isCompleteProfile
                            ? Colors.green[50]
                            : Colors.red[50],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: user.isCompleteProfile
                              ? Colors.green
                              : Colors.red,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            user.isCompleteProfile
                                ? Icons.check_circle
                                : Icons.warning,
                            size: 16,
                            color: user.isCompleteProfile
                                ? Colors.green
                                : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            user.isCompleteProfile
                                ? 'profile_complete'.tr()
                                : 'profile_incomplete'.tr(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: user.isCompleteProfile
                                  ? Colors.green[700]
                                  : Colors.red[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Info sections with modern cards
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            SliverToBoxAdapter(
              child: InfoCard(user: user),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
            // ✅ زر عرض التقييمات - يفتح BottomSheet
            SliverToBoxAdapter(
              child: Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: BlocBuilder<ReviewCubit, ReviewState>(
                      builder: (context, state) {
                        int reviewsCount = 0;
                        if (state is FetchReviewsSuccess) {
                          reviewsCount = state.reviews.length;
                        }

                        return InkWell(
                          onTap: () => _showReviewsBottomSheet(
                            context,
                            technicianId,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.kPrimaryColor
                                    .withValues(alpha: 0.2),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    Icons.rate_review_rounded,
                                    color: AppColors.kPrimaryColor,
                                    size: 26,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "reviews".tr(),
                                        style: AppTextStyles.title20BlackBold,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "$reviewsCount ${"reviews".tr()}",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.kPrimaryColor,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn(duration: 500.ms).slideY(
                              begin: 0.2,
                              end: 0,
                            );
                      },
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ دالة عرض التقييمات في BottomSheet
  void _showReviewsBottomSheet(BuildContext context, String technicianId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BlocProvider(
          create: (context) => ReviewCubit()..fetchReviews(technicianId),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                // Title
                Text(
                  "reviews".tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Reviews List
                Expanded(
                  child: BlocBuilder<ReviewCubit, ReviewState>(
                    builder: (context, state) {
                      if (state is FetchReviewsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FetchReviewsSuccess) {
                        if (state.reviews.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.reviews_outlined,
                                    size: 60,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "no_reviews_yet".tr(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          itemCount: state.reviews.length,
                          itemBuilder: (context, index) {
                            return ReviewListItem(
                              review: state.reviews[index],
                            )
                                .animate()
                                .fadeIn(
                                  duration: 400.ms,
                                  delay: (index * 80).ms,
                                )
                                .slideX(begin: 0.2, end: 0);
                          },
                        );
                      } else if (state is FetchReviewsFailure) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              state.error,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red[600]),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
