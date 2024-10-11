import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/manager/auth_state.dart';
import 'package:car_store/features/auth/presentation/view/complete_registration_view.dart';
import 'package:car_store/features/auth/presentation/view/login_view.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class RegisterView extends StatefulWidget {
  RegisterView({super.key, required this.company});
  bool company;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool visibility = true;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              navigatorToAndRemoveUntil(
                  context, const CompleteRegistrationView());
            } else if (state is RegisterError) {
              navigatorPop(context);
              showToast(msg: state.toString());
            } else {
              showLottieDialog(
                  context: context, lottieAsset: 'assets/json/loding.json');
            }
          },
          builder: (context, state) {
            AuthCubit cubit = AuthCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                child: Form(
                  key: formKey,
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
                      //Sign up
                      Text(
                        S.of(context).sign_up,
                        style: getTitleStyle(
                          context,
                          color: AppColors.blackColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //find your dream car
                      Text(
                        S.of(context).find_your_dream_car,
                        style: getBodyStyle(
                          context,
                          color: AppColors.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Gap(19.h),
                      //Name
                      CustomTextFormField(
                        prefixIcon: const Icon(Icons.person),
                        controller: nameController,
                        hintText: widget.company
                            ? S.of(context).company_name
                            : S.of(context).full_name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).enter_your_name;
                          }
                          return null;
                        },
                      ),
                      Gap(20.h),
                      //Email
                      CustomTextFormField(
                        prefixIcon: const Icon(Icons.email),
                        controller: emailController,
                        hintText: S.of(context).email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).enter_your_email;
                          }
                          return null;
                        },
                      ),
                      Gap(20.h),

                      //Password
                      CustomTextFormField(
                        obscureText: visibility,
                        controller: passwordController,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: visibility
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onTap: () {
                          setState(() {
                            visibility = !visibility;
                          });
                        },
                        hintText: S.of(context).password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).enter_your_password;
                          }
                          return null;
                        },
                      ),
                      Gap(20.h),
                      //sign up
                      CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            cubit.register(
                                context: context,
                                company: widget.company,
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        width: 366.w,
                        height: 64.h,
                        text: S.of(context).sign_up,
                        color: AppColors.whiteColor,
                      ),
                      Gap(41.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Already have an account
                          Text(
                            S.of(context).already_have_an_account,
                            style: getBodyStyle(context,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColor),
                          ),
                          Gap(8.h),
                          //Sign in
                          GestureDetector(
                            onTap: () {
                              navigatorToReplacement(
                                  context, const LoginView());
                            },
                            child: Text(
                              S.of(context).sign_in,
                              style: getBodyStyle(context,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      Gap(50.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
