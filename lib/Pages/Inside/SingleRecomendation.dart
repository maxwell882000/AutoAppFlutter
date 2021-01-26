import 'package:TestApplication/HelperClasses/InsideOfAccount/BaseOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';

import 'package:flutter/material.dart';

class SingleRecomendation extends StatelessWidget {
  SingleRecomendation({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainMenu(
      nameBar: TextFlexible(
        key: key,
        text: "Рекомендации по замене моторного масла для CHEVROLET GENTRA",
        numberOfCharacters: 25,
      ),
    );
  }
}