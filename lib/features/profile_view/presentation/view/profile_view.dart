import 'package:auto_size_text/auto_size_text.dart';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_cubit.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_state.dart';
import 'package:car_store/features/profile_view/presentation/widget/itim_profile.dart';
import 'package:car_store/features/profile_view/presentation/widget/profile_list_item.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getData(),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          leading: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(Icons.menu)),
          centerTitle: true,
          title: Text(
            'CarStore',
            style: getTitleStyle(context, color: AppColors.primaryColor),
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            ProfileCubit profileCubit = ProfileCubit.get(context);
            if (state is ProfileSuccess) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 230.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.r),
                              bottomRight: Radius.circular(30.r),
                            ),
                          ),
                          width: double.infinity,
                          height: 120.h,
                        ),
                      ),
                      Positioned(
                        top: 60.h,
                        left: 140.w,
                        right: 140.w,
                        child: CircleAvatar(
                          radius: 50.r,
                          backgroundImage:
                              NetworkImage(state.userModel.photoURL),
                        ),
                      ),
                      Positioned(
                        bottom: 40.h,
                        left: 50.w,
                        right: 50.w,
                        child: SizedBox(
                          width: 190.w,
                          child: AutoSizeText(
                            state.userModel.name,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: getBodyStyle(context,
                                fontWeight: FontWeight.w900,
                                fontSize: 20.sp,
                                color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 70.h,
                        right: 150.w,
                        child: state.userModel.isVerified == 'true'
                            ? CircleAvatar(
                                radius: 12.r,
                                backgroundColor: AppColors.whiteColor,
                                child: Icon(
                                  Icons.verified,
                                  size: 20.r,
                                  color: Colors.blueAccent,
                                ),
                              )
                            : const SizedBox(),
                      ),
                      state.userModel.company
                          ? Positioned(
                              bottom: 15.h,
                              left: 30.w,
                              child: InkWell(
                                onTap: () {
                                  controller.animateToPage(
                                    0, // الصفحة المطلوبة
                                    duration: const Duration(
                                        milliseconds: 300), // مدة الانتقال
                                    curve: Curves.easeIn, // نوع الحركة
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.directions_car_filled,
                                      color: AppColors.primaryColor,
                                      size: 30.w,
                                    ),
                                    Text(
                                      S.of(context).CarData,
                                      style: getBodyStyle(context,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                      state.userModel.company
                          ? Positioned(
                              bottom: 15.h,
                              right: 20.w,
                              child: GestureDetector(
                                onTap: () {
                                  controller.animateToPage(
                                    1, // الصفحة المطلوبة
                                    duration: const Duration(
                                        milliseconds: 300), // مدة الانتقال
                                    curve: Curves.easeIn, // نوع الحركة
                                  );
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.badge,
                                      color: AppColors.primaryColor,
                                      size: 30.w,
                                    ),
                                    Text(
                                      S.of(context).MyData,
                                      style: getBodyStyle(context,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  state.userModel.company
                      ? Expanded(
                          child: PageView(
                            controller: controller,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              profileCubit.carList!.isNotEmpty &&
                                      profileCubit.carList != null
                                  ? GridView.builder(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.h),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                      ),
                                      itemCount: profileCubit.carList!.length,
                                      itemBuilder: (context, index) {
                                        HomeModel car = HomeModel.fromJson(
                                            Map<String, dynamic>.from(
                                                profileCubit.carList![index]));
                                        return GestureDetector(
                                          onTap: () {
                                            navigatorTo(
                                                context,
                                                CarDetails(
                                                  cars: car,
                                                ));
                                          },
                                          child: ProfileListItem(
                                              onTapDelete: () {
                                                profileCubit.deleteCar(
                                                    carId: car.key);
                                              },
                                              cars: car),
                                        );
                                      },
                                      shrinkWrap: true,
                                    )
                                  : Center(
                                      child: SvgPicture.asset(
                                          ConstImage.kNotFound)),
                              Column(
                                children: [
                                  Gap(20.h),
                                  ItimProfile(
                                    icon: Icons.email,
                                    title: S.of(context).email,
                                    text: state.userModel.email,
                                  ),
                                  ItimProfile(
                                    icon: Icons.location_pin,
                                    title: S.of(context).address,
                                    text: state.userModel.address,
                                  ),
                                  ItimProfile(
                                    icon: Icons.phone,
                                    title: S.of(context).phone,
                                    text: state.userModel.phone1,
                                  ),
                                  ItimProfile(
                                    icon: Icons.phone,
                                    title: S.of(context).phone,
                                    text: state.userModel.phone2,
                                  ),
                                  Gap(70.h),
                                  CustomButton(
                                    text: S.of(context).Logout,
                                    width: 250.w,
                                    radius: 50.r,
                                    color: AppColors.whiteColor,
                                    onTap: () {
                                      profileCubit.logout(context);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                          children: [
                            Gap(20.h),
                            ItimProfile(
                              icon: Icons.email,
                              title: S.of(context).email,
                              text: state.userModel.email,
                            ),
                            ItimProfile(
                              icon: Icons.location_pin,
                              title: S.of(context).address,
                              text: state.userModel.address,
                            ),
                            ItimProfile(
                              icon: Icons.phone,
                              title: S.of(context).phone,
                              text: state.userModel.phone1,
                            ),
                            ItimProfile(
                              icon: Icons.phone,
                              title: S.of(context).phone,
                              text: state.userModel.phone2,
                            ),
                            Gap(70.h),
                            CustomButton(
                              text: S.of(context).Logout,
                              width: 250.w,
                              radius: 50.r,
                              color: AppColors.whiteColor,
                              onTap: () {
                                profileCubit.logout(context);
                              },
                            ),
                          ],
                        )),
                ],
              );
            } else if (state is ProfileError) {
              return const Center(child: Text('Error'));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
