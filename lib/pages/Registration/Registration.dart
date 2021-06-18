import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/TextInput/TextInputForum.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Registration extends StatelessWidget {
  Registration({Key key}) : super(key: key);
  final ErrorMessageProvider errorMessageProvider =
      new ErrorMessageProvider("Введите Email или Номер телефона".tr);

  Function clickRegister(BuildContext context) {
    return (String emailOrPhone, String provider,
        ErrorMessageProvider prov) async {
      bool result =
          await SingletonConnection().registerAccount(emailOrPhone, provider);
      if (result) {
        Navigator.of(context).popAndPushNamed("/select_unit");
      } else {
        prov.setNextPage(false);
        prov.setError(true);
        if (provider == 'phone')
          prov.setNameOfHelper(
              "Аккаунт с таким телефоном уже зарегистрирован".tr);
        else
          prov.setNameOfHelper("Аккаунт с такой почтой уже зарегистрирован".tr);
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: errorMessageProvider,
      child: TextInputForum(
        svgPicture: "assets/registration.svg",
        aboveText: "Регистрация".tr,
        nameOfButton: "Зарегистрироваться".tr,
        connectDataBase: clickRegister(context),
        errorMessageProvider: errorMessageProvider,
      ),
    );
  }
}
