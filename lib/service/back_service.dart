
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_projects/service/notification_service.dart';
import 'package:workmanager/workmanager.dart';

class BackService {
  static void startBackGroundTask(Function backTask) {

  }
  static void  backTask() {
    NotificationService.initializeNotification('basic_channel');
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          title: 'Simple Notification',
          body: 'Simple body'
      ),
      actionButtons: [
        NotificationActionButton(
            key: "10",
            label: "Something",
            enabled: true,
            buttonType: ActionButtonType.Default
        )
      ],
    );
  }
}