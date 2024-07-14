import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    this.height,
    this.width,
    this.onTap,
    this.color,
    this.contantColor,
    required this.text,
  });
  final double? height;
  final double? width;
  final String text;
  void Function()? onTap;
  Color? color;
  Color? contantColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width ?? 250.w,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          color: contantColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          text,
          style: getTitleStyle(
            context,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: color ?? AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
