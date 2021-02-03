import 'package:TestApplication/HelperClasses/AnimatedContainerBorder.dart';
import 'package:TestApplication/HelperClasses/Buttons.dart';
import 'package:TestApplication/HelperClasses/DropDown/DropDownItem.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';
import 'package:TestApplication/HelperClasses/TextInput/TextFieldHelper.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Cards extends StatefulWidget {
  final ErrorMessageProvider provider;
  final ErrorMessageProvider runProvider;
  final ErrorMessageProvider commentsProvider;
  final Function recommendationFunction;
  final Function readyButton;
  final String nameButton;
  final List childAboveButton;
  final Widget middleChild;
  final Widget secondChild;
  final String appBarName;

  Cards(
      {Key key,
      this.provider,
      this.commentsProvider,
      this.runProvider,
      this.recommendationFunction,
      this.readyButton,
      this.nameButton,
      this.childAboveButton,
      this.middleChild,
      this.secondChild,
      this.appBarName})
      : super(key: key);

  @override
  _CardsState createState() => _CardsState(
        provider: provider,
        runProvider: runProvider,
        commentsProvider: commentsProvider,
        recommendationFunction: recommendationFunction,
        readyButton: readyButton,
        nameButton: nameButton,
        secondChild: secondChild,
        middleChild: middleChild,
        appBarName: appBarName,
        childAboveButton: childAboveButton,
      );
}

class _CardsState extends State<Cards> {
  final ErrorMessageProvider provider;

  final ErrorMessageProvider runProvider;
  final ErrorMessageProvider commentsProvider;
  final Function recommendationFunction;
  final Function readyButton;
  final String nameButton;
  final List childAboveButton;
  final Widget middleChild;
  final Widget secondChild;
  final String appBarName;
  Widget swap;
  String chosenDate = "";

  _CardsState({
    this.provider,
    this.commentsProvider,
    this.runProvider,
    this.recommendationFunction,
    this.readyButton,
    this.nameButton,
    this.childAboveButton,
    this.middleChild,
    this.secondChild,
    this.appBarName,
  });

  Widget swapToDrop(double width) {
    return DropDownItem(
      items: ['Something', 'SomeThing', 'TwoSomething'],
      width: width,
      enabledHeight: width * 0.35,
      disabledHeight: width * 0.122,
      iconsAddition: rowIcons(width),
    );
  }

  Widget swapToText(double width) {
    return TextFieldHelper(
      suffixIcon: SizedBox(width: width * 0.165, child: rowIcons(width)),
    );
  }

