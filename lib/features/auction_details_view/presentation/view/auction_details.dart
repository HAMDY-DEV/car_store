import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AuctionDetailsView extends StatelessWidget {
  const AuctionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Auction Details',
          style: getTitleStyle(context, color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
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

              ////
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: CustomTextFormField(
                            keyboardType: TextInputType.number,
                            height: 50.h,
                            hintText: 'Enter Amount')),
                    const Gap(8),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        height: 40.h,
                        width: 40.w,
                        'assets/images/auction.png',
                        color: AppColors.primaryColor,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
