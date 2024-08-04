import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/chat_view/presentation/widget/buyer_list_chat.dart';
import 'package:car_store/features/chat_view/presentation/widget/my_list_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MyChatView extends StatelessWidget {
  MyChatView({super.key});

  List<String?> image = [
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    null,
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    null,
    'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
  ];

  List<String> text = [
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
    'Hello',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.primaryColor,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundImage: const NetworkImage(
                  'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
            ),
            Gap(10.w),
            Text(
              'Hamdy Fathy',
              style: getTitleStyle(color: AppColors.primaryColor, context),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: text.length,
            itemBuilder: (context, index) {
              return index % 2 == 0
                  ? BuyerListChat(
                      imageChat: image[index],
                      imageProfile:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      text: text[index],
                    )
                  : MyListChat(
                      imageChat: image[index],
                      imageProfile:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
                      text: text[index],
                    );
            },
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 80.h,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  decoration: decoration,
                  width: 300.w,
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.image, color: AppColors.greyColor),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      hintText: 'write message',
                    ),
                  ),
                ),
                Gap(10.w),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
