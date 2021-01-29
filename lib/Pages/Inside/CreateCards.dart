
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/Cards.dart';

class CreateCards extends StatelessWidget {
  CreateCards({Key key}) : super(key: key);

  final ErrorMessageProvider provider =
      new ErrorMessageProvider("Выберите название");
  final ErrorMessageProvider runProvider =
      new ErrorMessageProvider("Введите пробег");
  final ErrorMessageProvider commentsProvider =
      new ErrorMessageProvider("Ваш комментарий");
  Function recomendationCards(){
    return(context){
      Navigator.of(context).pushNamed("/recomendation_service");
    };
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Cards(
      provider: provider,
      runProvider: runProvider,
      commentsProvider: commentsProvider,
      nameButton: "Готово",
      appBarName: "Создание карточки",
      recommendationFunction: recomendationCards(),
    );
  }
}
