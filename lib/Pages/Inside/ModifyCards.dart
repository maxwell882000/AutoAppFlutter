import 'file:///F:/ProjectsWork/FlutterProjects/AutoApp/AutoApp/lib/HelperClasses/DropDown/ListFee.dart';

import 'package:TestApplication/HelperClasses/Dialog/DataNotSave.dart';
import 'package:TestApplication/HelperClasses/LoadingScreen.dart';
import 'package:TestApplication/HelperClasses/TextInput/TextFieldHelper.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:TestApplication/Provider/FeeProvider.dart';
import 'package:TestApplication/Provider/UserProvider.dart';
import 'package:TestApplication/Singleton/SingletonConnection.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/CardsUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ModifyCards extends StatefulWidget {
  final String appBarName;
  final CardUser card;
  final Widget child;

  ModifyCards({Key key, this.appBarName, this.child, this.card})
      : super(key: key);

  @override
  _ModifyCardsState createState() => _ModifyCardsState(
        appBarName: appBarName,
        child: child,
        card: card,
      );
}

class _ModifyCardsState extends State<ModifyCards> {
  final String appBarName;
  final Widget child;
  final CardUser card;

  _ModifyCardsState({this.appBarName, this.child, this.card});

  final ErrorMessageProvider provider = new ErrorMessageProvider("");

  final ErrorMessageProvider runProvider =
      new ErrorMessageProvider("Введите пробег");

  final ErrorMessageProvider commentsProvider =
      new ErrorMessageProvider("Ваш комментарий");
  final ErrorMessageProvider repeatDistProvider =
      new ErrorMessageProvider("Введите расстояние");
  final ErrorMessageProvider repeatTimeProvider =
      new ErrorMessageProvider("Введите число");
  final ErrorMessageProvider dateProvider = new ErrorMessageProvider("Дата");

  final UserProvider fee = new UserProvider();

  @override
  void dispose() {
    // TODO: implement dispose
    provider.dispose();
    commentsProvider.dispose();
    runProvider.dispose();
    repeatDistProvider.dispose();
    repeatTimeProvider.dispose();
    dateProvider.dispose();
    super.dispose();
  }

