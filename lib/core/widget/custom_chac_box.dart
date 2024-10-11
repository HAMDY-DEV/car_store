import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomChacBox extends StatelessWidget {
  CustomChacBox(
      {super.key,
      required this.onChanged,
      required this.value,
      required this.text});
  Function(bool?)? onChanged;
  bool? value;
  String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
        ),
        Text(text.toString(),
            style: getBodyStyle(context,
                fontSize: 14.sp, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