  Widget textStart(double width) {
    swap = AnimatedContainerBorder(
      duration: 600,
      child: Container(
        margin: EdgeInsets.all(width*0.03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(provider.nameOfHelper,
          style: TextStyle(
              color: HexColor("#42424A"),
              fontFamily: "Roboto",
              fontSize: width * 0.03),
            ),
            pencil(width),
          ],
        ),
      ),
    );
    return  swap;
  }

  Widget pencil(double width) {
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.setNameOfHelper("Введите название");
          provider.setInputData("");
          swap = swapToText(width);
        });
      },
      child: SvgPicture.asset(
        'assets/pencil.svg',
      ),
    );
  }

  Widget arrow(double width) {
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.setNameOfHelper("Выберите название");
          provider.setInputData("");
          swap = swapToDrop(width);
        });
      },
      child: SvgPicture.asset('assets/arrow_down.svg'),
    );
  }

  Widget Dates(double width, Widget child) {
    return AnimatedContainerBorder(
      duration: 100,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        height: sizeGeneral(width),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            child,
            Text(
              chosenDate,
              style: TextStyle(
                  color: HexColor("#42424A"),
                  fontFamily: "Roboto",
                  fontSize: width * 0.03),
            )
          ],
        ),
      ),
    );
  }

  Widget rowIcons(double width) {
    return Row(
      children: [
        pencil(width),
        SizedBox(
          width: width * 0.05,
        ),
        arrow(width),
      ],
    );
  }

  double sizeGeneral(double width) {
    return width * 0.12;
  }

  Widget marginHeight(double width) {
    return SizedBox(
      height: width * 0.025,
    );
  }

  Widget marginWidth(double width) {
    return SizedBox(
      width: width * 0.01,
    );
  }

  Widget rowSvgText(String svg, String text, double width) {
    return Row(
      children: [
        SvgPicture.asset(
          svg,
          width: sizeSvg(width),
        ),
        marginWidth(width),
        marginWidth(width),
        marginWidth(width),
        Text(
          text,
          style: TextStyle(
            color: HexColor("#42424A"),
            fontFamily: 'Montserrat',
            fontSize: width * 0.035,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  double sizeSvg(double width) {
    return width * 0.05;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
      value: provider,
      child: MainMenu(
        nameBar: TextFlexible(
          text: appBarName,
          numberOfCharacters: 25,
        ),
        body: Container(
          margin: EdgeInsets.only(top: width * 0.05),
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  secondChild != null
                      ? Column(
                          children: [
                            swap != null
                                ? swap
                                : textStart(width),
                            marginHeight(width),
                            secondChild,
                          ],
                        )
                      : swap != null
                          ? swap
                          : swapToDrop(width),
                  marginHeight(width),
                  Buttons(
                    hexValueOFColor: "#32BEA6",
                    width: width,
                    nameOfTheButton: "Рекомендации по сервису Chevrolet Gentra",
                    height: width * 1.2,
                    onPressed: recommendationFunction,
                  ),
                  marginHeight(width),
                  marginHeight(width),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        setState(() {
                          final f = new DateFormat.yMd().add_Hm();
                          chosenDate = f.format(date);
                          // chosenDate = "${date.day}.${date.month}.${date.year}/${date.hour}:${date.minute}";
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.ru);
                    },
                    child: Dates(
                        width,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              'assets/calendar.svg',
                              width: width * 0.05,
                            ),
                            marginWidth(width),
                            Text(
                              "Дата",
                                  style: TextStyle(
                                    color: HexColor("#42424A"),
                                    fontFamily: 'Montserrat',
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        )),
                  ),
                  marginHeight(width),
                  ChangeNotifierProvider.value(
                    value: runProvider,
                    child: TextFieldHelper(
                      prefixIcon: Container(
                        margin: EdgeInsets.only(left: width * 0.03),
                        width: width * 0.1,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/car.svg',
                              width: width * 0.07,
                            ),
                          ],
                        ),
                      ),
                      suffixIcon: SizedBox(
                          height: width * 0.1,
                          child: Container(
                            margin: EdgeInsets.only(right: width * 0.03),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("57000000 км",
                                  style: TextStyle(
                                    color: HexColor("#42424A"),
                                    fontFamily: 'Montserrat',
                                    fontSize: width * 0.035,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  marginHeight(width),
                  middleChild != null
                      ? Column(children: [
                          middleChild,
                          marginHeight(width),
                        ])
                      : marginHeight(width),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      rowSvgText("assets/clip.svg", "Прикрепить", width),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/gallery.svg',
                            width: sizeSvg(width),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          SvgPicture.asset(
                            'assets/camera.svg',
                            width: sizeSvg(width),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          SvgPicture.asset(
                            'assets/location.svg',
                            width: width * 0.03,
                          ),
                        ],
                      )
                    ],
                  ),
                  marginHeight(width),
                  marginHeight(width),
                  marginHeight(width),
                  SizedBox(
                    height: width * 0.1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          rowSvgText(
                              "assets/speech_bubble.svg", "Комментарии", width),
                          marginWidth(width),
                          marginWidth(width),
                          marginWidth(width),
                          Expanded(
                            child: SizedBox(
                                width: width * 0.5,
                                child: ChangeNotifierProvider.value(
                                    value: commentsProvider,
                                    child: TextFieldHelper())),
                          )
                        ]),
                  ),
                  childAboveButton != null
                      ? Column(children: [
                          marginHeight(width),
                          marginHeight(width),
                          marginHeight(width),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              rowSvgText(childAboveButton[0],
                                  childAboveButton[1], width),
                              marginWidth(width),
                              marginWidth(width),
                              marginWidth(width),
                              childAboveButton[2](),
                            ],
                          )
                        ])
                      : marginHeight(width),
                  marginHeight(width),
                  Center(
                    child: SizedBox(
                      width: width * 0.42,
                      child: Buttons(
                        hexValueOFColor: "#7FA5C9",
                        nameOfTheButton: nameButton,
                        height: width,
                        onPressed: readyButton,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
