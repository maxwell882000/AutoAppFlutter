import 'package:TestApplication/Pages/Registration.dart';
import 'package:TestApplication/Pages/RegistrationAuto.dart';
import 'package:TestApplication/Pages/SelectUnit.dart';

import 'package:TestApplication/dynamicLinks.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Pages/DirectToThePage.dart';
import 'Pages/Language.dart';
import 'Pages/LogInSelectingOption.dart';

import 'Pages/Login.dart';

import 'Pages/User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      initialRoute: "/authorized",

      routes: <String, WidgetBuilder>{
        "/direct": (context) => DirectToThePage(),
        "/language": (context) => Language(),
        "/select/login": (context) => LogIn(),
        "/select": (context) => LogInSelectingOption(),
        "/select/registration": (context) => Registration(),
        "/authorized/select_unit": (context) => SelectUnit(),
        "/authorized/registration_auto": (context) => RegistrationAuto(),
        "/authorized": (context) => User(),
        "/dynamic": (context) => DynamicLinks(),
      },
    );
  }
}


