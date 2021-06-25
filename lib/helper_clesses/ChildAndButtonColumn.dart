import 'package:flutter/material.dart';
import 'package:flutter_projects/helper_clesses/ChildAndButton.dart';

class ChildAndButtonColumn extends ChildAndButton {
  ChildAndButtonColumn({
    Key key,
    width,
    aboveChild,
    button,
    size,
    flex,
    widthOfButton,
    heightOfButton,
  }) : super(
            key: key,
            width: width,
            aboveChild: aboveChild,
            button: button,
            size: size,
            flex: flex,
            widthOfButton: widthOfButton,
            heightOfButton: heightOfButton);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.02),
            ),
            child: aboveChild,
          ),
          Container(
            height: width * 0.13,
            child: button,
          ),
        ],
      ),
    );
  }
}
