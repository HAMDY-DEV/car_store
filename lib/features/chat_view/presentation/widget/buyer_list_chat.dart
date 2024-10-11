import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/chat_view/presentation/widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class BuyerListChat extends StatelessWidget {
  BuyerListChat({
    super.key,
    required this.text,
    required this.imageProfile,
    required this.imageChat,
  });

  String text;
  String imageProfile;
  String imageChat;

  @override
  Widget build(BuildContext context) {
    return imageChat == ''
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 17.r,
                backgroundImage: NetworkImage(imageProfile),
              ),
              Gap(5.w),
              Expanded(
                flex: 5,
                child: Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                          bottomRight: Radius.circular(20.r)),
                    ),
                    child: Text(text, style: getBodyStyle(context))),
              ),
              const Expanded(flex: 2, child: SizedBox())
            ],
          )
        : Wrap(
            verticalDirection: VerticalDirection.up,
            children: [
              CircleAvatar(
                radius: 17.r,
                backgroundImage: NetworkImage(imageProfile),
              ),
              Container(
                width: 5.w,
              ),
              InkWell(
                onTap: () {
                  navigatorTo(context, ImageView(url: imageChat));
                },
                child: Container(
                  height: 200.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            imageChat,
                          ))),
                ),
              ),
            ],
          );
  }
}
