
import 'package:TestApplication/HelperClasses/TextInput/TextInputForum.dart';

import 'package:flutter/material.dart';


class LogIn extends StatelessWidget {
 LogIn({Key key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {


    return TextInputForum(
      svgPicture:"assets/registration.svg",
      aboveText: "Войти в аккаунт",
      nameOfButton: "Войти",
    );
  }
}
