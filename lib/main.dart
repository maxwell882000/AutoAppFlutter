

import 'package:TestApplication/Pages/Inside/CreateCards.dart';
import 'package:TestApplication/Pages/Inside/ModifyCards.dart';
import 'package:TestApplication/Pages/Inside/RecomendationService.dart';
import 'package:TestApplication/Pages/Inside/SingleRecomendation.dart';
import 'package:TestApplication/dynamicLinks.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Pages/Initial/DirectToThePage.dart';
import 'Pages/Initial/Language.dart';
import 'Pages/Initial/LogIn.dart';
import 'Pages/Initial/LogInSelectingOption.dart';



import 'Pages/Inside/User.dart';
import 'Pages/Registration/Registration.dart';
import 'Pages/Registration/RegistrationAuto.dart';
import 'Pages/Registration/SelectUnit.dart';

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

      initialRoute: "/direct",

      routes: <String, WidgetBuilder>{
        "/direct": (context) => DirectToThePage(),
        "/language": (context) => Language(),
        "/select/login": (context) => LogIn(),
        "/select": (context) => LogInSelectingOption(),
        "/select/registration": (context) => Registration(),
        "/select_unit": (context) => SelectUnit(),
        "/registration_auto": (context) => RegistrationAuto(),
        "/authorized": (context) => User(),
        "/create_cards":(context) => CreateCards(),
        "/modify_cards":(context) => ModifyCards(),
        "/recomendation_service":(context) => RecomendationService(),
        "/single_recomendation":(context) => SingleRecomendation(),
        "/dynamic": (context) => DynamicLinks(),
      },
    );
  }
}


