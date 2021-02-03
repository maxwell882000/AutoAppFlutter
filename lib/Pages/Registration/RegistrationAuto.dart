import 'dart:convert';

import 'package:TestApplication/HelperClasses/DropDown/ListOfDropDownItemWithText.dart';

import 'package:TestApplication/HelperClasses/SelectOptions.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TestApplication/Singleton/SingletonRegistrationAuto.dart';
import 'package:http/http.dart' as http;
class RegistrationAuto extends StatelessWidget {

  RegistrationAuto({Key key}) : super(key: key);
  final ErrorMessageProvider selectOptionsErrorProvider =
  new ErrorMessageProvider("");

  Function readyToTheNext(Function loadToHard){
    return (BuildContext context) {
      var errors = selectOptionsErrorProvider.errorsMessageWithText;
      var selected = errors
          .where((element) => !element[1].selected && element[0]!= "ТЕХ ПАСПОРТ")
          .map((element) => errors.indexOf(element));

      if (selected.length == 0) {
        // selectOptionsErrorProvider.setNextPage(true);
        loadToHard(errors);
      } else {
        selected.forEach((element) {
          var error = errors[element];
          print(error);
          error[1].setError(true);
        });
      }
    };
  }

  Function getInformationCar(BuildContext context){
    return(var errors){
      SingletonUserInformation().setNameOfTransport(errors[0][1].inputData);
      SingletonUserInformation().setMarka(errors[1][1].inputData);
      SingletonUserInformation().setModel(errors[2][1].inputData);
      SingletonUserInformation().setYearOfMade(errors[3][1].inputData);
      SingletonUserInformation().setYearOfPurchase(errors[4][1].inputData);
      SingletonUserInformation().setNumber(errors[5][1].inputData);
      SingletonUserInformation().setRun(double.parse(errors[6][1].inputData));
      SingletonUserInformation().setTechPassport(errors[7][1].inputData);
      SingletonUserInformation().setNumberOfTank(int.parse(errors[8][1].inputData));
      SingletonUserInformation().setFirstTankType(errors[9][1].inputData);
      SingletonUserInformation().setFirstTankVolume(int.parse(errors[10][1].inputData));
      SingletonUserInformation().setInitialRun(SingletonUserInformation().run);
      print("Run ${SingletonUserInformation().run}");
      print("Run after ${SingletonUnits().convertDistanceForDB(SingletonUserInformation().run)}");
      if (SingletonUserInformation().numberOfTank == 2){
        SingletonUserInformation().setSecondTankType(errors[11][1].inputData);
        SingletonUserInformation().setSecondTankVolume(int.parse(errors[12][1].inputData));
      }
      else{
        SingletonUserInformation().setSecondTankType("");
        SingletonUserInformation().setSecondTankVolume(0);
      }
      SingletonUserInformation().setDate(DateTime.now());
      //SingletonUserInformation().setToTheDisk();
      http.post(
          'https://autoapp.elite-house.uz/transport/${SingletonUserInformation().emailOrPhone}/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(SingletonUserInformation().toJson()));

        Navigator.of(context).pushNamed("/authorized");
    };
  }

  void dispose(){
    selectOptionsErrorProvider.dispose();
  }
  @override
  Widget build(BuildContext context) {
    selectOptionsErrorProvider.setItems(SingletonRegistrationAuto().item);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider.value(
      value:selectOptionsErrorProvider,
      child: SelectOptions(
        icon: "assets/carfront.svg",
        aboveText: "Регистрация Транспортного Средства",
        width: width,
        height: height * 0.9,
        clickEvent: readyToTheNext,
        loadToHard: getInformationCar(context),
        child: ListOfDropDownItemWithText(
          itemWithTextField: selectOptionsErrorProvider.items,
          disabledHeightOfItem: width * 0.12,
          enabledHeightOfItem: width * 0.25,
          width: width,
          heightOfDropDownItems: width * 1.1,
          provider: selectOptionsErrorProvider,
        ),
        widthOfButton: width * 0.2,
        heightOfButton: width * 0.026,
      ),
    );
  }
}
