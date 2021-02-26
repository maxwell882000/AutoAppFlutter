import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DialogSaved extends StatelessWidget {
  final String text;
  DialogSaved({Key key, this.text}):super(key: key);
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      content: Text(
        'Вы можете посмотреть в папке $text',
        style: TextStyle(
          color: HexColor("#42424A"),
          fontFamily: 'Montserrat',
          fontSize: width * 0.035,
        ),
      ),
      title: Text(
        'Ваши данные сохранены',
        style: TextStyle(
          color: HexColor("#42424A"),
          fontFamily: 'Montserrat',
          fontSize: width * 0.035,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Ок'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
