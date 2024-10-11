import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/model/home_model.dart';
import 'package:car_store/features/home/presentation/manager/home_cubit.dart';
import 'package:car_store/features/home/presentation/manager/home_state.dart';
import 'package:car_store/features/home/presentation/widget/carousel_slider_home.dart';
import 'package:car_store/features/home/presentation/widget/home_list_item.dart';
import 'package:car_store/features/home/presentation/widget/search_home.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String opshnCor = 'all';
  TextEditingController modelController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController namePriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    HomeCubit().updateToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(Icons.menu)),
        centerTitle: true,
        title: Text(
          'CarStore',
          style: getTitleStyle(context, color: AppColors.primaryColor),
        ),
      ),
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var homeCubit = HomeCubit.get(context);

            return Padding(
              padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                navigatorTo(context, const SearchHome());
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.r),
                                height: 55.h,
                                decoration: decoration,
                                child: Row(
                                  children: [
                                    Icon(Icons.search, size: 24.r),
                                    Gap(8.h),
                                    Text(
                                      S
                                          .of(context)
                                          .search_for_honda_pilot_7_passenger,
                                      overflow: TextOverflow.ellipsis,
                                      style: getSmallStyle(context,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )),
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
                      ],
                    ),
                    Gap(15.h),
                    CarouselSliderHome(),
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
                            style: getSmallStyle(context,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    StreamBuilder<DatabaseEvent>(
                      stream: homeCubit.getHomeData(),
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.snapshot.value == null) {
                          return Center(
                            child: SvgPicture.asset(ConstImage.kNotFound),
                          );
                        } else {
                          final dataSnapshot = snapshot.data!.snapshot;
                          final data = Map<dynamic, dynamic>.from(
                              dataSnapshot.value as Map);

                          final List<HomeModel> listCars = [];
                          final List<dynamic> mapCars = homeCubit.filter(
                              namePriceController: namePriceController,
                              data: data,
                              minPriceController: minPriceController,
                              maxPriceController: maxPriceController,
                              opshnCor: opshnCor,
                              modelController: modelController);

                          for (var element in mapCars) {
                            listCars.add(HomeModel.fromJson(
                                Map<String, dynamic>.from(element)));
                          }

                          return listCars.isEmpty
                              ? Center(
                                  child: SvgPicture.asset(ConstImage.kNotFound))
                              : GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 7.0,
                                    mainAxisSpacing: 10.0,
                                  ),
                                  itemCount: listCars.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        navigatorTo(
                                            context,
                                            CarDetails(
                                              cars: listCars[index],
                                            ));
                                      },
                                      child:
                                          HomeListItem(cars: listCars[index]),
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
            );
          },
        ),
      ),
    );
  }

  /// A function to show a custom dialog with filtering options.
  /// It shows a dialog with three options: All, New, Used. When the user selects
  /// one of the options, the dialog is closed and the selected option is stored
  /// in the `opshnCor` variable.
  /// It also shows two text fields for the user to input the minimum and maximum
  /// prices of the cars they want to see. The prices are stored in the
  /// `minPriceController` and `maxPriceController` variables.
  /// Finally, it shows a button with the text "Search". When the button is tapped,
  /// the dialog is closed and the state of the widget is updated.
 
  void showCustomDialogs(BuildContext context) {
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
                  setState(() {
                    opshnCor = 'all';
                  });
                },
                child: Text(
                  S.of(context).all,
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
                  setState(() {
                    opshnCor = 'new';
                  });
                },
                child: Text(
                  S.of(context).new1,
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
                  setState(() {
                    opshnCor = 'used';
                  });
                },
                child: Text(
                  S.of(context).used1,
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
                controller: modelController,
                decoration: InputDecoration(
                  hintText: S.of(context).Model,
                  hintStyle: getBodyStyle(
                    context,
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
          Gap(20.h),
          Text(
            S.of(context).PriceRange,
            style: getBodyStyle(
              context,
              color: AppColors.greyColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(5.h),
          Row(
            children: [
              Expanded(
                child: Container(
                    decoration: decoration,
                    child: TextFormField(
                      controller: minPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: S.of(context).min_price,
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
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: S.of(context).max_price,
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
          Row(
            children: [
              CustomButton(
                width: 150.w,
                text: S.of(context).search,
                color: AppColors.whiteColor,
                onTap: () {
                  setState(() {});
                  navigatorPop(context);
                },
              ),
              Gap(10.w),
              CustomButton(
                width: 80.w,
                text: S.of(context).Cancel,
                color: AppColors.whiteColor,
                onTap: () {
                  navigatorPop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
