import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/features/customer/settings/views/widgets/setting_list_tile.dart';
import 'package:fixmate/features/technician/technician_profile/views/screens/technician_profile_screen.dart';
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsListTile(
          icon: Icons.edit,
          title: 'edit_profile'.tr(),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TechnicianProfileScreen()));
            // context.pushScreen(RouteNames.editCustomerProfileScreen);
          },
        ),
        SettingsListTile(
          icon: Icons.contact_phone_outlined,
          title: 'contact_us'.tr(),
          onTap: () {},
        ),
        SettingsListTile(
          icon: Icons.notifications_outlined,
          title: 'notifications'.tr(),
          onTap: () {},
        ),
        SettingsListTile(
          icon: Icons.language_outlined,
          title: 'language'.tr(),
          onTap: () {
            _showLanguageDialog(context);
          },
        ),
        SettingsListTile(
          icon: Icons.help_outline,
          title: 'help_support'.tr(),
          onTap: () {},
        ),
        SettingsListTile(
          icon: Icons.privacy_tip_outlined,
          title: 'privacy_policy'.tr(),
          onTap: () {},
        ),
      ],
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('select_language'.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('english'.tr()),
              onTap: () {
                context.setLocale(const Locale('en'));
                Navigator.pop(context);
              },
              trailing: context.locale == const Locale('en') ? const Icon(Icons.check, color: Colors.green) : null,
            ),
            ListTile(
              title: Text('arabic'.tr()),
              onTap: () {
                context.setLocale(const Locale('ar'));
                Navigator.pop(context);
              },
              trailing: context.locale == const Locale('ar') ? const Icon(Icons.check, color: Colors.green) : null,
            ),
          ],
        ),
      ),
    );
  }
}
