import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LottieBuilderCelebrate extends StatelessWidget {
  const LottieBuilderCelebrate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      height: 50.h,
      width: 50.w,
      fit: BoxFit.contain,
      'assets/json/animation_celebrate_chamr.json',
    );
  }
}