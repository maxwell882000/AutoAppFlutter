
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonRecomendation.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/Dialog/DataNotSave.dart';
import 'package:flutter_projects/helper_clesses/InsideOfAccount/CardsUser.dart';
import 'package:flutter_projects/helper_clesses/Static/CardStatic.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
class CreateCards extends StatefulWidget {
  CreateCards({Key key}) : super(key: key);

  @override
  _CreateCardsState createState() => _CreateCardsState();
}

class _CreateCardsState extends State<CreateCards> {
  final ErrorMessageProvider provider =
      new ErrorMessageProvider("Выберите название".tr);

  final ErrorMessageProvider runProvider =
      new ErrorMessageProvider("Введите текущий пробег".tr);

  final ErrorMessageProvider commentsProvider =
      new ErrorMessageProvider("Ваш комментарий".tr);

  final ErrorMessageProvider repeatDistProvider =
      new ErrorMessageProvider("Введите растояние".tr);

  final ErrorMessageProvider repeatTimeProvider =
      new ErrorMessageProvider("Введите количество дней".tr);

  final GlobalKey<FormState> _destForm = new GlobalKey<FormState>();

  final GlobalKey<FormState> _timeForm = new GlobalKey<FormState>();

  final ErrorMessageProvider dataProvider = new ErrorMessageProvider("Введите дату".tr);

  Function sendData() {
    return (BuildContext context) {};
  }

  Function ready(double width) {
    return (BuildContext context) {
      bool error = false;
      CardUser card = SingletonUserInformation().newCard;
      if (provider.inputData.isEmpty) {
        error = true;
        provider.setError(true);
      }
      if (SingletonRecomendation().checkRecomm(provider.inputData) == 0 &&
          repeatTimeProvider.inputData.isEmpty &&
          repeatDistProvider.inputData.isEmpty) {
        error = true;
        repeatDistProvider.setError(true);
      }
      if (card.attach.uploadedImage.length != card.attach.updatedImage.length) {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Ожидание загрузки фото'.tr,
                style: TextStyle(
                  color: HexColor("#42424A"),
                  fontFamily: 'Montserrat',
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ок'.tr),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }
      if (!error) {
        SingletonUserInformation().newCard.setNameOfCard(provider.inputData);
        SingletonUserInformation()
            .newCard
            .setDate(DateTime.now());

        if (runProvider.inputData.isNotEmpty) {
          double run = double.parse(runProvider.inputData);
          if (run >= SingletonUserInformation().run) {
            SingletonUserInformation().setRun(run);
            SingletonUserInformation().updateRun();
          } else {
            runProvider.setNameOfHelper("Пробег всегда должен увеличиваться".tr);
            runProvider.setError(true);
            return;
          }
        }

        SingletonUserInformation()
            .newCard
            .setComments(commentsProvider.inputData);
        if (repeatDistProvider.inputData.isNotEmpty) {
          double run = double.parse(repeatDistProvider.inputData) +
              SingletonUserInformation().run;
          SingletonUserInformation().newCard.change.setRun(run);
          SingletonUserInformation().newCard.change.setTime(0);
        } else if (repeatTimeProvider.inputData.isNotEmpty) {
          SingletonUserInformation()
              .newCard
              .change
              .setTime(int.parse(repeatTimeProvider.inputData));
          SingletonUserInformation().newCard.change.setRun(0);
        }

        Navigator.of(context).pop(true);
      }
    };
  }



  Function _onWillPop(BuildContext context) {
    return () async {
      final bool response = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DataNotSave());
      if (response) {
        SingletonConnection().cleanTemp();
      }
      return response;
    };
  }

  Function recomendationCards(BuildContext cont) {
    return (context) {
      if (SingletonRecomendation().chosenRecommend(provider.inputData) ==
          null) {
        Navigator.of(cont).pushNamed("/recomendation_service");
      } else {
        Navigator.of(cont).pushNamed("/single_recomendation");
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop(context),
      child: ChangeNotifierProvider.value(
        value: provider,
        child: CardsUser(
          onPop: _onWillPop(context),
          provider: provider,
          runProvider: runProvider,
          commentsProvider: commentsProvider,
          dateProvider: dataProvider,
          nameButton: "Готово".tr,
          appBarName: "Создание карточки".tr,
          recommendationFunction: recomendationCards(context),
          childAboveButton: [
            'assets/reload.svg',
            "Заполанировать".tr + "\n" + "замену".tr,
            CardStatic.choiceWidget(width, repeatDistProvider, repeatTimeProvider,_destForm, _timeForm)
          ],
          readyButton: ready(width),
        ),
      ),
    );
  }
}
