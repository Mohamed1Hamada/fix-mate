import 'package:easy_localization/easy_localization.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/extensions/app_extensions.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormFieldWithTitle extends StatefulWidget {
  const CustomTextFormFieldWithTitle({
    super.key,
    this.onChanged,
    this.enable = true,
    required this.hintText,
    this.title,
    this.isPassword = false,
    this.controller,
    this.enableValidator = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.keyboardType,
  });
  final String hintText;
  final String? title;
  final TextInputType? keyboardType;
  final bool isPassword, enableValidator;
  final TextEditingController? controller;
  final int maxLines;
  final bool? enable;
  final IconData? prefixIcon;
  final Function(String)? onChanged;
  @override
  State<CustomTextFormFieldWithTitle> createState() =>
      _CustomTextFormFieldWithTitleState();
}

class _CustomTextFormFieldWithTitleState
    extends State<CustomTextFormFieldWithTitle> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.title == null
            ? SizedBox()
            : Text(widget.title!, style: AppTextStyles.title18PrimaryColorW500),
        SizedBox(height: context.screenHeight * 0.003),
        TextFormField(
          style: AppTextStyles.title18Black,
          enabled: widget.enable,
          cursorColor: AppColors.kPrimaryColor,
          controller: widget.controller,
          onChanged: widget.onChanged,
          validator: widget.enableValidator
              ? (value) =>
                  value!.isEmpty ? "field_required".tr(args: [widget.title ?? '']) : null
              : null,
          obscureText: widget.isPassword ? isPassword : false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.transparent,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.screenWidth * 0.03,
              vertical: context.screenHeight * 0.016,
            ),
            prefixIcon: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, color: AppColors.kPrimaryColor),
            hintStyle: AppTextStyles.title16Grey,
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            disabledBorder: buildBorder(),
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPassword = !isPassword;
                      });
                    },
                    icon: Icon(
                      isPassword ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.kPrimaryColor,
                    ),
                  )
                : null,
          ),
          maxLines: widget.maxLines,
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: AppColors.kPrimaryColor),
    );
  }
}
