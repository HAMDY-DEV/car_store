import 'package:car_store/core/util/colors.dart';
import 'package:car_store/features/auction_view/presentation/view/auction_view.dart';
import 'package:car_store/features/chat_view/presentation/view/my_chat_View.dart';
import 'package:car_store/features/drawer/presentation/view/drawer_view.dart';
import 'package:car_store/features/favorite_view/presentation/view/favorite_view.dart';
import 'package:car_store/features/home/presentation/view/home_view.dart';
import 'package:car_store/features/profile_view/presentation/view/profile_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _page = 2;
  final List<Widget> _widgetOptions = [
    //0
    const AuctionView(),

    //1
    const FavoriteView(),

    //2
    const HomeView(),

    //3
    const MyChatView(),
    // const AiChatView(),

    //4
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const DrawerView(),
      body: Center(child: _widgetOptions[_page]),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        height: 55.h,
        index: 2,
        items: <Widget>[
          //0
          Image.asset(
            height: 30.h,
            width: 30.w,
            'assets/images/auction.png',
            color: AppColors.whiteColor,
            fit: BoxFit.fill,
          ),
          //1
          Icon(
            Icons.favorite,
            size: 30,
            color: AppColors.whiteColor,
          ),

          //2
          Icon(
            Icons.home,
            size: 30,
            color: AppColors.whiteColor,
          ),
          //3
          Icon(
            Icons.wechat,
            size: 30,
            color: AppColors.whiteColor,
          ),
          //4
          Icon(
            Icons.person,
            size: 30,
            color: AppColors.whiteColor,
          ),
        ],
        color: AppColors.primaryColor,
        buttonBackgroundColor: AppColors.primaryColor,
        backgroundColor: AppColors.whiteColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
