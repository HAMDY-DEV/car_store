import 'package:car_store/core/util/colors.dart';
import 'package:car_store/features/splash_screen/presentation/view/splash_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          themeMode: ThemeMode.dark,
          debugShowCheckedModeBanner: false,
          locale: const Locale('en'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whiteColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whiteColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.whiteColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.greyColor),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            scaffoldBackgroundColor: const Color(0xfff9fafb),
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            useMaterial3: true,
          ),
          home: child,
        );
      },
      child: const SplashScreenView(),
    );
  }
}
