import 'package:auto_size_text/auto_size_text.dart';
import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/custom_button.dart';
import 'package:car_store/features/auction_view/model/auction_model.dart';
import 'package:car_store/features/auction_view/presentation/view/auction_details.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CreatorItem extends StatelessWidget {
  const CreatorItem({
    super.key,
    required this.userModel,
    required this.auctionItem,
  });

  final UserModel? userModel;
  final AuctionModel auctionItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userModel!.photoURL),
          radius: 20.r, // Adjust radius as needed
        ),
        Gap(10.w),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(S.of(context).Creator,
                  style: getBodyStyle(context,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.greyColor)),
              AutoSizeText(userModel!.name,
                  maxLines: 1,
                  style: getBodyStyle(context,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.blackColor)),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 2,
          child: CustomButton(
              height: 45.h,
              width: 110.w,
              radius: 50.r,
              style: getSmallStyle(context,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: AppColors.whiteColor),
              text: S.of(context).PlaceBid,
              onTap: () {
                navigatorTo(
                    context,
                    AuctionDetailsView(
                      userModel: userModel!,
                      auctionItem: auctionItem,
                    ));
              }),
        ),
      ],
    );
  }
}
