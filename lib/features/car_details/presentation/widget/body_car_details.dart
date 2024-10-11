import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_chac_box.dart';
import 'package:car_store/features/car_details/presentation/widget/creator_car_details.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BodyCarDetails extends StatefulWidget {
  const BodyCarDetails({super.key, required this.cars});
  final HomeModel cars;
  @override
  State<BodyCarDetails> createState() => _BodyCarDetailsState();
}

class _BodyCarDetailsState extends State<BodyCarDetails> {
  int currentSlide = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: CarouselSlider.builder(
                itemCount: widget.cars.photoUrl.length,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentSlide = index;
                    });
                  },
                  height: 250.h,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                ),
                itemBuilder: (context, index, realIndex) {
                  return Hero(
                    tag: widget.cars.key,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.3),
                              blurRadius: 3,
                              offset: const Offset(5, 5))
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            widget.cars.photoUrl[index],
                          ),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: PageController(initialPage: currentSlide),
                count: widget.cars.photoUrl.length,
                axisDirection: Axis.horizontal,
                effect: ExpandingDotsEffect(
                  expansionFactor: 4,
                  spacing: 8.0,
                  radius: 6.0,
                  dotWidth: 12.0,
                  dotHeight: 12.0,
                  dotColor: Colors.grey,
                  activeDotColor: AppColors.primaryColor,
                ),
              ),
            ),
            Gap(15.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${S.of(context).Model}: ',
                  style: getBodyStyle(
                    fontSize: 18.sp,
                    context,
                    fontWeight: FontWeight.w900,
                    color: AppColors.blackColor, // لون النص الرمادي
                  ),
                ),
                Text(
                  widget.cars.model,
                  style: getBodyStyle(
                    fontSize: 16.sp,
                    context,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor, // استخدام اللون الرئيسي
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${widget.cars.price}',
                  style: getBodyStyle(
                    context,
                    fontSize: 16.sp, // زيادة حجم السعر
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor, // لون السعر مميز
                  ),
                ),
              ],
            ),
            Gap(10.h),
            const Divider(),
            CreatorCarDetails(userId: widget.cars.userUid),
            const Divider(),
            Gap(10.h),
            Text(
              S.of(context).Description,
              style: getBodyStyle(
                fontSize: 18.sp,
                context,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.cars.description,
              style: getBodyStyle(
                context,
                color: AppColors.greyColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Gap(10.h),
            const Divider(),
            Gap(10.h),
            Text(
              S.of(context).Features,
              style: getBodyStyle(
                context,
                color: AppColors.blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomChacBox(
                        text: S.of(context).Alarm,
                        value: widget.cars.alarm,
                        onChanged: (value) {},
                      ),
                      const Spacer(),
                      CustomChacBox(
                        text: S.of(context).CruiseControl,
                        value: widget.cars.cruiseControl,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomChacBox(
                        text: S.of(context).Bluetooth,
                        value: widget.cars.bluetooth,
                        onChanged: (value) {},
                      ),
                      const Spacer(),
                      CustomChacBox(
                        text: S.of(context).FrontParkingSensor,
                        value: widget.cars.frontParkingSensor,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
