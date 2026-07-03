import 'package:flutter/material.dart';
import 'package:fixmate/core/utilies/colors/app_colors.dart';
import 'package:fixmate/core/utilies/sizes/sized_config.dart';
import 'package:fixmate/core/utilies/styles/app_text_styles.dart';

class CustomDropDownButtonFormField<T> extends StatelessWidget {
  const CustomDropDownButtonFormField({
    super.key,
    required this.items,
    this.controller,
    this.hintText,
    this.title,
    this.onChanged,
    this.fillColor,
    this.itemLabelBuilder,
    this.value,
  });

  final List<T> items;
  final T? value; // ✅ دي هي القيمة المختارة حاليًا

  final TextEditingController? controller;
  final String? hintText;
  final String? title;
  final Function(T?)? onChanged;
  final Color? fillColor;

  final String Function(T)? itemLabelBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title!, style: AppTextStyles.title18PrimaryColorW500),
        SizedBox(height: SizeConfig.height * 0.003),
        DropdownButtonFormField<T>(
          initialValue: value, // ✅ القيمة المختارة
          items: items
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e, // ✅ هنا العنصر نفسه
                  child: Text(
                    itemLabelBuilder != null
                        ? itemLabelBuilder!(e)
                        : e.toString(),
                    style: AppTextStyles.title18White70,
                  ),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (controller != null) {
              controller!.text = val.toString();
            }
            if (onChanged != null) onChanged!(val);
          },
          selectedItemBuilder: (context) {
            return items
                .map(
                  (e) => Text(
                    itemLabelBuilder != null
                        ? itemLabelBuilder!(e)
                        : e.toString(),
                    style: AppTextStyles.title16Black,
                  ),
                )
                .toList();
          },
          isExpanded: true,
          iconEnabledColor: AppColors.kPrimaryColor,
          iconDisabledColor: AppColors.kPrimaryColor,
          dropdownColor: AppColors.kPrimaryColor,
          style: AppTextStyles.title18PrimaryColorW500,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.04,
              vertical: SizeConfig.height * 0.015,
            ),
            filled: fillColor != null,
            fillColor: fillColor,
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
          ),
          hint: Text(
            hintText ?? "Select",
            style: AppTextStyles.title16Grey,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.kPrimaryColor),
    );
  }
}
