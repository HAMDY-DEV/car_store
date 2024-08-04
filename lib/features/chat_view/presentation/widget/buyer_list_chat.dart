import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/chat_view/presentation/widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BuyerListChat extends StatelessWidget {
  BuyerListChat({
    super.key,
    required this.text,
    required this.imageProfile,
    required this.imageChat,
  });

  String text;
  String imageProfile;
  String? imageChat;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Gap(10.w),
        CircleAvatar(
          radius: 20.r,
          backgroundImage: NetworkImage(imageProfile),
        ),
        Container(
          padding: EdgeInsets.all(10.h),
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 20.h, vertical: 5.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r)),
          ),
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              imageChat == null
                  ? Container()
                  : InkWell(
                      onTap: () {
                        navigatorTo(context, ImageView(url: imageChat!));
                      },
                      child: Container(
                        height: 100.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  imageChat!,
                                ))),
                      ),
                    ),
              Text(
                text,
                style: getBodyStyle(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
