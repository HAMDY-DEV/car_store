import 'package:car_store/core/util/text_style.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationsVew extends StatelessWidget {
  NotificationsVew({super.key, required this.message});
  RemoteMessage message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
        child: Text(
          message.notification!.body.toString(),
          style: getTitleStyle(context),
        ),
      ),
    );
  }
}
