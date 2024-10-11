import 'package:car_store/core/util/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSliderHome extends StatelessWidget {
  CarouselSliderHome({
    super.key,
  });

  final List<String> images = [
    'assets/images/Screenshot.png',
    'assets/images/Screenshot_2.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: images.length,
        options: CarouselOptions(
          height: 300.0,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.97,
        ),
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.blackColor.withOpacity(0.2),
                    blurRadius: 3,
                    offset: const Offset(5, 5))
              ],
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                  image: AssetImage(
                    images[index],
                  ),
                  fit: BoxFit.fill),
            ),
          );
        },
      ),
    );
  }
}
