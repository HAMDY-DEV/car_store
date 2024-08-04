import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListItem extends StatelessWidget {
  HomeListItem({
    super.key,
    this.cars,
  });

  final dynamic cars;
  @override
  Widget build(BuildContext context) {
   
    return Container(
      padding: const EdgeInsets.all(10),
      height: 190.h,
      width: 175.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 120.h,
                width: 175.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage(cars['photoUrl'][0]),
                      fit: BoxFit.fill),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                      alignment: Alignment.center,
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: cars['favorite'] == true
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
            ],
          ),
          Text(
            cars['title'],
            overflow: TextOverflow.ellipsis,
            style: getBodyStyle(context, fontSize: 14.sp),
          ),
          Text(
            '\$ ${cars['price']}',
            style: getBodyStyle(context,
                fontSize: 12.sp, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
