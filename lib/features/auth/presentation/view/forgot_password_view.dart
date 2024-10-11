import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/auth/presentation/manager/auth_state.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({super.key});
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.h),
                  child: Column(
                    children: [
                      Gap(36.h),
                      SvgPicture.asset(
                        ConstImage.kLogoPrimary,
                        color: AppColors.primaryColor,
                        width: 200.w,
                        height: 200.h,
                      ),
                      //Forgot Password title
                      Text(
                        S.of(context).forgot_password,
                        style: getTitleStyle(
                          context,
                          color: AppColors.blackColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Gap(44.h),
                      //Email
                      CustomTextFormField(
                        prefixIcon: Icon(Icons.email),
                        hintText: S.of(context).email,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).enter_your_email;
                          }
                          return null;
                        },
                      ),

                      Gap(24.h),
                      //send link
                      CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            AuthCubit.get(context).forgetPassword(
                                context: context, email: emailController.text);
                          }
                        },
                        width: 366.w,
                        height: 64.h,
                        text: S.of(context).send_link,
                        color: AppColors.whiteColor,
                      ),
                      Gap(45.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            S.of(context).already_have_an_account,
                            style: getBodyStyle(context,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.greyColor),
                          ),
                          Gap(8.h),
                          //Sign up
                          GestureDetector(
                            onTap: () {
                              navigatorPop(context);
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
                      )
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
