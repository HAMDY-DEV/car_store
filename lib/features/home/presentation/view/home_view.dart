import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/presentation/widget/home_list_item.dart';
import 'package:car_store/features/sell_car/presentation/view/sell_car_view.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              //Drawer
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Icons.menu)),
        centerTitle: true,
        title: Text(
          'CarStore',
          style: getTitleStyle(context, color: AppColors.primaryColor),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 15.w),
            child: Stack(
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 29.r,
                ),
                Positioned(
                    top: 5.0.h,
                    right: 3.5.w,
                    child: Container(
                      padding: const EdgeInsets.all(0.3),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 10.w,
                        minHeight: 10.h,
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    height: 55.h,
                    width: double.infinity,
                    prefixIcon: Icons.search,
                    hintText: S.of(context).search_for_honda_pilot_7_passenger,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showCustomDialog(
                      context: context,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'All',
                                style: getBodyStyle(context,
                                    fontSize: 20.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'New',
                                style: getBodyStyle(context,
                                    fontSize: 20.sp,
                                    color:
                                        AppColors.primaryColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                'Used',
                                style: getBodyStyle(context,
                                    fontSize: 20.sp,
                                    color:
                                        AppColors.primaryColor.withOpacity(0.5),
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                          Gap(20.h),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: decoration,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'Model',
                                        hintStyle: getBodyStyle(
                                          context,
                                          color: AppColors.greyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )),
                              ),
                              Gap(10.h),
                              Expanded(
                                child: Container(
                                    decoration: decoration,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Brand',
                                        hintStyle: getBodyStyle(
                                          context,
                                          color: AppColors.greyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Gap(20.h),
                          Container(
                              decoration: decoration,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Location',
                                  hintStyle: getBodyStyle(
                                    context,
                                    color: AppColors.greyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                          Gap(
                            20.h,
                          ),
                          Text(
                            'Price Range',
                            style: getBodyStyle(
                              context,
                              color: AppColors.greyColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(
                            5.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: decoration,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'min price',
                                        hintStyle: getBodyStyle(
                                          context,
                                          color: AppColors.greyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )),
                              ),
                              Gap(10.h),
                              Expanded(
                                child: Container(
                                    decoration: decoration,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'max price',
                                        hintStyle: getBodyStyle(
                                          context,
                                          color: AppColors.greyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Gap(20.h),
                          CustomButton(
                            text: 'Search',
                            color: AppColors.whiteColor,
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.filter_list,
                    size: 24.r,
                  ),
                ),
                ///////////
              ],
            ),
            Gap(15.h),
            SizedBox(
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
                        decoration: decoration,
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
            ),
            // Recommended

            Container(
              margin: EdgeInsets.symmetric(vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).recommended,
                    style: getTitleStyle(context,
                        color: AppColors.blackColor, fontSize: 18.sp),
                  ),
                  Text(
                    S.of(context).see_all,
                    style: getSmallStyle(context, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),

            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        navigatorTo(context, const CarDetails());
                      },
                      child: const HomeListItem());
                },
                itemCount: 4,
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        navigatorTo(context, const SellCarView());
      }),
    );
  }
}
