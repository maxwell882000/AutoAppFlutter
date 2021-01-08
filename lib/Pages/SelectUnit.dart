import 'package:TestApplication/HelperClasses/DropDown/ListOfDropDownItemWithText.dart';
import 'package:TestApplication/HelperClasses/SelectOptions.dart';
import 'package:flutter/material.dart';


class SelectUnit extends StatelessWidget {
  final List items = [
    ["Cкорость","Выберите скорость" ,"Километр в секунду ","Метр в секунду ","Километр в час ", "Метр в час","Миля в секунду","Миля в час","Фут в секунду","Фут в час "],
    ["Расстояние", "Выберите растояние" , "Миллиметр","Сантиметр","Метр", "Километр","Инч","Фут","Ярд","Миля"],
    ["Расход топлива", "Выберите расход топлива" ,  "км/л ","л/км ","л/100км ", "ми/л","л/ми","ми/г","г(US)/ми"],
    ["Валюта","Выберите валюту" , "USD","EUR","UZS", "RUB"],
  ];
  SelectUnit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SelectOptions(
      width: width,
      height: width * 1.5,
      icon: "assets/unit.svg",
      aboveText: "Выбор единицы измерения",
      child: ListOfDropDownItemWithText(
        item: items,
        disabledHeightOfItem: width*0.13,
        enabledHeightOfItem: width*0.25,
        width: width,
        heightOfDropDownItems: width*0.77,
      ),
      widthOfButton: width * 0.2,
      heightOfButton: width * 0.018,
    );
  }
}

