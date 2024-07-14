import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                ),
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // لون الخلفية
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // لون الظل
                          spreadRadius: 1, // توزيع الظل
                          blurRadius: 5, // انتشار الظل
                          offset: const Offset(0, 1), // تحديد موقع الظل
                        ),
                      ],
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          'https://media.hatla2eestatic.com/uploads/car/2024/03/12/6340519/full_up_e3636eca8c92f8b669c630f836ffc590.jpg',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10), // حواف مستديرة
                    ),
                  );
                },
              ),
            ),
            Gap(20.h),
            Text(
              'Telsa Model 3',
              style: getBodyStyle(
                context,
                color: AppColors.blackColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(2.5.h),
            Text(
              'Rs. 18,00,000.00',
              style: getBodyStyle(
                context,
                color: AppColors.greyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Gap(15.h),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas diam nam eu nulla a. Vestibulum aliquet facilisi interdum nibh blandit Read more...',
              style: getBodyStyle(
                context,
                color: AppColors.greyColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(15.h),
            Row(
              children: [
                Text(
                  'Features',
                  style: getBodyStyle(
                    context,
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  'See All',
                  style: getBodyStyle(
                    context,
                    color: AppColors.primaryColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            ////
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CustomButton(
              width: 300.w,
              text: 'Buy Now',
              onTap: () {},
              color: AppColors.whiteColor,
            ),
            const Gap(8),
            Expanded(
              child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.message_rounded, color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
