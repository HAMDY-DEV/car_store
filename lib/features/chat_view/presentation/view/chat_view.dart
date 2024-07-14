import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/contaner_style.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

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
        itemBuilder: (context, index) {
          return Container(
            decoration: decoration,
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/hamdy.jpg'),
                radius: 30.r,
              ),
              title: Text(
                'Hamdy Fathy',
                style: getTitleStyle(context),
              ),
              subtitle: Text(
                'hello how are you',
                style: getSmallStyle(context),
              ),
              trailing: CircleAvatar(
                radius: 10.r,
                backgroundColor: Colors.green,
                child: Text(
                  '2',
                  style: getSmallStyle(context, color: Colors.white),
                ),
              ),
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
