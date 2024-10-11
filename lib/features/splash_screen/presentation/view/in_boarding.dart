import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/services/token.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/features/auth/presentation/view/welcome_view.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:animated_introduction/animated_introduction.dart';

class InBoarding extends StatefulWidget {
  const InBoarding({super.key});

  @override
  State<InBoarding> createState() => _InBoardingState();
}

class _InBoardingState extends State<InBoarding> {

  late List<SingleIntroScreen> pages ;

  @override
  Widget build(BuildContext context) {
pages = [
    SingleIntroScreen(
      title: S.of(context).titleOnboarding1,
      description:
          S.of(context).descriptionOnboarding1,
      imageAsset: 'assets/images/car1.png',
      sideDotsBgColor: AppColors.primaryColor,
      mainCircleBgColor: AppColors.primaryColor,
    ),
    SingleIntroScreen(
      title: S.of(context).titleOnboarding2,
      description:
          S.of(context).descriptionOnboarding2,
      imageAsset: 'assets/images/car2.png',
      sideDotsBgColor: AppColors.primaryColor,
      mainCircleBgColor: AppColors.primaryColor,
    ),
    SingleIntroScreen(
      title: S.of(context).titleOnboarding3,
      description:
          S.of(context).descriptionOnboarding3,
      imageAsset: 'assets/images/car3.png',
      sideDotsBgColor: AppColors.primaryColor,
      mainCircleBgColor: AppColors.primaryColor,
    ),
  ];
    return AnimatedIntroduction(
      slides: pages,
      indicatorType: IndicatorType.line,
      footerBgColor: AppColors.primaryColor,
      skipText: S.of(context).skip,
      doneText: S.of(context).login_now,
      nextText: S.of(context).next,
      onSkip: () {
        IsInBoarding.siveIsInBoarding(isInBoarding: true);
        navigatorToAndRemoveUntil(context, const WelcomeView());
      },
      onDone: () {
        IsInBoarding.siveIsInBoarding(isInBoarding: true);
        navigatorToAndRemoveUntil(context, const WelcomeView());
      },
    );
  }
}
