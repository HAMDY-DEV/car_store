import 'dart:ui';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/time.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/core/widget/custom_chac_box.dart';
import 'package:car_store/features/auction_view/model/auction_model.dart';
import 'package:car_store/features/auction_view/presentation/widget/show_custom_dialog_auction.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AuctionDetailsView extends StatelessWidget {
  const AuctionDetailsView(
      {super.key, required this.auctionItem, required this.userModel});

  final UserModel userModel;
  final AuctionModel auctionItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Image.network(
                  auctionItem.photoUrl[0],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0), // اجعل اللون شفافًا
                    ),
                  ),
                ),
                PageView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Hero(
                      tag: auctionItem.key,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: 90.h, left: 25.w, right: 25.w, bottom: 30.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(auctionItem.photoUrl[index]))),
                      ),
                    );
                  },
                ),
                Positioned(
                  top: 375.h,
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.whiteColor,
                  ),
                ),
                Positioned(
                  left: 15.w,
                  top: 30.h,
                  child: IconButton(
                    onPressed: () {
                      navigatorPop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  auctionItem.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      getTitleStyle(context, fontSize: 25.sp),
                                ),
                                Text(
                                  ' Expires in ${isHours(auctionItem) ~/ 24} days ${isHours(auctionItem) % 24} hours ',
                                  style: getBodyStyle(context,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.greyColor),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.attach_money,
                                      color: AppColors.primaryColor,
                                      size: 24.sp),
                                  Text(
                                    auctionItem.price,
                                    style: getBodyStyle(context,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  )
                                ],
                              ),
                              Gap(3.w),
                              Row(
                                children: [
                                  Icon(Icons.people,
                                      color: AppColors.primaryColor,
                                      size: 24.sp),
                                  Gap(5.w),
                                  Text(
                                    auctionItem.subscribers.length.toString(),
                                    style: getBodyStyle(context,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Gap(5.h),
                      const Divider(),
                      Gap(5.h),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(userModel.photoURL),
                            radius: 25.r, // Adjust radius as needed
                          ),
                          Gap(10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(S.of(context).Creator,
                                  style: getBodyStyle(context,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.greyColor)),
                              Text(userModel.name,
                                  style: getBodyStyle(context,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.blackColor)),
                            ],
                          ),
                        ],
                      ),
                      Gap(5.h),
                      const Divider(),
                      Text(
                        S.of(context).Description,
                        style: getTitleStyle(context, fontSize: 20.sp),
                      ),
                      Text(
                        auctionItem.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: getBodyStyle(context,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.greyColor),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomChacBox(
                            text: S.of(context).Alarm,
                            value: auctionItem.alarm,
                            onChanged: (value) {},
                          ),
                          const Spacer(),
                          CustomChacBox(
                            text: S.of(context).CruiseControl,
                            value: auctionItem.cruiseControl,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomChacBox(
                            text: S.of(context).Bluetooth,
                            value: auctionItem.bluetooth,
                            onChanged: (value) {},
                          ),
                          const Spacer(),
                          CustomChacBox(
                            text: S.of(context).FrontParkingSensor,
                            value: auctionItem.frontParkingSensor,
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      Gap(10.h),
                      Align(
                        alignment: Alignment.center,
                        child: CustomButton(
                          text: S.of(context).PlaceBid,
                          width: 350.w,
                          color: AppColors.whiteColor,
                          onTap: () {
                            showCustomDialogAuction(
                                context: context, auctionItem: auctionItem);
                          },
                          radius: 50.r,
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
