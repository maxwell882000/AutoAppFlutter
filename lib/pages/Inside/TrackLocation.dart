import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonGlobal.dart';
import 'package:flutter_projects/Singleton/SingletonStoreUnits.dart';
import 'package:flutter_projects/Singleton/SingletonUnits.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/InitialPointOfAccount/Base.dart';
import 'package:flutter_projects/helper_clesses/LoadingScreen.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class TrackUser extends StatefulWidget {
  @override
  State<TrackUser> createState() => TrackUserState();
}

class TrackUserState extends State<TrackUser> {
  LatLng previous = new LatLng(0, 0);

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  @override
  void initState() {
    super.initState();

    // _determinePosition()
    //     .then((value) =>
    //     Timer.periodic(Duration(seconds: 10), (timer) {
    //       print('asd');
    //       if (mounted) {
    //         gettinLocation();
    //       } else {
    //         timer.cancel();
    //       }
    //     })
    // );
  }
Future<String> startPoint () async{
    final result =  await _determinePosition();
    Timer.periodic(Duration(seconds: 10), (timer) {
      print('asd');
      if (mounted) {
        gettinLocation();
      } else {
        timer.cancel();
      }
    });
    return "success";
}
  void gettinLocation() {
    Geolocator.getCurrentPosition(
      // intervalDuration: Duration(seconds: 10),
      desiredAccuracy: LocationAccuracy.best,
    ).then((event) {
      if (previous != null) {
        var met = Geolocator.distanceBetween(previous.latitude,
            previous.longitude, event.latitude, event.longitude);
        print("DIFFERENCE");
        print("SPEED ${event.speed}");
        print(met);
        if (met < 30) {
          return;
        } else {
          setState(() {
            previous = LatLng(event.latitude, event.longitude);
            double rightDistance = SingletonUnits()
                .translateDistance(SingletonStoreUnits().distance.M, met);
            SingletonUserInformation()
                .setRun(SingletonUserInformation().run + rightDistance);
            SingletonUserInformation().updateRun();
          });
        }
      }
    });
  }

  Future<String> authorizeUser() async {
    await SingletonGlobal().authorizeUser();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ErrorMessageProvider>(
        create: (context) => new ErrorMessageProvider("s"),
        child: FutureBuilder<String>(
          future:startPoint(), // function where you call your api
          builder: (BuildContext context, AsyncSnapshot<
              String> snapshot) { // AsyncSnapshot<Your object type>
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreenWithScaffold(
                visible: true,
              );
            } else {
              return Base(
                  width: Get.width,
                  height: Get.width * 0.9,
                  icon: "assets/registration.svg",
                  aboveText: "Мы высчитываем приблезительный километраж".tr,
                  child: Text("${previous.latitude}"));
            }
          },
        )
    );
  }
}
