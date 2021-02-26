import 'dart:convert';

import 'package:TestApplication/HelperClasses/Dialog/ChoiceDialog.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/LoadingScreen.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';

import 'package:TestApplication/Provider/UserProvider.dart';
import 'package:TestApplication/Singleton/SingletonConnection.dart';
import 'package:TestApplication/Singleton/SingletonGlobal.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonRegistrationAuto.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String chosenText;
  List items= [];
  final initialHeight = 0.14;
  final UserProvider userProvider = new UserProvider.start(
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
  double height = 0;
  final ScrollController _scrollController = ScrollController();
  bool check = true;
  bool loading = true;
  final GlobalKey _scaffoldKey = GlobalKey();
  Widget text({Color color, String text, double width}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: width * 0.038,
          color: color != null ? color : HexColor("#FFFFFF"),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void initState() {

    super.initState();
    userProvider.setProAccount(true);
    userProvider.setClearMenu(false);
    SingletonConnection().getTransports().then((value) {
      if(mounted) {
        setState(() {
          print(value);

          value.where((element) =>
          element['id'] != SingletonUserInformation().id).forEach((element) {
            items.add([element['nameOfTransport'], element['id']]);
          });

          height = initialHeight * items.length;
          loading = false;
        });
      }
    });
  }

  Widget choices(String text, var id, double width) {
    return SizedBox(
      height: width*0.15,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal:  0 , vertical: width*0.01),
        ),
          onPressed: () {
              _scrollController.animateTo(
                _scrollController.position.minScrollExtent,
                duration: Duration(seconds: 1),
                curve: Curves.fastOutSlowIn,
              );
              final Future response = showDialog(
                context: _scaffoldKey.currentContext,
                barrierDismissible: false,
                builder: (context) => ChoiceDialog(
                  text: "Вы уверены что хотите сменить карточку ?",
                ),
              );
              response.then((value) {
                setState(() {
                  loading = true;
                  userProvider.setClearMenu(true);
                  userProvider.setClearSettings(true);
                });

                if (value) {
                  SingletonRecomendation().clean();
                  SingletonRegistrationAuto().clean();
                  SingletonUserInformation().cards.clean();
                  SingletonConnection()
                      .authorizedData(
                          text:
                              "${SingletonUserInformation().emailOrPhone}/?id_cards=$id")
                      .then((value) {
                          loading = false;

                          Navigator.of(_scaffoldKey.currentContext).pop(MenuPOP.CHANGE_TRANSPORT);
                  });
                }
                else{
                  setState(() {
                    loading = false;
                    check = true;
                    userProvider.setClearMenu(false);
                    userProvider.setClearSettings(false);
                  });
                }
              });
          },
          child: this.text(text: text, width: width)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    print("PRO ACCOUNT INSIDE MENU ${userProvider.proAccount}");
    print("${SingletonUserInformation().proAccount}");

    return ChangeNotifierProvider.value(
      value: userProvider,
      child: MainMenu(
        menu: 1,
        key: _scaffoldKey,
        menuVisible: false,
        filterVisible: false,
        nameBar: TextFlexible(
          text: "Меню",
          numberOfCharacters: 25,
        ),
        body: Container(
          margin: EdgeInsets.all(width * 0.05),
          child: Stack(
            children: [
              Visibility(
                  child: Center(
                    child: LoadingScreen(
                visible: loading,
              ),
                  )),
              Visibility(
                visible: !loading,
                child: Stack(
                  children: [
                    AnimatedContainer(
                        margin: EdgeInsets.only(top: width*0.03),
                        decoration: BoxDecoration(
                          color: HexColor("#7FA5C9"),
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        height: check
                            ? 0
                            : height > 1.15
                                ? width * 1.15
                                : width * (0.25 + height),
                        duration: Duration(milliseconds: 1000),
                        child: Container(
                          margin: EdgeInsets.only(top: width * 0.2),
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.04, vertical: width * 0.04),
                          child: ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, position) => choices(
                                items[position][0],
                                items[position][1],
                                width),
                            itemCount: items.length,
                            separatorBuilder: (context, position) {
                              return SizedBox(
                                height: width * 0.08,
                              );
                            },
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          check = !check;
                        });
                      },
                      child: Container(
                        height: width * 0.18,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text(
                                width: width,
                                text:
                                    "${SingletonUserInformation().nameOfTransport}",
                                color: HexColor("#42424A")),
                            SvgPicture.asset("assets/arrow_down.svg"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: !loading,
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              setState(() {
                loading = true;
              });
              final items = http.get(
                  'https://autoapp.elite-house.uz/marka/'
              );
              items.then((value) {
                jsonDecode(value.body).forEach((e)=> SingletonRegistrationAuto().fromJson(e));
                SingletonRegistrationAuto().finish();
                Navigator.of(_scaffoldKey.currentContext).popAndPushNamed("/registration_auto",arguments: MenuPOP.NEW_TRANSPORT);
              });


            },
            child: SvgPicture.asset(
              "assets/add.svg",
              height: width * 0.13,
            ),
          ),
        ),
      ),
    );
  }
}
