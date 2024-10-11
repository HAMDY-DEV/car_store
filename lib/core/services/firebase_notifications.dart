import 'dart:developer';

import 'package:car_store/features/notifications/presentation/view/notifications_vew.dart';
import 'package:car_store/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> init() async {
    await _firebaseMessaging.requestPermission();
    onBackgroundMessageHandler();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    log(message.notification!.title.toString());
    navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) {
      return NotificationsVew(
        message: message,
      );
    }));
  }

  Future onBackgroundMessageHandler() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
