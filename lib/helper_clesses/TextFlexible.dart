import 'package:flutter/material.dart';

class TextFlexible extends StatelessWidget {
  final String text;
  final int numberOfCharacters;

  TextFlexible({Key key, this.text, this.numberOfCharacters = 25})
      : super(key: key);

  String fromatedString() {
    List grouped = text.split(" ");

    String temp = "";
    List prepared = [];
    String spannedText;
    int length = grouped.length;
    print(grouped);

    List.generate(
        length,
        (index) => {
              if (temp.length + grouped[index].length <= numberOfCharacters)
                {
                  temp = "$temp ${grouped[index]}",
                }
              else
                {prepared.add(temp), temp = grouped[index]}
            });
    prepared.add(temp);
    temp = '';
    prepared.forEach((e) => temp = '$temp \n$e');
    spannedText = temp;
    if (spannedText.length > 60) {
      return spannedText.substring(0, 60) + "...";
    }
    return spannedText;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(
      fromatedString(),
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
      style: TextStyle(
        color: Color.fromRGBO(66, 66, 74, 1),
        fontFamily: "Montserrat",
        fontSize: width * 0.035,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
