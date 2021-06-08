import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'notification_service.dart';

class LocationService extends GetxService {
  final double MAX_SPEED = 1.3;

  Future init() async{
    await determinePosition();
    return this;
  }
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      NotificationService().createNotification(
          channelKey: "back_channel",
          title: "Ошибка",
          body:
              "Пожалуйста включите геолакацию чтоб использовать все функции приложения");
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      NotificationService().createNotification(
          channelKey: "back_channel",
          title: "Ошибка",
          body:
              "Пожалуйста включите геолакацию чтоб использовать все функции приложения");
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        NotificationService().createNotification(
            channelKey: "back_channel",
            title: "Ошибка",
            body:
                "Пожалуйста включите геолакацию чтоб использовать все функции приложения");
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  Future<Position> getLocation(
      {LocationAccuracy desiredAccuracy = LocationAccuracy.best,
      bool forceAndroidLocationManager = false}) async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: desiredAccuracy,
        forceAndroidLocationManager: forceAndroidLocationManager);
  }

  Future<bool> isSpeedMax() async {
    Position position = await getLocation();
    if (position.speed > MAX_SPEED) {
      return true;
    } else
      return false;
  }
}
