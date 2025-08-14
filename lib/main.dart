import 'package:car_store/core/services/bloc.dart';
import 'package:car_store/core/services/token.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/features/splash_screen/presentation/view/splash_screen_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ScreenUtil.ensureScreenSize();
  IsInBoarding.init();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          themeMode: ThemeMode.system,
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
            appBarTheme: const AppBarTheme(
              elevation: 0,
            ),
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
            // scaffoldBackgroundColor: const Color(0xfff9fafb),
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
