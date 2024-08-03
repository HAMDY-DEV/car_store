import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/presentation/widget/home_list_item.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_cubit.dart';
import 'package:car_store/features/profile_view/presentation/manager/profile_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()
        ..getUserData(userId: FirebaseAuth.instance.currentUser!.uid),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileSuccess) {
            return Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () {
                      //Drawer
                      Scaffold.of(context).openDrawer();
                    },
                    child: const Icon(Icons.menu)),
                centerTitle: true,
                title: Text(
                  'CarStore',
                  style: getTitleStyle(context, color: AppColors.primaryColor),
                ),
                actions: [
                  Container(
                    margin: EdgeInsets.only(right: 15.w),
                    child: Stack(
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 29.r,
                        ),
                        Positioned(
                            top: 5.0.h,
                            right: 3.5.w,
                            child: Container(
                              padding: const EdgeInsets.all(0.3),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 10.w,
                                minHeight: 10.h,
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor, // لون الخلفية
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5), // لون الظل
                              spreadRadius: 1, // توزيع الظل
                              blurRadius: 5, // انتشار الظل
                              offset: const Offset(0, 1), // تحديد موقع الظل
                            ),
                          ],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r),
                          ), // حواف مستديرة
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
                        top: 40.h,
                        left: 140.w,
                        right: 140.w,
                        child: CircleAvatar(
                          radius: 55.r,
                          backgroundImage: NetworkImage(state.data['photoURL']),
                        ),
                      ),
                      Positioned(
                        bottom: 15.h,
                        left: 100.w,
                        right: 100.w,
                        child: Text(
                          state.data['name'],
                          textAlign: TextAlign.center,
                          style: getBodyStyle(context,
                              fontWeight: FontWeight.w900,
                              fontSize: 20.sp,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      Positioned(
                        bottom: 17.h,
                        right: 108.w,
                        child: state.data['isVerified'] == 'true'
                            ? Icon(
                                Icons.verified,
                                size: 20.r,
                                color: Colors.blueAccent,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              navigatorTo(context, const CarDetails());
                            },
                            child: const HomeListItem());
                      },
                      itemCount: 10,
                      shrinkWrap: true,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
