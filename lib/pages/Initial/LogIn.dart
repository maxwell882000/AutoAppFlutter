
import 'dart:convert';


import 'package:flutter/material.dart';


import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonRecomendation.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/TextInput/TextInputForum.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class LogIn extends StatelessWidget {
 LogIn({Key key}) : super(key: key);
 final ErrorMessageProvider errorMessageProvider =
 new ErrorMessageProvider("Введите Email или Номер телефона".tr);
 Function clickLogin(BuildContext context) {
   return (String emailOrPhone, String provider,
       ErrorMessageProvider prov) async {

     final result = await SingletonConnection().loginAccount(emailOrPhone, provider);
     if (result) {

      SingletonConnection().authorizedData().then((value) {
        final res = Navigator.of(context).popAndPushNamed('/authorized');
        res.then((value) {
          print("LOG OUT");
          SingletonUserInformation().clean();
          SingletonRecomendation().clean();
        });
      });

     } else {
       prov.setNextPage(false);
       prov.setError(true);
       prov.setNameOfHelper("Аккаунт с такими данными не существует".tr);
     }
   };
 }
  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider.value(
      value: errorMessageProvider,
      child: TextInputForum(
        svgPicture:"assets/registration.svg",
        aboveText: "Войти в аккаунт".tr,
        nameOfButton: "Войти".tr,
        connectDataBase: clickLogin(context),
        errorMessageProvider: errorMessageProvider,
      ),
    );
  }
}
