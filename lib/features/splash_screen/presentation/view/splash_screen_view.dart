import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/services/token.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/features/auth/presentation/view/welcome_view.dart';
import 'package:car_store/features/splash_screen/presentation/view/in_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      IsInBoarding.getIsInBoarding() ?? false
          ? navigatorToReplacement(context, const WelcomeView())
          : navigatorToReplacement(context, const InBoarding());
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: SvgPicture.asset(
                width: 300.w,
                height: 300.h,
                ConstImage.kLogoWhite,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
