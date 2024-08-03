import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_cubit.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_state.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()
        ..getUserData(userId: FirebaseAuth.instance.currentUser!.uid),
      child: Drawer(
        child: Column(
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileError) {
                  return const Text('error');
                } else if (state is ProfileSuccess) {
                  return Container(
                    height: 220.h,
                    width: double.infinity,
                    decoration: BoxDecoration(color: AppColors.primaryColor),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10.w,
                          top: 70.h,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 50.r,
                                child: CircleAvatar(
                                  radius: 45.r,
                                  backgroundImage:
                                      NetworkImage(state.data['photoURL']),
                                ),
                              ),
                              Gap(20.w),
                              Text(
                                state.data['name'],
                                style: getTitleStyle(context,
                                    fontSize: 20.sp,
                                    color: AppColors.whiteColor),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 85.w,
                          top: 140.h,
                          child: Container(
                            decoration: decoration,
                            child: Icon(
                              Icons.verified,
                              size: 20.r,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Gap(20.h),
            ListTile(
              leading: Icon(
                Icons.tips_and_updates_rounded,
                color: AppColors.primaryColor,
              ),
              onTap: () {
                showToast(msg: S.of(context).almost_there);
              },
              title: Text(
                S.of(context).who_are_we,
                style: getTitleStyle(context,
                    fontSize: 20.sp, color: AppColors.primaryColor),
              ),
            ),
            Gap(20.h),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: AppColors.primaryColor),
              onTap: () {
                showToast(msg: S.of(context).almost_there);
              },
              title: Text(
                S.of(context).privacy_policy,
                style: getTitleStyle(context,
                    fontSize: 20.sp, color: AppColors.primaryColor),
              ),
            ),
            Gap(20.h),
            ListTile(
              leading: Icon(Icons.share, color: AppColors.primaryColor),
              onTap: () {
                showToast(msg: S.of(context).almost_there);
              },
              title: Text(
                S.of(context).share_the_app,
                style: getTitleStyle(context,
                    fontSize: 20.sp, color: AppColors.primaryColor),
              ),
            ),
            Gap(20.h),
            CustomButton(
              text: 'Logout',
              color: AppColors.whiteColor,
              onTap: () {
                AuthCubit().logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
