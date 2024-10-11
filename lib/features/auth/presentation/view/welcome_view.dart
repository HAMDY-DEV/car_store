import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/view/login_view.dart';
import 'package:car_store/features/auth/presentation/view/register_view.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  void initState() {
    super.initState();
    AuthCubit().chakUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            Stack(
              children: [
                Hero(
                  tag: 'logo',
                  child: SvgPicture.asset(
                    ConstImage.kLogoPrimary,
                    color: AppColors.primaryColor,
                    width: 300.w,
                    height: 200.h,
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  left: 0,
                  right: 0,
                  child: Text(
                    S.of(context).welcome_to_car_store,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              height: 300.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: S.of(context).login,
                    onTap: () {
                      navigatorTo(context, const LoginView());
                    },
                    width: 250.w,
                    height: 50.h,
                    contantColor: AppColors.whiteColor,
                  ),
                  Gap(20.h),
                  CustomButton(
                    text: S.of(context).sign_up,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 16,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).login_as,
                                      style: const TextStyle(
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 20.0),
                                    CustomButton(
                                      text: S.of(context).buyer,
                                      onTap: () {
                                        navigatorTo(
                                            context,
                                            RegisterView(
                                              company: false,
                                            ));
                                      },
                                      width: 200.w,
                                      height: 40.h,
                                      color: AppColors.whiteColor,
                                      contantColor: AppColors.primaryColor,
                                    ),
                                    Gap(20.h),
                                    CustomButton(
                                      text: S.of(context).company,
                                      onTap: () {
                                        navigatorTo(
                                            context,
                                            RegisterView(
                                              company: true,
                                            ));
                                      },
                                      width: 200.w,
                                      height: 40.h,
                                      color: AppColors.whiteColor,
                                      contantColor: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    width: 250.w,
                    height: 50.h,
                    contantColor: AppColors.whiteColor,
                  ),
                  Gap(30.h),
                  Text(
                    S.of(context).follow_us_on,
                    style: getBodyStyle(context,
                        color: AppColors.whiteColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 15.r,
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(Icons.facebook,
                              color: const Color(0xff0866FF), size: 30.r)),
                      Gap(10.w),
                      CircleAvatar(
                          radius: 15.r,
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(Icons.telegram,
                              color: const Color(0xff3390ec), size: 30.r)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
