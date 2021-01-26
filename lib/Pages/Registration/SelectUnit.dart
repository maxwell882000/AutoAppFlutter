import 'dart:convert';

import 'package:TestApplication/HelperClasses/DropDown/ListOfDropDownItemWithText.dart';
import 'package:TestApplication/HelperClasses/SelectOptions.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:TestApplication/Singleton/SingletonRegistrationAuto.dart';
import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SelectUnit extends StatelessWidget {
  final List items = [
    ["Cкорость","Выберите скорость" ,"Километр в секунду ","Метр в секунду ","Километр в час ", "Метр в час","Миля в секунду","Миля в час","Фут в секунду","Фут в час "],
    ["Расстояние", "Выберите растояние" , "Миллиметр","Сантиметр","Метр", "Километр","Инч","Фут","Ярд","Миля"],
    ["Расход топлива", "Выберите расход топлива" ,  "км/л ","л/км ","л/100км ", "ми/л","л/ми","ми/г","г(US)/ми"],
    ["Валюта","Выберите валюту" , "USD","EUR","UZS", "RUB"],
  ];
  SelectUnit({Key key}) : super(key: key);
  final ErrorMessageProvider selectOptionsErrorProvider =
  new ErrorMessageProvider("");

  Function readyToTheNext( Function loadToHard){
  return (BuildContext context) {
    var errors = selectOptionsErrorProvider.errorsMessageWithText;
    var selected = errors
        .where((element) => !element[1].selected)
        .map((element) => errors.indexOf(element));
    if (selected.length == 0) {
      selectOptionsErrorProvider.setNextPage(true);
      loadToHard(errors);
    } else {
      selected.forEach((element) {
        var error = errors[element];
        error[1].setError(true);
        error[1].setNameOfHelper("Здесь ничего не выбрано");
      });
    }
  };
  }

  Function getUnits(BuildContext context) {
    return (var errorMessageProvider) async {
      SingletonUnits().setSpeed(errorMessageProvider[0][1].inputData);
      SingletonUnits().setDistance(errorMessageProvider[1][1].inputData);
      SingletonUnits().setFuelConsumption(errorMessageProvider[2][1].inputData);
      SingletonUnits().setCurrency(errorMessageProvider[3][1].inputData);
      SingletonUnits().setToTheDisk();
      http.put(
          'https://autoapp.elite-house.uz/units/${SingletonUserInformation().emailOrPhone}/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(SingletonUnits().toJson()));
      final items = await http.get(
        'https://autoapp.elite-house.uz/marka/'
      );
      jsonDecode(items.body).forEach((e)=> SingletonRegistrationAuto().fromJson(e));
      SingletonRegistrationAuto().finish();
      Navigator.of(context).pushNamed("/registration_auto");
    };
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider.value(
      value: selectOptionsErrorProvider,
      child: SelectOptions(
        key: UniqueKey(),
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
          provider:selectOptionsErrorProvider,
        ),
        loadToHard: getUnits(context),
        clickEvent: readyToTheNext,
        widthOfButton: width * 0.2,
        heightOfButton: width * 0.018,
      ),
    );
  }
}

