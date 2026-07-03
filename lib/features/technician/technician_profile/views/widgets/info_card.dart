import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/features/auth/sign_in/models/user_model.dart';
import 'package:fixmate/features/technician/technician_profile/views/widgets/info_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.user
  });

  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width*0.03),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            // Email
            InfoTile(
              icon: Icons.email_outlined,
              label: 'Email',
              value: user.email,
              trailingIcon: Icons.copy,
              onTrailingTap: () {},
            ),
            Divider(height: 1, color: Colors.grey[200]),
            // Phone
            InfoTile(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: user.phoneNumber,
              trailingIcon: Icons.phone,
              onTrailingTap: () {},
            ),
            Divider(height: 1, color: Colors.grey[200]),
            // Role
            InfoTile(
              icon: Icons.badge_outlined,
              label: 'Role',
              value: user.role,
            ),
            Divider(height: 1, color: Colors.grey[200]),
            // Joined Date
            if (user.createdAt != null)
              InfoTile(
                icon: Icons.calendar_today_outlined,
                label: 'Joined',
                value: DateFormat.yMMMMd().format(user.createdAt!),
              ),
          ],
        ),
      ),
    );
  }
}
