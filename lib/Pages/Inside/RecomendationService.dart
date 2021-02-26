import 'package:TestApplication/HelperClasses/DropDown/DropDownInformation.dart';
import 'package:TestApplication/HelperClasses/DropDown/ListDropDownInformation.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/BaseOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/Recomendation.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';

import 'package:flutter/material.dart';

class RecomendationService extends StatelessWidget {
  RecomendationService({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MainMenu(
      filterVisible: false,
      nameBar: TextFlexible(
        key: key,
        text: "Рекомендации по сервису ${SingletonUserInformation().marka} ${SingletonUserInformation().model}",
        numberOfCharacters: 25,
      ),
      body: SingleChildScrollView(
        child: Recomendation(
          child:ListDropDownInformation(
            items: SingletonRecomendation().recommendationAll(),
          ) ,
        ),
      )
    );
  }
}