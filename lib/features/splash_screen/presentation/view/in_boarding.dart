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
  final List<SingleIntroScreen> pages = [
    SingleIntroScreen(
      title: 'Welcome to the Event Management App !',
      description:
          'You plans your Events, We\'ll do the rest and will be the best! Guaranteed!  ',
      imageAsset: 'assets/images/Car Showroom Promotion Instagram Post.png',
      sideDotsBgColor: AppColors.primaryColor,
      mainCircleBgColor: AppColors.primaryColor,
    ),
    SingleIntroScreen(
      title: 'Book tickets to cricket matches and events',
      description:
          'Tickets to the latest movies, crickets matches, concerts, comedy shows, plus lots more !',
      imageAsset: 'assets/images/_Modern Rent Car Service Instagram Post.png',
      sideDotsBgColor: AppColors.primaryColor,
      mainCircleBgColor: AppColors.primaryColor,
    ),
    SingleIntroScreen(
      title: 'Grabs all events now only in your hands',
      description: 'All events are now in your hands, just a click away ! ',
      imageAsset:
          'assets/images/Red and White Photo Car Rental Price List Instagram Post.png',
      sideDotsBgColor: AppColors.primaryColor,
      mainCircleBgColor: AppColors.primaryColor,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
