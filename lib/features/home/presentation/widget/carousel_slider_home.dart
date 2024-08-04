import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselSliderHome extends StatelessWidget {
  const CarouselSliderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 5,
        options: CarouselOptions(
          height: 300.0,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          viewportFraction: 0.9,
        ),
        itemBuilder: (context, index, realIndex) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/car-store-2024.appspot.com/o/cars%2F-O3RRWlcdECkkIvWicmh%2F-O3RRWlcdECkkIvWicmh1?alt=media&token=95a30ef3-9040-454b-abfe-9a271bcdac84',
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              Positioned(
                top: 5.h,
                left: -22.w,
                child: Transform.rotate(
                  angle: 5.8,
                  child: Container(
                    alignment: Alignment.center,
                    width: 90.w,
                    height: 15.h,
                    color: AppColors.primaryColor,
                    child: Text(
                      textAlign: TextAlign.center,
                      'New',
                      style: getTitleStyle(context,
                          color: AppColors.whiteColor, fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
