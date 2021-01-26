import 'package:TestApplication/HelperClasses/InsideOfAccount/BaseOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';

import 'package:flutter/material.dart';

class ModifyCards extends StatelessWidget {
  ModifyCards({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainMenu(
        nameBar: TextFlexible(
        key: key,
        text: "Редактирование карточки замена моторное масло",
        numberOfCharacters: 25,
    ),
    );
  }
}