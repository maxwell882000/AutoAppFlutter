import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/Buttons.dart';
import 'package:flutter_projects/helper_clesses/Dialog/CustomDialog.dart';
import 'package:flutter_projects/helper_clesses/InsideOfAccount/MainMenu.dart';
import 'package:flutter_projects/helper_clesses/LoadingScreen.dart';
import 'package:flutter_projects/helper_clesses/Payme/payme_pay.dart';
import 'package:flutter_projects/helper_clesses/TextFlexible.dart';
import 'package:flutter_projects/models/subscribe.dart';
import 'package:flutter_projects/models/visibility.dart';
import 'package:flutter_projects/pages/Inside/User.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:flutter_projects/provider/UserProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ProPurchase extends StatelessWidget {
  final provider = UserProvider();
  final List items = [
    "ВОЗМОЖНОСТЬ ДОБАВИТЬ БОЛЬШЕ 1 АВТО В ПРОФИЛЬ".tr,
    "Возможность отслеживать и добавлять неограниченное количество авто деталей (в бесплатном можно отслеживать 10 и добавить 5)"
        .tr,
    "НЕТ РЕКЛАМЫ".tr,
  ];
  final List icons = [
    ['assets/paynet.png', () {}],
    ['assets/click.png', () {}],
    [
      'assets/payme.png',
      (String amountId) {
        CustomDialog.dialog(
            barrierDismissible: false,
            context: Get.context,
            width: Get.width,
            child: PaymePay(
              amountId: amountId,
            ),
            alignment: Alignment.center);
      }
    ],
  ];

  void makePayment(Function dialog) async {
    final result = await Navigator.of(Get.context).pushNamed('/service');
    if (result != null) dialog(result.toString());
  }

  Widget text({Color color, String text, double width}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Montserrat",
        fontSize: width * 0.028,
        color: HexColor("#42424A"),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget choices({String text, double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/tick.svg",
          width: width * 0.05,
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Flexible(child: this.text(text: text, width: width))
      ],
    );
  }

  Widget iconsGet({String icons, double width, onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.only(right: width * 0.03),
        width: width * 0.24,
        child: Image.asset(
          icons,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget button({String text, Function submit}) {
    return Buttons(
      nameOfTheButton: text,
      hexValueOFColor: "#7FA6C9",
      height: Get.height * 0.5,
      width: Get.width * 0.5,
      onPressed: submit,
    );
  }

  void success() {
    CustomDialog.show(
        title: "Успешно".tr, text: "Вы преобрели про аккаунт!".tr);
    SingletonUserInformation().setProAccount(true);
  }

  Future paynetPay(Subscribe subscribe, int balans) async {
    final bool result = await CustomDialog.showChoice(
        text: "Вы уверены что хотите купить тариф?".tr);
    print("RESULT $result");
    if (result) {
      print(subscribe.price);
      print(balans);
      if (subscribe.price <= balans) {
        bool result =
            await SingletonConnection().payForProAccount(subscribe.id);
        print('RESPISNE $result');
        if (!result) {
          CustomDialog.show(
              title: "Ошибка".tr, text: "Ваш запрос не был обработан".tr);
        } else {
          success();
        }
      } else {
        print("THEERE");
        CustomDialog.show(
            title: "Ошибка".tr, text: "У вас не достатчно средств".tr);
      }
    }
  }

  void paymeSubscribe(Subscribe subscribe, int balans) {
    CustomDialog.dialog(
        barrierDismissible: false,
        context: Get.context,
        width: Get.width,
        child: PaymePay(
          amountId: subscribe.id.toString(),
        ),
        alignment: Alignment.center);
  }

  Future pay({TypeOfPayment type, Function onPay, int balans}) async {
    final subscribe =
        await Navigator.of(Get.context).pushNamed('/service', arguments: type);
    if (subscribe != null) {
      onPay(subscribe, balans);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider.value(
        value: provider,
        child: GetBuilder<ProAccountController>(
            init: ProAccountController(),
            builder: (_) {
              if (!_.isLoaded) {
                return LoadingScreenWithScaffold(
                  visible: true,
                );
              } else {
                Map json = jsonDecode(_.json);
                int balans = json['balance'];
                String customerId = json['customerId'];
                return MainMenu(
                  visible: VisibilityClass(
                    filterVisible: false,
                    settingsCross: true,
                  ),
                  nameBar: TextFlexible(
                    text: "Получить про доступ".tr,
                    numberOfCharacters: 25,
                  ),
                  body: Container(
                    margin: EdgeInsets.all(width * 0.04),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(width * 0.06),
                          height: width * 0.6,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * 0.02),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text(
                                  text: "PRO ДОСТУП ВКЛЮЧАЕТ В СЕБЯ".tr,
                                  width: width),
                              SizedBox(
                                height: width * 0.05,
                              ),
                              SizedBox(
                                height: width * 0.35,
                                child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, position) => choices(
                                        text: items[position], width: width),
                                    separatorBuilder: (context, position) =>
                                        SizedBox(
                                          height: width * 0.05,
                                        ),
                                    itemCount: items.length),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width * 0.1,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: button(
                                  text: "Оформить подписку".tr,
                                  submit: (context) {
                                    pay(
                                        type: TypeOfPayment.SUBSCRIBE,
                                        onPay: paymeSubscribe,
                                        balans: balans);
                                  }),
                              flex: 2,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.1,
                        ),
                        Container(
                          padding: EdgeInsets.all(width * 0.06),
                          height: width * 0.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(width * 0.02),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              text(
                                  text: "Ваш баланс:".tr + " " + "$balans",
                                  width: width),
                              text(
                                  text: "ID для пополнения баланса:".tr +
                                      " " +
                                      "$customerId",
                                  width: width),
                              SizedBox(
                                height: width * 0.05,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child: text(
                                          text: "Вы можете пополнить ваш баланс в Paynet! Вам всего лишь нужно вести ваш ID!".tr, width: width)),
                                  SizedBox(
                                    width: Get.width*0.02,
                                  ),

                                  Flexible(
                                    child: button(
                                        text: "Купить тариф".tr,
                                        submit: (context) {
                                          pay(
                                              type: TypeOfPayment.ONE_TIME,
                                              onPay: paynetPay,
                                              balans: balans);
                                        }),
                                  ),

                                ],
                              )
                              // SizedBox(
                              //   height: width * 0.1,
                              //   child: ListView.separated(
                              //       scrollDirection: Axis.horizontal,
                              //       physics: NeverScrollableScrollPhysics(),
                              //       itemBuilder: (context, position) =>
                              //           iconsGet(
                              //               icons: icons[position][0],
                              //               width: width,
                              //               onTap: () => makePayment(
                              //                   icons[position][1])),
                              //       separatorBuilder: (context, position) =>
                              //           SizedBox(
                              //             width: width * 0.01,
                              //           ),
                              //       itemCount: icons.length),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}

class ProAccountController extends GetxController {
  String json = "";
  bool isLoaded = false;

  @override
  void onInit() {
    super.onInit();
    SingletonConnection().getBalans().then((value) {
      print(value);
      setJson(value);
      setLoaded(true);
    });
  }

  void setJson(String json) {
    this.json = json;
    update();
  }

  void setLoaded(bool loaded) {
    isLoaded = loaded;
  }
}
