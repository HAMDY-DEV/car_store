import 'package:car_store/core/function/time.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/const_image.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/auction_view/model/auction_model.dart';
import 'package:car_store/features/auction_view/presentation/manager/auction_cubit.dart';
import 'package:car_store/features/auction_view/presentation/manager/auction_state.dart';
import 'package:car_store/features/auction_view/presentation/widget/creator_item.dart';
import 'package:car_store/features/auction_view/presentation/widget/lottie_builder_celebrate.dart';
import 'package:car_store/features/auction_view/presentation/widget/winner_item.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AuctionListItems extends StatelessWidget {
  const AuctionListItems({
    super.key,
    required this.auctionItem,
  });

  final AuctionModel auctionItem;

  void removeAuction({required String key}) {
    if (isDays(auctionItem) < 0) {
      AuctionCubit().deleteAuctionData(key: key);
    }
  }

  @override
  Widget build(BuildContext context) {
    removeAuction(key: auctionItem.key);

    return BlocProvider(
      create: (context) => AuctionCubit()
        ..getDataUserId(
            id: isDays(auctionItem) <= 0
                ? auctionItem.highestPrice
                : auctionItem.creatorUid),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 15.0.w),
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h, bottom: 15.h),
        decoration: decoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: auctionItem.key,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.h, // Fixed height for the image container
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackColor,
                          blurRadius: 5.0,
                        )
                      ],
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        repeat: ImageRepeat.noRepeat,
                        image: NetworkImage(auctionItem.photoUrl[0]),
                      ),
                    ),
                  ),
                  isDays(auctionItem) == 0 && isHours(auctionItem) == 0
                      ? Positioned(
                          left: 50,
                          right: 50,
                          top: 40,
                          bottom: 40,
                          child: Image.asset(
                            fit: BoxFit.contain,
                            width: 50.w,
                            height: 50.h,
                            ConstImage.kDoneLogo,
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(auctionItem.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getBodyStyle(context,
                                fontWeight: FontWeight.w700)),
                      ),
                      Text('\$ ${auctionItem.price}',
                          style: getBodyStyle(context,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColor)),
                    ],
                  ),
                  Text(
                      ' Expires in ${isHours(auctionItem) ~/ 24} days ${isHours(auctionItem) % 24} hours ',
                      style: getBodyStyle(context,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.greyColor)),
                  Gap(5.h),
                  const Divider(),
                  Gap(5.h),
                  BlocBuilder<AuctionCubit, AuctionState>(
                    builder: (context, state) {
                      if (state is GetUserDataSuccess) {
                        UserModel? userModel = state.userModel;
                        return isDays(auctionItem) == 0 &&
                                isHours(auctionItem) == 0
                            ? WinnerItem(
                                userModel: userModel, auctionItem: auctionItem)
                            : CreatorItem(
                                userModel: userModel, auctionItem: auctionItem);
                      } else if (state is GetUserDataError) {
                        return Center(
                          child: Text(state.error.toString()),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
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
