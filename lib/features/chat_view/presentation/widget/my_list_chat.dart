import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/chat_view/presentation/widget/image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class MyListChat extends StatelessWidget {
  MyListChat({
    super.key,
    required this.text,
    required this.imageChat,
  });
  String text;
  String imageChat;
  @override
  Widget build(BuildContext context) {
    return imageChat == ''
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                flex: 5,
                child: Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                          bottomLeft: Radius.circular(20.r)),
                    ),
                    child: Text(text,
                        textAlign: TextAlign.end,
                        style: getBodyStyle(context))),
              ),
            ],
          )
        : Wrap(
            alignment: WrapAlignment.end,
            children: [
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
