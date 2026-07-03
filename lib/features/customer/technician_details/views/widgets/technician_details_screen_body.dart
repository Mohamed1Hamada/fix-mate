import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/auth/sign_in/models/technician_model.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/customer/technician_details/view_models/cubit/technician_request_cubit.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/add_technician_request_modal_bottom_sheet.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/contact_with_technician.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/technician_image.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/technician_info_row.dart';
import 'package:fixmate/features/customer/technician_details/views/widgets/add_review_section.dart';
import 'package:fixmate/core/components/review_list_item.dart';
import 'package:fixmate/core/view_models/review_cubit/review_cubit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianDetailsScreenBody extends StatelessWidget {
  const TechnicianDetailsScreenBody({
    super.key,
    required this.technician,
  });
  final TechnicianModel technician;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit()..fetchReviews(technician.id),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomHeader(
            icon: Icons.person,
            title: "technician_details".tr(),
          ),
          SizedBox(height: SizeConfig.height * 0.02),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TechnicianImage(technicianImage: technician.image),
                  SizedBox(height: SizeConfig.height * 0.035),
                  ContactWithTechnician(
                    technicianId: technician.id,
                    technicianPhoneNumber: technician.phoneNumber,
                  ),
                  SizedBox(height: SizeConfig.height * 0.035),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.width * 0.03,
                    ),
                    child: Column(
                      children: [
                        TechnicianInfoRow(
                          icon: Icons.person,
                          title: "name".tr(),
                          value: technician.fullName,
                        ),
                        TechnicianInfoRow(
                          icon: Icons.email,
                          title: "email".tr(),
                          value: technician.email,
                        ),
                        TechnicianInfoRow(
                          icon: Icons.phone,
                          title: "phone_number".tr(),
                          value: technician.phoneNumber,
                        ),
                        TechnicianInfoRow(
                          icon: Icons.event_available,
                          title: "availability".tr(),
                          value: technician.isAvailable
                              ? "available".tr()
                              : "not_available".tr(),
                        ),
                        TechnicianInfoRow(
                          icon: Icons.location_on,
                          title: "distance".tr(),
                          value: technician.distance != null
                              ? '${technician.distance!.toStringAsFixed(4)} km'
                              : 'N/A',
                        ),
                        TechnicianInfoRow(
                          icon: Icons.star,
                          title: "rating".tr(),
                          value: "${technician.rating.toStringAsFixed(1)} ⭐ ",
                        ),
                        SizedBox(height: SizeConfig.height * 0.03),
                        CustomElevatedButton(
                          name: "request_now".tr(),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) {
                                return BlocProvider(
                                  create: (context) => TechnicianRequestCubit(
                                      technician: technician),
                                  child: const AddTechnicianRequestModalBottomSheet(),
                                );
                              },
                            );
                          },
                          width: double.infinity,
                          hPadding: SizeConfig.height * 0.02,
                        ),
                        SizedBox(height: SizeConfig.height * 0.04),
                        const Divider(),
                        SizedBox(height: SizeConfig.height * 0.02),
                        AddReviewSection(technicianId: technician.id),
                        SizedBox(height: SizeConfig.height * 0.04),
                        const Divider(),
                        SizedBox(height: SizeConfig.height * 0.02),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "reviews".tr(),
                            style: AppTextStyles.title20BlackBold,
                          ),
                        ),
                        SizedBox(height: SizeConfig.height * 0.02),
                        BlocBuilder<ReviewCubit, ReviewState>(
                          buildWhen: (previous, current) =>
                              current is FetchReviewsSuccess ||
                              current is FetchReviewsLoading ||
                              current is FetchReviewsFailure,
                          builder: (context, state) {
                            if (state is FetchReviewsLoading) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is FetchReviewsSuccess) {
                              if (state.reviews.isEmpty) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(Icons.rate_review_outlined, 
                                          size: 48, color: Colors.grey[400]),
                                      const SizedBox(height: 12),
                                      Text(
                                        "no_reviews_yet".tr(),
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.title14Grey,
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.reviews.length,
                                itemBuilder: (context, index) {
                                  return ReviewListItem(review: state.reviews[index])
                                      .animate()
                                      .fadeIn(duration: 500.ms, delay: (index * 100).ms)
                                      .slideX(begin: 0.2, end: 0);
                                },
                              );
                            } else if (state is FetchReviewsFailure) {
                              return Center(child: Text(state.error));
                            }
                            return const SizedBox();
                          },
                        ),
                        SizedBox(height: SizeConfig.height * 0.04),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
