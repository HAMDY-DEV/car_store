import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/custom_chac_box.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key, this.cars});
  final dynamic cars;

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int currentIndex = 0;

  int currentSlide = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200.h,
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: widget.cars['photoUrl'].length,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentSlide = index;
                      });
                    },
                    height: 200.h,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Stack(children: [
                      Container(
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
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              widget.cars['photoUrl'][index],
                            ),
                          ),
                          borderRadius:
                              BorderRadius.circular(10), // حواف مستديرة
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
                              widget.cars['condition'],
                              style: getTitleStyle(context,
                                  color: AppColors.whiteColor, fontSize: 12.sp),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  },
                ),
              ),
              Gap(20.h),
              Center(
                child: SmoothPageIndicator(
                  controller: PageController(initialPage: currentSlide),
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(
                      spacing: 8.0,
                      radius: 5.0,
                      dotWidth: 20.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Colors.grey,
                      activeDotColor: AppColors.primaryColor),
                ),
              ),
              Gap(20.h),
              Text(
                widget.cars['title'],
                style: getBodyStyle(
                  context,
                  color: AppColors.blackColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(2.5.h),

              Row(
                children: [
                  Text(
                    'model:',
                    style: getBodyStyle(
                        fontSize: 22.sp, context, fontWeight: FontWeight.bold),
                  ),
                  Gap(2.5.h),
                  Text(
                    widget.cars['model'].toString(),
                    style: getSmallStyle(
                        fontSize: 15.sp, context, fontWeight: FontWeight.bold),
                  ),
                  Gap(10.h),
                ],
              ),
              Gap(5.h),
              Text(
                '\$${widget.cars['price']}',
                style: getBodyStyle(
                  context,
                  // color: AppColors.greyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gap(15.h),
              Text(
                widget.cars['description'],
                style: getBodyStyle(
                  context,
                  color: AppColors.greyColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Gap(15.h),
              Text(
                'Features',
                style: getBodyStyle(
                  context,
                  color: AppColors.blackColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ////
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomChacBox(
                    text: 'Alarm',
                    value: widget.cars['alarm'],
                    onChanged: (value) {},
                  ),
                  const Spacer(),
                  CustomChacBox(
                    text: 'Cruise Control',
                    value: widget.cars['cruiseControl'],
                    onChanged: (value) {},
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomChacBox(
                    text: 'Bluetooth',
                    value: widget.cars['bluetooth'],
                    onChanged: (value) {},
                  ),
                  const Spacer(),
                  CustomChacBox(
                    text: 'Front Parking Sensor',
                    value: widget.cars['frontParkingSensor'],
                    onChanged: (value) {},
                  ),
                ],
              ),
            ],
          ),
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
