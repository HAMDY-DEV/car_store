import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/function/show_error_dialogs.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/core/widget/show_loading_and_error.dart';
import 'package:car_store/features/auction_view/model/auction_model.dart';
import 'package:car_store/features/auction_view/presentation/manager/auction_cubit.dart';
import 'package:car_store/features/auth/presentation/widget/costom_text_form_field.dart';
import 'package:car_store/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

  showCustomDialogAuction(
{ required BuildContext context,
   required AuctionModel auctionItem,}
  ) {
    TextEditingController priceController = TextEditingController();
    String uid = FirebaseAuth.instance.currentUser!.uid;

    showCustomDialog(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            S.of(context).Subscrib,
            style: getTitleStyle(context,
                fontSize: 20.sp, fontWeight: FontWeight.w900),
          ),
          Gap(20.h),
          CustomTextFormField(
            hintText: S.of(context).EnterBidPrice,
            controller: priceController,
          ),
          Gap(20.h),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    List<String> subscribers = auctionItem.subscribers;
                    if (subscribers.contains(uid)) {
                    } else {
                      subscribers.add(uid);
                    }
                    if (priceController.text.isNotEmpty) {
                      if (int.parse(priceController.text) >
                          int.parse(auctionItem.price)) {
                        AuctionCubit().updateAuctionData(
                            subscribers: subscribers,
                            highestPrice: uid,
                            key: auctionItem.key,
                            price: priceController.text);
                        navigatorPop(context);
                        navigatorPop(context);
                      } else {
                        showToast(msg: S.of(context).PleaseRnterAPrice);
                      }
                    } else {
                      showToast(msg: S.of(context).PleaseEnterPrice);
                    }
                  },
                  child: Text(
                    S.of(context).Bid,
                    style: getBodyStyle(context,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w900),
                  )),
              TextButton(
                  onPressed: () {
                    navigatorPop(context);
                  },
                  child: Text(
                    S.of(context).Cancel,
                    style: getBodyStyle(context,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w900),
                  )),
            ],
          ),
        ],
      ),
    );
  }
