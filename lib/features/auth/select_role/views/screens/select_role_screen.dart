import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/utilies/assets/images/app_images.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:fixmate/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:flutter/material.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.width;
    final height = SizeConfig.height;

    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            children: [
              const Spacer(),

              /// Logo
              Image.asset(
                AppImages.logoImage,
                width: width * 0.6,
                fit: BoxFit.contain,
              ),

              SizedBox(height: height * 0.05),

              /// 🧑‍💼 Customer
              RoleCard(
                image: AppImages.userImage,
                subtitle: "find_expert".tr(),
                title: 'as_customer'.tr(),
                isSelected: selectedRole == "user",
                onTap: () => setState(() => selectedRole = "user"),
              ),

              SizedBox(height: height * 0.03),

              /// 🔧 Technician
              RoleCard(
                image: AppImages.technicianImage,
                subtitle: "ready_to_fix".tr(),
                title: 'as_technician'.tr(),
                isSelected: selectedRole == "technician",
                onTap: () => setState(() => selectedRole = "technician"),
              ),

              const Spacer(),

              /// Continue button appears dynamically
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: selectedRole != null
                    ? Padding(
                        padding: EdgeInsets.only(bottom: height * 0.03),
                        child: CustomElevatedButton(
                          key: const ValueKey("continue_button"),
                          name: "continue".tr(),
                          onPressed: () {
                            final cache = getIt<CacheHelper>();
                            if (selectedRole == "user") {
                              cache.saveData(
                                  key: "role", value: UserRole.customer.name);
                            } else {
                              cache.saveData(
                                  key: "role", value: UserRole.technician.name);
                            }
                            context
                                .pushReplacementScreen(RouteNames.signUpScreen);
                          },
                          hPadding: height * 0.02,
                          width: double.infinity,
                        ),
                      )
                    : SizedBox(height: height * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  const RoleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String image;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final width = SizeConfig.width;
    final height = SizeConfig.height;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          vertical: height * 0.02,
          horizontal: width * 0.04,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.kPrimaryColor.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(width * 0.06),
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryColor : Colors.grey.shade300,
            width: width * 0.005,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.25),
                blurRadius: width * 0.03,
                offset: Offset(0, height * 0.005),
              ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              width: width * 0.22,
              fit: BoxFit.contain,
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.title20kPrimaryColorBold.copyWith(
                      color:
                          isSelected ? AppColors.kPrimaryColor : Colors.black,
                      fontSize: width * 0.05,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  Text(
                    subtitle,
                    style: AppTextStyles.title16Black.copyWith(
                      fontSize: width * 0.04,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
