import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class ProfileListItem extends StatelessWidget {
  ProfileListItem({
    super.key,
    required this.cars,
    this.onTapDelete,
  });

  Function()? onTapDelete;

  final HomeModel cars;
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
                  tag: cars.key,
                  child: Container(
                    //height: 110.h,
                    // width: 175.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          image: NetworkImage(cars.photoUrl[0]),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: onTapDelete,
                    child: Container(
                        alignment: Alignment.center,
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: AppColors.primaryColor,
                          size: 17.r,
                        )),
                  ),
                )
              ],
            ),
          ),
          Gap(5.h),
          Text(
            cars.title,
            overflow: TextOverflow.ellipsis,
            style: getBodyStyle(context, fontSize: 14.sp),
          ),
          Gap(5.h),
          Text(
            '\$ ${cars.price}',
            overflow: TextOverflow.ellipsis,
            style: getBodyStyle(context,
                fontSize: 12.sp, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
