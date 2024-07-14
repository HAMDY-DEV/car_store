import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem({
    super.key,
  });

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
                  image: const DecorationImage(
                      image: NetworkImage(
                          'https://media.hatla2eestatic.com/uploads/car/2024/03/12/6340519/full_up_e3636eca8c92f8b669c630f836ffc590.jpg'),
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
                      child: Icon(
                        Icons.favorite,
                        color: AppColors.primaryColor,
                        size: 17.r,
                      )),
                ),
              )
            ],
          ),
          Text(
            'Audi e-tron Premium',
            style: getBodyStyle(context, fontSize: 14.sp),
          ),
          Text(
            'Rs. 54,77,823.73',
            style: getBodyStyle(context,
                fontSize: 12.sp, color: AppColors.greyColor),
          ),
        ],
      ),
    );
  }
}
