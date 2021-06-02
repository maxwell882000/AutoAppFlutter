import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonGlobal.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:get/get.dart';

class FireBaseService extends GetxService {
  FirebaseMessaging messaging;
  FirebaseApp firebase;

  Future<FireBaseService> init() async {
    firebase = await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    requestPermission();
    listenStreamOnMessage();
    return this;
  }

  static Future<void> backGroundTasks(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("IN THE BACK GROUND ");
    // AwesomeNotifications().createNotificationFromJsonData(message.data);

    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'push_channel',
            title: message.data['title'],
            body: message.data['body'],
            notificationLayout: NotificationLayout.Messaging,
            ));
  }

  void listenStreamOnMessage() {
    FirebaseMessaging.onMessage.listen((event) async {
      await Firebase.initializeApp();
      print("On Message ");
      print(event);
      print(event.messageType);
      print(event.data);
      AwesomeNotifications().createNotification(
          content: NotificationContent(
        id: 10,
        channelKey: 'push_channel',
        title: event.data['title'],
        body: event.data['body'],
      ));
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      await Firebase.initializeApp();
      print("on Message Opened App");
      print(event);
    });
  }

  Future sendOrMissToken() async {
    SingletonGlobal service = SingletonGlobal();
    print('SEND OR MISS TOKEN');
    service.prefs.remove('token');
    if (!service.prefs.containsKey('token') &&
        SingletonUserInformation().isAuthorized) {
      // await messaging.deleteToken();
      String token = await messaging.getToken();
      print(token);
      bool result =
          await SingletonConnection().saveToken(jsonEncode({'token': token}));
      if (result) {
        service.prefs.setString('token', token);
      }
    }
  }

  Future requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
