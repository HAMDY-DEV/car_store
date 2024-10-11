import 'dart:developer';
import 'package:car_store/core/util/colors.dart';
import 'package:car_store/core/util/text_style.dart';
import 'package:car_store/features/chat_view/presentation/manager/chat_cubit.dart';
import 'package:car_store/features/chat_view/presentation/manager/chat_state.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key, required this.idChat});

  String idChat;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit()..getDataUserId(id: idChat),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          foregroundColor: AppColors.primaryColor,
          title: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              if (state is DataUserSuccess) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
                      backgroundImage: NetworkImage(state.userModel.photoURL),
                    ),
                    Gap(10.w),
                    Text(
                      state.userModel.name,
                      style:
                          getTitleStyle(color: AppColors.primaryColor, context),
                    )
                  ],
                );
              } else if (state is DataUserError) {
                return const Text('Error');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        body: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder<DatabaseEvent>(
                      stream: FirebaseDatabase.instance
                          .ref("chats")
                          .child(idChat)
                          .orderByChild("time")
                          .onValue,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          // الحصول على البيانات من الـ snapshot
                          final dataSnapshot = snapshot.data!.snapshot;
                          if (dataSnapshot.value == null) {
                            return const Center(
                              child: Text('No data available'),
                            );
                          }

                          // تحويل البيانات إلى قائمة
                          final chatMap = Map<dynamic, dynamic>.from(
                              dataSnapshot.value as Map);

                          List<dynamic> chatList = chatMap.values.toList();

                          return ListView.builder(
                            reverse: true,
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return BubbleSpecialOne(
                                text: chatList[index]['message'],
                                isSender: chatList[index]['Sender'] ==
                                    FirebaseAuth.instance.currentUser!.uid,
                                color: chatList[index]['Sender'] ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? AppColors.primaryColor
                                    : AppColors.greyColor,
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.whiteColor,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                ),
                                seen: true,
                                sent: true,
                              );
                            },
                          );
                        }
                      }),
                ),
                MessageBar(
                  onSend: (message) {
                    ChatCubit.get(context).sendMessage(
                      message: message,
                      idChat: idChat,
                    );
                  },
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: InkWell(
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.green,
                          size: 24,
                        ),
                        onTap: () {
                          log('Camera');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
/*

BubbleNormalImage(
                              id: 'id001$index',
                              image: Image.network(
                                'https://picsum.photos/250?image=${index == 1 ? '9' : '10'}',
                                fit: BoxFit.fill,
                              ),
                              color: AppColors.primaryColor,
                              isSender: index % 2 == 0 ? true : false,
                              seen: true,
                              sent: true,
                            )






Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.greyColor.withOpacity(0.5),
                ),
                Gap(10.w),
                Container(
                  width: 120.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10.r)),
                )
              ],
            )




 */