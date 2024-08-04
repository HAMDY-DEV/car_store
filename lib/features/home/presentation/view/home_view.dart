import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/presentation/widget/carousel_slider_home.dart';
import 'package:car_store/features/home/presentation/widget/home_list_item.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String opshnCor = 'all';

  @override
  void initState() {
    super.initState();
    // HomeCubit().getHomeData();
  }

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      height: 55.h,
                      width: double.infinity,
                      prefixIcon: Icons.search,
                      hintText:
                          S.of(context).search_for_honda_pilot_7_passenger,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showCustomDialogs(context);
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
              const CarouselSliderHome(),
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
                      style:
                          getSmallStyle(context, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),

/////////////// StreamBuilder ////////////////
              StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance.ref("cars").onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // الحصول على البيانات من الـ snapshot
                    final dataSnapshot = snapshot.data!.snapshot;
                    if (dataSnapshot.value == null) {
                      return const Center(
                        child: Text('No data available'),
                      );
                    }

                    // تحويل البيانات إلى قائمة
                    final data =
                        Map<dynamic, dynamic>.from(dataSnapshot.value as Map);
                    final List<dynamic> cars;
                    if (opshnCor == 'all') {
                      cars = data.values.toList();
                    } else {
                      cars = data.values
                          .where((car) => car['condition'] == opshnCor)
                          .toList();
                    }

                    return cars.isEmpty
                        ? Center(
                            child: Text(
                            'No Data Available',
                            style: getTitleStyle(context,
                                color: AppColors.primaryColor),
                          ))
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // عدد الأعمدة
                              crossAxisSpacing: 5.0, // المسافة بين الأعمدة
                              mainAxisSpacing: 5.0, // المسافة بين الصفوف
                            ),
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  navigatorTo(
                                      context,
                                      CarDetails(
                                        cars: cars[index],
                                      ));
                                },
                                child: HomeListItem(cars: cars[index]),
                              );
                            },
                            shrinkWrap: true,
                          );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

/////////////////////////
  showCustomDialogs(BuildContext context) {
    showCustomDialog(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  opshnCor = 'all';

                  navigatorPop(context);
                  showCustomDialogs(context);
                },
                child: Text(
                  'All',
                  style: getBodyStyle(context,
                      fontSize: 20.sp,
                      color: opshnCor != 'all'
                          ? AppColors.primaryColor.withOpacity(0.5)
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.w900),
                ),
              ),
              InkWell(
                onTap: () {
                  opshnCor = 'new';
                  navigatorPop(context);
                  showCustomDialogs(context);
                },
                child: Text(
                  'New',
                  style: getBodyStyle(context,
                      fontSize: 20.sp,
                      color: opshnCor != 'new'
                          ? AppColors.primaryColor.withOpacity(0.5)
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.w900),
                ),
              ),
              InkWell(
                onTap: () {
                  opshnCor = 'used';
                  navigatorPop(context);
                  showCustomDialogs(context);
                },
                child: Text(
                  'Used',
                  style: getBodyStyle(context,
                      fontSize: 20.sp,
                      color: opshnCor != 'used'
                          ? AppColors.primaryColor.withOpacity(0.5)
                          : AppColors.primaryColor,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          Gap(20.h),
          Container(
              decoration: decoration,
              child: TextFormField(
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
            onTap: () {
              setState(() {});
              navigatorPop(context);
            },
          ),
        ],
      ),
    );
  }
}
