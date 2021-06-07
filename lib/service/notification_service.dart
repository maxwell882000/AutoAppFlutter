import 'dart:math';
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
    initializeNotification('create_excell');
    requestPermission();
    setActionListener();
    return this;
  }
 static NotificationService get to => Get.find<NotificationService>();
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

  void createNotificationExcell({String path}) {
    createNotification(
      channelKey: "create_excell",
      body: '${"Вы можете посмотреть в папке".tr} $path',
      title: 'Ваши данные сохранены'.tr,
    );
  }

  void createNotification({
    String channelKey,
    String title,
    String body,
  }) {
    int id = Random().nextInt(100000);
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: id,
      channelKey: channelKey,
      title: title,
      body: body,
    ));
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
        if (ButtonNotificationKeys.TRACKING_KEY ==
            receivedNotification.buttonKeyPressed) {
          Navigator.of(Get.context).pushNamed('/track-user');
        }
      });
    });
  }
}

class ButtonNotificationKeys {
  static String TRACKING_KEY = "tracking_key";
}
