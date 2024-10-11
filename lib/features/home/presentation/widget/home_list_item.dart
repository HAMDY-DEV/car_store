import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:car_store/features/home/presentation/manager/home_cubit.dart';
import 'package:car_store/features/home/presentation/manager/home_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeListItem extends StatefulWidget {
  const HomeListItem({
    super.key,
    required this.cars,
  });

  final HomeModel cars;

  @override
  State<HomeListItem> createState() => _HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.h),
      padding: const EdgeInsets.all(10),
      height: 190.h,
      width: 175.w,
      decoration: decoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Hero(
                  tag: widget.cars.key,
                  child: Container(
                    //height: 110.h,
                    // width: 175.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: NetworkImage(widget.cars.photoUrl[0]),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                BlocProvider.value(
                  value: HomeCubit()
                    ..getUserData(
                        userId: FirebaseAuth.instance.currentUser!.uid),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      var homeCubit = HomeCubit.get(context);
                      return homeCubit.userModel != null
                          ? Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                onTap: () {
                                  homeCubit.userModel!.favorites
                                          .contains(widget.cars.key)
                                      ? homeCubit.removeFavorite(
                                          carId: widget.cars.key)
                                      : homeCubit.addFavorite(
                                          carId: widget.cars.key);
                                  setState(() {});
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    width: 25.w,
                                    height: 25.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: homeCubit.userModel!.favorites
                                            .contains(widget.cars.key)
                                        ? Icon(
                                            Icons.favorite,
                                            color: AppColors.primaryColor,
                                            size: 17.r,
                                          )
                                        : Icon(
                                            Icons.favorite_border,
                                            color: AppColors.primaryColor,
                                            size: 17.r,
                                          )),
                              ),
                            )
                          : Positioned(
                              right: 5,
                              top: 5,
                              child: Container(
                                  padding: const EdgeInsets.all(5),
                                  alignment: Alignment.center,
                                  width: 25.w,
                                  height: 25.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  )));
                    },
                  ),
                )
              ],
            ),
          ),
          Gap(5.h),
          Text(
            widget.cars.title,
            overflow: TextOverflow.ellipsis,
            style: getBodyStyle(context, fontSize: 14.sp),
          ),
          Gap(5.h),
          Text(
            '\$ ${widget.cars.price}',
            overflow: TextOverflow.ellipsis,
            style: getBodyStyle(context,
                fontSize: 12.sp, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
