import 'package:TestApplication/HelperClasses/InsideOfAccount/BaseOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/Cards.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/Indicator.dart';
import 'file:///F:/ProjectsWork/FlutterProjects/AutoApp/AutoApp/lib/HelperClasses/DropDown/ListFee.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';
import 'package:TestApplication/HelperClasses/TextInput/TextFieldHelper.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ModifyCards extends StatefulWidget {
  final String appBarName;
  final double dataToBeHandeled;
  final Function logic;
  ModifyCards({Key key,this.appBarName,this.logic, this.dataToBeHandeled}) : super(key: key);

  @override
  _ModifyCardsState createState() => _ModifyCardsState(
    appBarName:appBarName,
    dataToBeHandeled:dataToBeHandeled,
    logic : logic,
  );
}

class _ModifyCardsState extends State<ModifyCards> {
  final String appBarName;
  final double dataToBeHandeled;
  final Function logic;
  _ModifyCardsState({this.appBarName,this.dataToBeHandeled,this.logic});
  final ErrorMessageProvider provider =
  new ErrorMessageProvider("");

  final ErrorMessageProvider runProvider =
  new ErrorMessageProvider("Введите пробег");

  final ErrorMessageProvider commentsProvider =
  new ErrorMessageProvider("Ваш комментарий");
  final ErrorMessageProvider repeatDistProvider = new ErrorMessageProvider("Введите расстояние");
  final ErrorMessageProvider repeatTimeProvider = new ErrorMessageProvider("Введите число");

  List fee = [];

  Function choiceWidget (ErrorMessageProvider distance, ErrorMessageProvider time, double width)
  {
    return () => Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChangeNotifierProvider.value(
            value: distance,
            child:TextFieldHelper() ,
          ),
          SizedBox(
            height: width*0.02,
          ),
          Text("Или"),
          SizedBox(
            height: width*0.02,
          ),
          ChangeNotifierProvider.value(
            value: time,
            child:TextFieldHelper() ,),
        ],
      ),
    );
  }
  Function recomendationCards(){
    return(context){
      Navigator.of(context).pushNamed("/single_recomendation");
    };
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.setNameOfHelper(appBarName);
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Cards(
      recommendationFunction: recomendationCards(),
      secondChild: Indicator(
        textOfIndicator: appBarName,
        logicForIndicator: logic,
        dataToBeHandled: dataToBeHandeled,
        modifying: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
                child: Text("на 5304 км\nчерез 5234 дней",
              textAlign: TextAlign.end,
              style: TextStyle(
                color:HexColor("42424A"),
                fontFamily: 'Roboto',
                fontSize: width*0.03
              ),
              ),
            ),
          ],
        ),
      ),
      middleChild: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: width*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Расходы",
                  style: TextStyle(
                    color: HexColor("#42424A"),
                    fontFamily: 'Montserrat',
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: width*0.1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListFee(
                        fee: [
                          ["Some expense", "222price"],
                          ["Some expense", "222price"],
                          ["Some expense", "222price"],
                        ],
                      ),
                      SizedBox(height: width*0.01,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){},
                            child: SvgPicture.asset(
                              'assets/add.svg',
                              width: width*0.055,
                            ),
                          ),
                          SizedBox(width: width*0.02,),
                          Text("Добавить",
                                style: TextStyle(
                                  color: HexColor("#42424A"),
                                  fontFamily: 'Montserrat',
                                  fontSize: width * 0.032,
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      childAboveButton: ['assets/reload.svg',"Повторить через ", choiceWidget(repeatDistProvider,repeatTimeProvider,width)],
      provider: provider,
      runProvider: runProvider,
      commentsProvider: commentsProvider,
      nameButton: "Сохранить",
      appBarName: "Редактирование карточки $appBarName",
    );
  }
}