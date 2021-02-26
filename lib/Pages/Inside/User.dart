import 'dart:convert';

import 'package:TestApplication/HelperClasses/Dialog/ChoiceDialog.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/AbovePartOfAccount.dart';
import 'package:TestApplication/HelperClasses/LoadingScreen.dart';
import 'package:TestApplication/Pages/Inside/Adds.dart';
import 'package:TestApplication/Singleton/SingletonConnection.dart';

import 'package:TestApplication/HelperClasses/InsideOfAccount/ListOfInicator.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';
import 'package:TestApplication/Provider/UserProvider.dart';
import 'package:TestApplication/Singleton/SingletonGlobal.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonRegistrationAuto.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class User extends StatefulWidget {
  User({
    Key key,
  }) : super(key: key);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  final UserProvider userProvider = SingletonUserInformation().NO_ACCOUNT
      ? UserProvider.noAccount()
      : new UserProvider.start(
          SingletonUserInformation().run,
          SingletonUserInformation().average,
          SingletonUserInformation().cards.changeDetails,
          SingletonUserInformation().expenses.all_time,
          SingletonUserInformation().expenses.in_this_month,
          SingletonUserInformation().proAccount,
          "${SingletonUserInformation().marka} ${SingletonUserInformation().model}",
          "${SingletonUserInformation().number}",
          "${SingletonUserInformation().techPassport}",
          "${SingletonUserInformation().tenure()} лет",
          false,
        );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<bool> _onWillPop() async {
    final bool response = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ChoiceDialog(
        text: "Вы уверены что хотите выйти ?",
      ),
    );
    if (response) {
      SingletonUserInformation().clean();
      SingletonRecomendation().clean();
      SingletonRegistrationAuto().clean();
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: ChangeNotifierProvider.value(
        value: userProvider,
        child: Builder(builder: (context) {
          final userProvider = Provider.of<UserProvider>(context);
          return MainMenu(
            nameBar: TextFlexible(
              text: "AUTOAPP",
              numberOfCharacters: 25,
            ),
            body: Stack(
              alignment: Alignment.topCenter,
              children: [
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: !userProvider.NO_ACCOUNT || userProvider.nextPage,
                  child: Center(
                    child: LoadingScreen(
                      visible: userProvider.nextPage,
                    ),
                  ),
                ),
                Visibility(
                  maintainAnimation: true,
                  maintainState: true,
                  visible: userProvider.NO_ACCOUNT && !userProvider.nextPage,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Добавьте транспортное средство",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.1,
                            fontFamily: "Montserrat",
                            color: Color.fromRGBO(66, 66, 74, 1),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_downward_sharp,
                        size: width * 0.3,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: !userProvider.nextPage  ,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: width * 0.05, horizontal: width * 0.03),
                    child: Visibility(
                      visible: !userProvider.NO_ACCOUNT,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AbovePartOfAccount(
                              width: width,
                            ),
                            Adds(),
                            SizedBox(
                              height: width * 0.04,
                            ),
                            Expanded(
                                child: ListOfIndicator()
                            ),
                            SizedBox(
                              height: width*0.1,
                            ),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: Visibility(
              visible: !userProvider.nextPage,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: FloatingActionButton(
                backgroundColor: Colors.transparent,
                onPressed: () {
                  if (userProvider.NO_ACCOUNT) {
                      userProvider.setNextPage(true);
                      userProvider.setClearSettings(true);
                    SingletonRegistrationAuto().clean();
                    final items =
                        http.get('https://autoapp.elite-house.uz/marka/');
                    items.then((value) async {
                      jsonDecode(value.body).forEach(
                          (e) => SingletonRegistrationAuto().fromJson(e));
                      SingletonRegistrationAuto().finish();
                      final results = await Navigator.of(context).pushNamed(
                          "/registration_auto",
                          arguments: MenuPOP.NO_ACCOUNT);
                      if (results == true) {
                        print("HERE COOL");
                        userProvider.setNO_ACCOUNT(false);

                        userProvider.updateData(
                          SingletonUserInformation().run,
                          SingletonUserInformation().average,
                          SingletonUserInformation().cards.changeDetails,
                          SingletonUserInformation().expenses.all_time,
                          SingletonUserInformation().expenses.in_this_month,
                          SingletonUserInformation().proAccount,
                          "${SingletonUserInformation()
                              .marka} ${SingletonUserInformation().model}",
                          "${SingletonUserInformation().number}",
                          "${SingletonUserInformation().techPassport}",
                          "${SingletonUserInformation().tenure()} лет",
                          false,
                        );
                        userProvider.setClearMenu(false);
                        userProvider.setIndicators([]);
                        userProvider.setLoading(true);
                        SingletonUserInformation().cards.loadCards().then((
                            value) {
                          print(SingletonUserInformation().indicators());
                          userProvider
                              .setIndicators(
                              SingletonUserInformation().indicators());
                          userProvider.setAverageRun(
                              SingletonUserInformation().average);
                          userProvider.setChanged(true);
                          print("UPDATE");
                          userProvider.setLoading(false);
                        });
                      }
                      userProvider.setNextPage(false);
                      });
                  } else {
                    final result =
                        Navigator.of(context).pushNamed("/create_cards");
                    result.then((value) {
                      if (value != null) {
                        userProvider.setRun(SingletonUserInformation().run);
                        SingletonUserInformation().averageRun();
                        userProvider
                            .setAverageRun(SingletonUserInformation().average);
                        userProvider.setLoading(true);
                        SingletonConnection().createCards().then((value) {
                          SingletonUserInformation()
                              .newCard
                              .change
                              .setInitialRun(SingletonUserInformation().run);
                          SingletonUserInformation().newCard.attach.setImage(
                              SingletonUserInformation()
                                  .newCard
                                  .attach
                                  .uploadedImage);
                          SingletonUserInformation().newCard.attach.clean();
                          SingletonUserInformation()
                              .cards
                              .card
                              .add(SingletonUserInformation().newCard);
                          userProvider.setIndicators(
                              SingletonUserInformation().indicators());
                          SingletonUserInformation().newCardClean();
                          userProvider.setChanged(true);
                        });
                      } else {
                        SingletonUserInformation().newCardClean();
                      }
                    });
                  }
                },
                child: SvgPicture.asset(
                  "assets/add.svg",
                  height: width * 0.13,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
