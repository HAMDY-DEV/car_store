import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.height,
    this.width,
    this.obscureText,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.minLines,
    this.maxLines,
    this.prefixIcon,
    this.onTap,
    this.suffixIcon,
    this.hintFontSize,
    this.validator,
    this.alignment,
    this.readOnly,
    this.keyboardType,
    required this.hintText,
  });
  int? minLines;
  int? maxLines;
  double? height;
  double? width;
  String hintText;
  double? hintFontSize;
  Widget? prefixIcon;
  IconData? suffixIcon;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  AlignmentGeometry? alignment;
  TextEditingController? controller;
  void Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  String? Function(String?)? validator;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 64.h,
      width: width ?? 366.w,
      alignment: alignment ?? Alignment.center,
      decoration: decoration,
      child: TextFormField(
          readOnly: readOnly ?? false,
          validator: validator,
          keyboardType: keyboardType,
          onChanged: onChanged,
          minLines: minLines ?? 1,
          maxLines: maxLines ?? 1,
          onFieldSubmitted: onFieldSubmitted,
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            suffixIcon: suffixIcon == null
                ? null
                : GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      size: 24,
                      suffixIcon,
                      color: AppColors.greyColor,
                    ),
                  ),
            prefixIcon: prefixIcon == null
                ? null
                : prefixIcon,
            fillColor: AppColors.whiteColor,
            filled: true,
            hintText: hintText,
            hintStyle: getBodyStyle(
              context,
              color: AppColors.greyColor,
              fontSize: hintFontSize ?? 16.sp,
              fontWeight: FontWeight.w600,
            ),
          )),
    );
  }
}
