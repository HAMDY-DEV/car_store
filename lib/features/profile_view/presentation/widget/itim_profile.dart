import 'package:auto_size_text/auto_size_text.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ItimProfile extends StatelessWidget {
  const ItimProfile({
    super.key,
    required this.text,
    required this.icon,
    required this.title,
  });

  final String title;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
      decoration: decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor),
              Text(title,
                  style: getBodyStyle(context,
                      fontSize: 13.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          Gap(10.w),
          Expanded(
            child: AutoSizeText(
              text,
              maxLines: 1,
              style: getBodyStyle(context,
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
