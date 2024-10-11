import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/presentation/manager/home_cubit.dart';
import 'package:car_store/features/home/presentation/manager/home_state.dart';
import 'package:car_store/features/home/presentation/widget/home_list_item.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:car_store/features/home/model/home_model.dart';

class SearchHome extends StatefulWidget {
  const SearchHome({super.key});

  @override
  State<SearchHome> createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  TextEditingController modelController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();
  TextEditingController namePriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();

  String opshnCor = 'all';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(
          S.of(context).search,
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
                          child: CustomTextFormField(
                            height: 55.h,
                            width: double.infinity,
                            prefixIcon: const Icon(Icons.search),
                            controller: namePriceController,
                            onChanged: (p0) {
                              setState(() {});
                            },
                            hintText: S
                                .of(context)
                                .search_for_honda_pilot_7_passenger,
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

                    /////////////// StreamBuilder ////////////////
                    StreamBuilder<DatabaseEvent>(
                      stream: homeCubit.getHomeData(),
                      builder:
                          (context, AsyncSnapshot<DatabaseEvent> snapshot) {
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
                          final data = Map<dynamic, dynamic>.from(
                              dataSnapshot.value as Map);
                          final List<HomeModel> listCars = [];
                          final List<dynamic> cars = homeCubit.filter(
                              namePriceController: namePriceController,
                              data: data,
                              minPriceController: minPriceController,
                              maxPriceController: maxPriceController,
                              opshnCor: opshnCor,
                              modelController: modelController);

                          for (var element in cars) {
                            listCars.add(HomeModel.fromJson(
                                Map<String, dynamic>.from(element)));
                          }

                          return cars.isEmpty
                              ? Center(
                                  child: SvgPicture.asset(ConstImage.kNotFound))
                              : GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // عدد الأعمدة
                                    crossAxisSpacing:
                                        7.0, // المسافة بين الأعمدة
                                    mainAxisSpacing: 10.0, // المسافة بين الصفوف
                                  ),
                                  itemCount: cars.length,
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

  ///////////////// showCustomDialogsilter //////////////////
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
                  opshnCor = 'new';
                  navigatorPop(context);
                  showCustomDialogs(context);
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
                  opshnCor = 'used';
                  navigatorPop(context);
                  showCustomDialogs(context);
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
          Gap(
            20.h,
          ),
          Text(
            S.of(context).PriceRange,
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
