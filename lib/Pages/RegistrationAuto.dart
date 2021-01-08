import 'package:TestApplication/HelperClasses/DropDown/ListOfDropDownItemWithText.dart';

import 'package:TestApplication/HelperClasses/SelectOptions.dart';
import 'package:flutter/material.dart';

class RegistrationAuto extends StatelessWidget {
  final List items = [
    ["НАЗВАНИЕ","Выберите название" , "Км/c", "М/с", "Км/ч", "М/ч"],
    ["МАРКА","Выберите марку" ,"Км/c", "М/с", "Км/ч", "М/ч"],
    ["МОДЕЛЬ","Выберите модель" ,"Км/c", "М/с", "Км/ч", "М/ч"],
    ["ГОД ПРОИЗВОДСТВА","Выберите год производства","Км/c", "М/с", "Км/ч", "М/ч"],
    ["ГОД ПРИОБРЕТЕНИЯ","Выберите год приобретения" ,"Км/c", "М/с", "Км/ч", "М/ч"],
    ["НОМЕР", "Выберите номер","Км/c", "М/с", "Км/ч", "М/ч"],
    ["КОЛИЧЕСТВО БАКОВ","Выберите количество баков" ,"Км/c", "М/с", "Км/ч", "М/ч"],
    ["ТИП", "Выберите тип","Км/c", "М/с", "Км/ч", "М/ч"],
    ["ОБЪЁМ","Выберите объём " ,"Км/c", "М/с", "Км/ч", "М/ч"],
  ];
  RegistrationAuto({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SelectOptions(
      icon: "assets/carfront.svg",
      aboveText: "Регистрация Транспортного Средства",
      width: width,
      height: height * 0.9,
      child: ListOfDropDownItemWithText(
        item: items,
        disabledHeightOfItem: width * 0.12,
        enabledHeightOfItem: width * 0.25,
        width: width,
        heightOfDropDownItems: width * 1.1,
      ),
      widthOfButton: width * 0.2,
      heightOfButton: width * 0.026,
    );
  }
}
