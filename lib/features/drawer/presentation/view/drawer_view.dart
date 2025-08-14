import 'package:auto_size_text/auto_size_text.dart';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/auth/presentation/manager/auth_cubit.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_cubit.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_state.dart';
import 'package:car_store/features/sell_car/presentation/view/sell_car_view.dart';
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
                  return Column(
                    children: [
                      Container(
                        height: 220.h,
                        width: double.infinity,
                        decoration:
                            BoxDecoration(color: AppColors.primaryColor),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 10.w,
                              top: 70.h,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 42.r,
                                    backgroundColor: AppColors.whiteColor,
                                    child: CircleAvatar(
                                      radius: 39.r,
                                      backgroundImage: NetworkImage(
                                          state.userModel.photoURL),
                                    ),
                                  ),
                                  Gap(10.w),
                                  SizedBox(
                                    width: 180.w,
                                    child: AutoSizeText(
                                      maxLines: 1,
                                      state.userModel.name,
                                      style: getTitleStyle(context,
                                          fontSize: 20.sp,
                                          color: AppColors.whiteColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            state.userModel.isVerified == 'true'
                                ? Positioned(
                                    left: 75.w,
                                    top: 125.h,
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.whiteColor,
                                      radius: 11.r,
                                      child: Icon(
                                        Icons.verified,
                                        size: 20.r,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                      Gap(20.h),
                      state.userModel.company == true &&
                              state.userModel.isVerified == 'true'
                          ? Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.directions_car_filled,
                                      color: AppColors.primaryColor),
                                  onTap: () {
                                    navigatorTo(
                                        context,
                                        SellCarView(
                                          Sell: 'sell',
                                        ));
                                  },
                                  title: Text(
                                    S.of(context).show_car_for_sale,
                                    style: getTitleStyle(context,
                                        fontSize: 18.sp,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    height: 27.h,
                                    width: 27.w,
                                    'assets/images/auction.png',
                                    color: AppColors.primaryColor,
                                    fit: BoxFit.fill,
                                  ),
                                  onTap: () {
                                    navigatorTo(
                                        context,
                                        SellCarView(
                                          Sell: 'auction',
                                        ));
                                  },
                                  title: Text(
                                    S.of(context).OfferACarForAuction,
                                    style: getTitleStyle(context,
                                        fontSize: 18.sp,
                                        color: AppColors.primaryColor),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
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
                    fontSize: 18.sp, color: AppColors.primaryColor),
              ),
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: AppColors.primaryColor),
              onTap: () {
                showToast(msg: S.of(context).almost_there);
              },
              title: Text(
                S.of(context).privacy_policy,
                style: getTitleStyle(context,
                    fontSize: 18.sp, color: AppColors.primaryColor),
              ),
            ),
            ListTile(
              leading: Icon(Icons.share, color: AppColors.primaryColor),
              onTap: () {
                showToast(msg: S.of(context).almost_there);
              },
              title: Text(
                S.of(context).share_the_app,
                style: getTitleStyle(context,
                    fontSize: 18.sp, color: AppColors.primaryColor),
              ),
            ),
            CustomButton(
              text: S.of(context).Logout,
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
