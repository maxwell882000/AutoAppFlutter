import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/TextInput/TextInputForum.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:http/http.dart' as http;

class Registration extends StatelessWidget {
  const Registration({Key key}) : super(key: key);

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
          prov.setNameOfHelper("Аккаунт с таким телефоном уже зарегистрирован");
        else
          prov.setNameOfHelper("Аккаунт с такой почтой уже зарегистрирован");
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextInputForum(
      svgPicture: "assets/registration.svg",
      aboveText: "Регистрация",
      nameOfButton: "Зарегистрироваться",
      connectDataBase: clickRegister(context),
    );
  }
}
