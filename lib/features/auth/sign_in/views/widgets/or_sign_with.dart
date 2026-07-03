import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';


import 'package:flutter/material.dart';

class OrSignWith extends StatelessWidget {
  const OrSignWith({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 0.025,
        horizontal: SizeConfig.width * 0.05,
      ),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.05,
            ),
            child: Text(
              "or_sign_with".tr(),
              style: AppTextStyles.title18BlackW500,
            ),
          ),
          const Expanded(
            child: Divider(
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