  Function choiceWidget(double width) {
    return (context) {
      final ErrorMessageProvider provider =
          Provider.of<ErrorMessageProvider>(context);

      final double run =
          SingletonRecomendation().recommendationProbeg(provider.inputData);

      if (run != null) {
        repeatDistProvider.setError(false);
        SingletonUserInformation()
            .newCard
            .change
            .setRun(run + SingletonUserInformation().run);
      }
      repeatDistProvider.setRecommendations(
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
      double average = SingletonUserInformation().average;
      int time;
      int days;

      if (run != null && average != 0) {
        time = run ~/ average;
        days =
            SingletonUnits().translateTimeToDays(SingletonUnits().time, time);
      }
      print("RUN $run");
      print("Days $days");
      repeatTimeProvider.setRecommendations(
        SizedBox(
            height: width * 0.1,
            child: Container(
              margin: EdgeInsets.only(right: width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    run == null
                        ? ""
                        : days != null
                            ? "$days ${SingletonUnits().convertDaysToString(days)}"
                            : "",
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

      return Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChangeNotifierProvider.value(
              value: repeatDistProvider,
              child: TextFieldHelper(
                onlyInteger: true,
              ),
            ),
            SizedBox(
              height: width * 0.02,
            ),
            Text("Или"),
            SizedBox(
              height: width * 0.02,
            ),
            ChangeNotifierProvider.value(
              value: repeatTimeProvider,
              child: TextFieldHelper(
                onlyInteger: true,
              ),
            ),
          ],
        ),
      );
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
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.setNameOfHelper(appBarName);
    provider.setInputData(appBarName);
    SingletonUserInformation().newCard.expense.forEach((element) {
      provider.addItems(new FeeProvider.downloaded(element.id, element.name,
          element.sum.toString(), element.amount.toString()));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final double width = MediaQuery.of(context).size.width;
      commentsProvider.setRecommendations(
        SizedBox(
            height: width * 0.1,
            child: Container(
              margin: EdgeInsets.only(right: width * 0.03),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${SingletonUserInformation().newCard.comments}",
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
    });
  }

  void sendDataToInternet(FeeProvider provider) {
    print(
        "DEleted Send ${provider.id} \t ${SingletonUserInformation().newCard.deletedExpense} "
            "###########################################");
    if (provider.id != null &&
        provider.sum.isNotEmpty &&
        provider.name.isNotEmpty) {
      Map<String, dynamic> json = {
        "name": provider.name,
        "sum": provider.sum,
        "amount": provider.amount.isNotEmpty?provider.amount:1
      };
      print(json);
      SingletonConnection().updateExpense(provider.id, json);
      int add = int.parse(provider.sum) * int.parse(provider.amount);

      int expenses = SingletonUserInformation().expenses.all_time;
      int month = SingletonUserInformation().expenses.in_this_month;
      int sumofAll = expenses + add;
      int sumOfMonth = month + add;
      print("ADDED $add  ALL $sumofAll Month $sumOfMonth");
      SingletonUserInformation().expenses.setAllTime(sumofAll);
      SingletonUserInformation().expenses.setInThisMonth(sumOfMonth);
      print("SUCCESFULLY DELETED ###############");
    }
  }

  Function ready(double width) {
    return (BuildContext context) {
      List items = provider.items;
      print("LENGTH ${items.length}");
      print("${SingletonUserInformation().newCard.uploadedExpense}");
      print("Deleted ${SingletonUserInformation().newCard.deletedExpense}");
      items.forEach((element) {
        print("${element.id}  ${element.delete}");
      });
      List errorExpense = items
          .where((element) =>
              (element.name.isEmpty || element.sum.isEmpty) &&
              !element.delete &&
              element.id != null)
          .toList();
      errorExpense.forEach((element) {
        element.setError(true);
      });

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
      if (!error && errorExpense.isEmpty) {
        items.forEach((element) {
          sendDataToInternet(element);
        });

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
        SingletonUserInformation().newCard.setExpense([]);
        provider.items
            .where((element) => !element.delete && element.id != null)
            .forEach((element) {
          SingletonUserInformation().newCard.expense.add(new Expense(element.id,
              element.name, int.parse(element.sum), int.parse(element.amount)));
        });
        SingletonUserInformation().newCard.deletedExpense.clear();
        Navigator.of(context).pop(true);
      }
    };
  }

  Future<bool> _onWillPop() async {

      final bool response = await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => DataNotSave()
        );
        if(response){
          List expense = SingletonUserInformation().newCard.uploadedExpense;
          List image = SingletonUserInformation().newCard.attach.uploadedImage;
          expense.forEach((element) {
            SingletonConnection().deleteExpense(element);
          });
          image.forEach((element) {
            SingletonConnection().deleteImage(element);
          });
        }
        return response;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: ChangeNotifierProvider.value(
        value: provider,
        child: CardsUser(
          recommendationFunction: recomendationCards(context),
          secondChild: child,
          middleChild: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: width * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Расходы",
                      style: TextStyle(
                        color: HexColor("#42424A"),
                        fontFamily: 'Montserrat',
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListFee(),
                          SizedBox(
                            height: width * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    provider.addItems(new FeeProvider());
                                  });
                                },
                                child: SvgPicture.asset(
                                  'assets/add.svg',
                                  width: width * 0.055,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                "Добавить",
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
          childAboveButton: [
            'assets/reload.svg',
            "Повторить через ",
            choiceWidget(width)
          ],
          provider: provider,
          runProvider: runProvider,
          commentsProvider: commentsProvider,
          nameButton: "Сохранить",
          dateProvider: dateProvider,
          appBarName: "Редактирование карточки $appBarName",
          readyButton: ready(width),
        ),
      ),
    );
  }
}
