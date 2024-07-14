import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/car_details/presentation/view/car_details.dart';
import 'package:car_store/features/home/presentation/widget/home_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

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
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
    );
  }
}
