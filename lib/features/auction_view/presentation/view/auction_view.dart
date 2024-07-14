import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/auction_details_view/presentation/view/auction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionView extends StatelessWidget {
  const AuctionView({super.key});

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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              navigatorTo(context, const AuctionDetailsView());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              decoration: decoration,
              child: ListTile(
                leading: Image.network(
                  height: 150.h,
                  width: 100.w,
                  fit: BoxFit.fill,
                  'https://media.hatla2eestatic.com/uploads/car/2024/03/12/6340519/full_up_e3636eca8c92f8b669c630f836ffc590.jpg',
                ),
                title: Text(
                  'Car Name',
                  style: getTitleStyle(context),
                ),
                subtitle: const Text('50000.EG'),
                trailing: const Text('5 days left'),
              ),
            ),
          );
        },
      ),
    );
  }
}
