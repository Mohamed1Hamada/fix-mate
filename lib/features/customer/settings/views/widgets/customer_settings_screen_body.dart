import 'package:easy_localization/easy_localization.dart';
import 'package:custom_quick_alert/custom_quick_alert.dart';
import 'package:fixmate/core/app_route/route_names.dart';
import 'package:fixmate/core/cache/cache_helper.dart';
import 'package:fixmate/core/components/custom_elevated_button.dart';
import 'package:fixmate/core/di/dependancy_injection.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/customer/my_chats/views/widgets/customer_header.dart';
import 'package:fixmate/features/customer/settings/views/widgets/profile_header.dart';
import 'package:fixmate/features/customer/settings/views/widgets/settings_list.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CustomerSettingsScreenBody extends StatefulWidget {
  const CustomerSettingsScreenBody({
    super.key,
  });

  @override
  State<CustomerSettingsScreenBody> createState() =>
      _CustomerSettingsScreenBodyState();
}

class _CustomerSettingsScreenBodyState
    extends State<CustomerSettingsScreenBody> {
  @override
  Widget build(BuildContext context) {
    var customerModel = getIt<CacheHelper>().getUserModel();
    return SafeArea(
      child: Column(
        children: [
          CustomHeader(
            icon: Icons.settings_outlined,
            title: "settings".tr(),
          ),
          SizedBox(height: SizeConfig.height * 0.03),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                customerModel = getIt<CacheHelper>().getUserModel();
                setState(() {});
              },
              backgroundColor: AppColors.kPrimaryColor,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.03,
                  ),
                  child: Column(
                    children: [
                      ProfileHeader(
                        customerModel: customerModel!,
                      ),
                      SizedBox(height: SizeConfig.height * 0.02),
                      const SettingsList(),
                      SizedBox(height: SizeConfig.height * 0.02),
                      CustomElevatedButton(
                        name: 'logout'.tr(),
                        width: double.infinity,
                        hPadding: SizeConfig.width * 0.03,
                        onPressed: () async {
                          await signOut(context);
                        },
                      ),
                      SizedBox(height: SizeConfig.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut(BuildContext context) async {
    await getIt<SupabaseClient>().auth.signOut();
    context.pushAndRemoveUntilScreen(RouteNames.signInScreen);
    CustomQuickAlert.success(
      title: 'success'.tr(),
      message: 'logout_success'.tr(),
      animationType: CustomQuickAlertAnimationType.scale,
    );
  }
}
