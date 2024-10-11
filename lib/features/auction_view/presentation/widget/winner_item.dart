import 'package:auto_size_text/auto_size_text.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/auction_view/model/auction_model.dart';
import 'package:car_store/features/auction_view/presentation/widget/lottie_builder_celebrate.dart';
import 'package:car_store/features/profile_view/model/user_model.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WinnerItem extends StatelessWidget {
  const WinnerItem({
    super.key,
    required this.userModel,
    required this.auctionItem,
  });

  final UserModel? userModel;
  final AuctionModel auctionItem;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundImage: NetworkImage(userModel!.photoURL),
        radius: 20.r, // Adjust radius as needed
      ),
      Gap(10.w),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(S.of(context).winner,
                style: getBodyStyle(context,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.greyColor)),
            AutoSizeText(userModel!.name,
                style: getBodyStyle(context,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.blackColor)),
            Text('\$ ${auctionItem.price}',
                style: getBodyStyle(context,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor)),
          ],
        ),
      ),
      const LottieBuilderCelebrate(),
    ]);
  }
}
