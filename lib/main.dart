

import 'package:TestApplication/Pages/Inside/CreateCards.dart';
import 'package:TestApplication/Pages/Inside/Menu.dart';
import 'package:TestApplication/Pages/Inside/ModifyCards.dart';
import 'package:TestApplication/Pages/Inside/PointerLocation.dart';
import 'package:TestApplication/Pages/Inside/ProPurchase.dart';
import 'package:TestApplication/Pages/Inside/RecomendationService.dart';
import 'package:TestApplication/Pages/Inside/SingleRecomendation.dart';
import 'file:///F:/ProjectsWork/FlutterProjects/AutoApp/AutoApp/lib/Pages/Inside/Map.dart';
import 'package:TestApplication/dynamicLinks.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'Pages/Initial/DirectToThePage.dart';
import 'Pages/Initial/Language.dart';
import 'Pages/Initial/LogIn.dart';
import 'Pages/Initial/LogInSelectingOption.dart';



import 'Pages/Inside/User.dart';
import 'Pages/Registration/Registration.dart';
import 'Pages/Registration/RegistrationAuto.dart';
import 'Pages/Registration/SelectUnit.dart';
import 'Pages/Inside/Adds.dart';

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
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(color: Color(0xFFF5F5F5),)),
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
        "/menu":(context)=> Menu(),
        "/location": (context) => PointerLocation(),
        "/pro_account":(context) => ProPurchase(),
        "/adds":(context) => Adds(),
      },
    );
  }
}


