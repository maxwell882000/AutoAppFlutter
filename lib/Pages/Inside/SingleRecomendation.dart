import 'package:TestApplication/HelperClasses/InsideOfAccount/BaseOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/Recomendation.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SingleRecomendation extends StatelessWidget {
  SingleRecomendation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return MainMenu(
      filterVisible:false,
      nameBar: TextFlexible(
        key: key,
        text: "Рекомендации по ${SingletonRecomendation().choosenRecommendation.mainName} для ${SingletonUserInformation().marka} ${SingletonUserInformation().model}",
        numberOfCharacters: 25,
      ),
      body: Recomendation(
        child:  Expanded(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width*0.02),
            ),
            child: Container(
              margin: EdgeInsets.all(width*0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(SingletonRecomendation().choosenRecommendation.description,
                        style: TextStyle(
                          color: HexColor("#42424A"),
                          fontFamily: 'Montserrat',
                          fontSize: width * 0.03,
                          fontWeight: FontWeight.w500,
                        ),)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}