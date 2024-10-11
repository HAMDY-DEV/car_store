import 'package:car_store/core/function/routing.dart';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/chat_view/presentation/manager/chat_cubit.dart';
import 'package:car_store/features/chat_view/presentation/view/ai_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class MyChatView extends StatelessWidget {
  const MyChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
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
        ),
        body: GestureDetector(
          onTap: () {
            navigatorTo(context, const AiChatView());
          },
          child: ListTile(
            leading: LottieBuilder.asset(
              'assets/json/aicht.json',
              fit: BoxFit.cover,
              width: 100.w,
              height: 100.h,
            ),
            title: Text(
              'Ai Chat Bot',
              style: getTitleStyle(context),
            ),
          ),
        ),
      ),
    );
  }
}
/**
 

  return GestureDetector(
                                    onTap: () {
                                      navigatorTo(
                                          context,
                                          ChatView(
                                            idChat: listChats[index]['chatId'],
                                          ));
                                      // if (ChatCubit.get(context).userModel !=
                                      //     null) {
                                      //   String idCompany = listChat[index]
                                      //           ['key']
                                      //       .toString()
                                      //       .split('&')
                                      //       .first;
                                      //   String idUser = listChat[index]['key']
                                      //       .toString()
                                      //       .split('&')
                                      //       .last;
                                    },
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            listChats[index]['imageUrl']),
                                        radius: 30.r,
                                      ),
                                      title: Text(
                                        listChats[index]['name'],
                                        style: getTitleStyle(context),
                                      ),
                                      subtitle: Text(
                                        listChats[index]['LastMessage'],
                                        style: getSmallStyle(context),
                                      ),
                                      trailing: CircleAvatar(
                                        radius: 10.r,
                                        backgroundColor: Colors.green,
                                        child: Text(
                                          listChats[index]['unreadCount']
                                              .toString(),
                                          style: getSmallStyle(context,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );


 */