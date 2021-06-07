
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'ChoiceDialog.dart';

class GoToAdd {

  static Future goToAdd({double width, BuildContext context,
    Widget child, bool barrierDismissible = false,
    Color color = Colors.white, String site}) async {
    final result =  await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ChoiceDialog(
          text: "Вы хотите посетить это сайт?".tr,
        )
    );

    if (result){
      launch(site);
    }
  }

}