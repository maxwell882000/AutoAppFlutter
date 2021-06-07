import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
class AlertDialogInformation extends StatelessWidget {
  final String text;
  final String title;
  AlertDialogInformation({Key key, this.text,this.title}):super(key: key);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Text(
        '$text',
        style: TextStyle(
          color: HexColor("#42424A"),
          fontFamily: 'Montserrat',
          fontSize: width * 0.035,
        ),
      ),
      title: Text(
        '$title',
        style: TextStyle(
          color: HexColor("#42424A"),
          fontFamily: 'Montserrat',
          fontSize: width * 0.035,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ок'.tr),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
