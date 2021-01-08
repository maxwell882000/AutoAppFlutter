import 'package:TestApplication/HelperClasses/TextInput/TextInputForum.dart';
import 'package:flutter/material.dart';

class Registration extends StatelessWidget {
  const Registration({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextInputForum(
      svgPicture:"assets/registration.svg",
      aboveText: "Регистрация",
      nameOfButton: "Зарегистрироваться",
    );
  }
}
