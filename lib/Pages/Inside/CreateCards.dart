import 'package:TestApplication/HelperClasses/Dialog/DataNotSave.dart';
import 'package:TestApplication/HelperClasses/LoadingScreen.dart';
import 'package:TestApplication/HelperClasses/TextInput/TextFieldHelper.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:TestApplication/Singleton/SingletonConnection.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/CardsUser.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class CreateCards extends StatelessWidget {
  CreateCards({Key key}) : super(key: key);

  final ErrorMessageProvider provider =
      new ErrorMessageProvider("Выберите название");
  final ErrorMessageProvider runProvider =
      new ErrorMessageProvider("Введите пробег");
  final ErrorMessageProvider commentsProvider =
      new ErrorMessageProvider("Ваш комментарий");
  final ErrorMessageProvider finishProvider =
      new ErrorMessageProvider("Введите пробег");
  final ErrorMessageProvider dateProvider = new ErrorMessageProvider("Дата");

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
      if (SingletonRecomendation().checkRecomm(provider.inputData) ==0 && finishProvider.inputData.isEmpty) {
        error = true;
        finishProvider.setError(true);
      }

      if (card.attach.uploadedImage.length != card.attach.updatedImage.length) {
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Ожидание загрузки фото',
                style: TextStyle(
                  color: HexColor("#42424A"),
                  fontFamily: 'Montserrat',
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ок'),
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
            .setDate(DateTime.parse(dateProvider.inputData));

        if (runProvider.inputData.isNotEmpty) {
          double run = double.parse(runProvider.inputData);
          if (run >= SingletonUserInformation().run) {
            SingletonUserInformation().setRun(run);
            SingletonUserInformation().updateRun();
          } else {
            runProvider.setNameOfHelper("Пробег всегда должен увеличиваться");
            runProvider.setError(true);
            return;
          }
        }

        SingletonUserInformation()
            .newCard
            .setComments(commentsProvider.inputData);
        if (finishProvider.inputData.isNotEmpty) {
          double run = double.parse(finishProvider.inputData) +
              SingletonUserInformation().run;
          SingletonUserInformation().newCard.change.setRun(run);
        }

        Navigator.of(context).pop(true);
      }
    };
  }

  Function _onWillPop(BuildContext context)  {

    return  () async{

      final bool response = await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DataNotSave()
      );
      if(response){
        List image = SingletonUserInformation().newCard.attach.uploadedImage;
        image.forEach((element) {
          SingletonConnection().deleteImage(element);
        });
      }
      return response;
    };
  }

  Function recomendationCards() {
    return (context) {

      final result = Navigator.of(context).pushNamed("/recomendation_service");

    };
  }

  Function finish(double width) {
    return (BuildContext context) {
      final ErrorMessageProvider provider =
          Provider.of<ErrorMessageProvider>(context);
      print(provider.inputData.isEmpty);
      final double run =
          SingletonRecomendation().recommendationProbeg(provider.inputData);
      print(run);
      if (run != null) finishProvider.setError(false);
      finishProvider.setRecommendations(
        SizedBox(
            height: width * 0.1,
            child: Container(
              margin: EdgeInsets.only(right: width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    run == null ? "" : "$run ${SingletonUnits().distance}",
                    style: TextStyle(
                      color: HexColor("#42424A"),
                      fontFamily: 'Roboto',
                      fontSize: width * 0.035,
                    ),
                  ),
                ],
              ),
            )),
      );
      if (run != null)
        SingletonUserInformation()
            .newCard
            .change
            .setRun(run + SingletonUserInformation().run);
      return Expanded(
        child: ChangeNotifierProvider.value(
          value: finishProvider,
          child: TextFieldHelper(
            onlyInteger: true,
          ),
        ),
      );
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
          provider: provider,
          runProvider: runProvider,
          commentsProvider: commentsProvider,
          dateProvider: dateProvider,
          nameButton: "Готово",
          appBarName: "Создание карточки",
          recommendationFunction: recomendationCards(),
          childAboveButton: [
            'assets/reload.svg',
            "Закончить через ",
            finish(width)
          ],
          readyButton: ready(width),
        ),
      ),
    );
  }
}
