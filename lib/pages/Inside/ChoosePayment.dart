import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonStoreUnits.dart';
import 'package:flutter_projects/Singleton/SingletonUnits.dart';

import 'package:flutter_projects/helper_clesses/InsideOfAccount/MainMenu.dart';
import 'package:flutter_projects/helper_clesses/LoadingScreen.dart';
import 'package:flutter_projects/helper_clesses/TextFlexible.dart';
import 'package:flutter_projects/models/subscribe.dart';
import 'package:flutter_projects/models/visibility.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ChoosePayment extends StatelessWidget {
  ErrorMessageProvider provider =
      new ErrorMessageProvider("Выберите предложение".tr);
  final List item = ['s', 's'];

  ChoosePayment({Key key}) : super(key: key);

  Future<String> init() async {
    List<Subscribe> items = (await SingletonConnection().getListForSubscribe())
        .map<Subscribe>(
          (e) => new Subscribe(
              id: e['id'],
              nameSubscribe: e['name_subscribe'],
              price: e['price'],
              duration: e['duration'],
              type: e['type']),
        )
        .toList();
    provider.setItems(items);

    return "Ok";
  }

  Widget text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Roboto",
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: FutureBuilder(
        future: init(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          // AsyncSnapshot<Your object type>
          final provider = Provider.of<ErrorMessageProvider>(context);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreenWithScaffold(
              visible: true,
            );
          } else {
            return MainMenu(
              visible: VisibilityClass(
                filterVisible: false,
                settingsCross: true,
              ),
              nameBar: TextFlexible(
                text: "Предложения".tr,
                numberOfCharacters: 25,
              ),
              body: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.height * 0.02),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      Subscribe obj = provider.items[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(obj.id);
                        },
                        child: Container(
                            padding: EdgeInsets.all(Get.width * 0.03),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Get.width * 0.02),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    obj.nameSubscribe,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                text(
                                    "${obj.duration.toString()} ${SingletonUnits().convertDaysToString(obj.duration)}"),
                                text(
                                    "${obj.price.toString()} ${SingletonStoreUnits().currency.UZS}")
                              ],
                            )),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: provider.items.length),
              ),
            );
          }
        },
      ),
    );
  }
}
