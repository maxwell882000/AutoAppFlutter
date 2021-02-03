import 'dart:convert';

import 'package:TestApplication/HelperClasses/DropDown/ListOfDropDownItemWithText.dart';
import 'package:TestApplication/HelperClasses/SelectOptions.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:TestApplication/Singleton/SingletonRegistrationAuto.dart';
import 'package:TestApplication/Singleton/SingletonStoreUnits.dart';
import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SelectUnit extends StatelessWidget {
  final List items = [
  ["Cкорость","Выберите скорость" ,SingletonStoreUnits().speed.KM_C,SingletonStoreUnits().speed.M_C,SingletonStoreUnits().speed.KM_H,SingletonStoreUnits().speed.M_H,SingletonStoreUnits().speed.KM_D,SingletonStoreUnits().speed.M_D,SingletonStoreUnits().speed.KM_Y,SingletonStoreUnits().speed.M_Y],
  ["Расстояние", "Выберите растояние",SingletonStoreUnits().distance.CM,SingletonStoreUnits().distance.KM,SingletonStoreUnits().distance.M,SingletonStoreUnits().distance.MM],
  ["Расход топлива", "Выберите расход топлива" , SingletonStoreUnits().fuelConsumption.KM_L,SingletonStoreUnits().fuelConsumption.L_100KM,SingletonStoreUnits().fuelConsumption.L_KM],
  ["Валюта","Выберите валюту" ,  SingletonStoreUnits().currency.EUR,SingletonStoreUnits().currency.RUB,SingletonStoreUnits().currency.USD,SingletonStoreUnits().currency.UZS],
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
      print(SingletonUserInformation().emailOrPhone);
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

