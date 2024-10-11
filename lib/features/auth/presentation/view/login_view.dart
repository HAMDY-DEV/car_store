import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/bottom_navigation_bar.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/manager/auth_state.dart';
import 'package:car_store/features/auth/presentation/view/complete_registration_view.dart';
import 'package:car_store/features/auth/presentation/view/forgot_password_view.dart';
import 'package:car_store/features/auth/presentation/view/register_view.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visibility = true;

  @override
  void initState() {
    super.initState();
    AuthCubit().chakUser(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            if (state.user!.photoURL == 'false') {
              navigatorToAndRemoveUntil(
                  context, const CompleteRegistrationView());
            } else if (state.user!.photoURL == 'true') {
              navigatorToAndRemoveUntil(context, const BottomNavigationView());
            }
          } else if (state is LoginError) {
            navigatorPop(context);
            showToast(msg: state.toString());
          } else {
            showLottieDialog(
                context: context, lottieAsset: 'assets/json/loding.json');
          }
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return Scaffold(
            body: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                  child: Column(
                    children: [
                      Gap(36.h),
                      Hero(
                        tag: 'logo',
                        child: SvgPicture.asset(
                          ConstImage.kLogoPrimary,
                          color: AppColors.primaryColor,
                          width: 200.w,
                          height: 200.h,
                        ),
                      ),
                      //Login title
                      Text(
                        S.of(context).login,
                        style: getTitleStyle(
                          context,
                          color: AppColors.blackColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //Welcome
                      Text(
                        S.of(context).welcome_to_carStore,
                        style: getBodyStyle(
                          context,
                          color: AppColors.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Gap(44.h),
                      //Email
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.email),
                        hintText: S.of(context).email,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).enter_your_email;
                          }
                          return null;
                        },
                      ),
                      Gap(24.h),
                      //Password
                      CustomTextFormField(
                        obscureText: visibility,
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: visibility
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onTap: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        controller: passwordController,
                        hintText: S.of(context).password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).enter_your_password;
                          }
                          return null;
                        },
                      ),
                      Gap(24.h),
                      //Forgot password
                      GestureDetector(
                        onTap: () {
                          navigatorToReplacement(context, ForgotPasswordView());
                        },
                        child: Text(
                          S.of(context).forgot_password,
                          style: getBodyStyle(
                            context,
                            color: AppColors.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Gap(24.h),
                      //Login
                      CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.login(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        width: 366.w,
                        height: 64.h,
                        text: S.of(context).login,
                        color: AppColors.whiteColor,
                      ),
                      Gap(45.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).dont_have_an_account,
                            style: getBodyStyle(context,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColor),
                          ),
                          Gap(8.h),
                          //Sign up
                          GestureDetector(
                            onTap: () {
                              _dialog(context);
                            },
                            child: Text(
                              S.of(context).sign_up,
                              style: getBodyStyle(context,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _dialog(contextPage) {
    showDialog(
        context: contextPage,
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
                        fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  CustomButton(
                    text: S.of(context).buyer,
                    onTap: () {
                      navigatorPop(context);
                      navigatorToReplacement(
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
                      navigatorPop(context);
                      navigatorToReplacement(
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
  }
}
