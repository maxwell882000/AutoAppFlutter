import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/route/go_page.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  Future init() async {
    initializeNotification('usual');
    initializeNotification('press_channel');
    initializeNotification('push_channel');
    requestPermission();
    setActionListener();
    return this;
  }

  static void initializeNotification(String channelKey) {
    AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelKey: channelKey,
              playSound: true,
              channelName: 'Basic notifications',
              channelDescription: 'Notification channel for basic tests',
              defaultColor: Colors.white,
              ledColor: Colors.white)
        ]);
  }

  void requestPermission() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void setActionListener() {
    AwesomeNotifications().actionStream.listen((receivedNotification) {

      print(receivedNotification.buttonKeyPressed);
      print(receivedNotification.buttonKeyInput);


      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (ButtonNotificationKeys.TRACKING_KEY == receivedNotification.buttonKeyPressed) {
          Navigator.of(Get.context).pushNamed('/track-user');
        }
      });
    });

  }
}

class ButtonNotificationKeys {
  static String TRACKING_KEY = "tracking_key";
}