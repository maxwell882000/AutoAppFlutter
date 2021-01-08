import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'InitialPointOfAccount/Base.dart';
import 'Buttons.dart';
import 'ChildAndButton.dart';

class SelectOptions extends StatelessWidget {
  final double width;
  final double height;
  final String icon;
  final String aboveText;
  final double heightOfButton;
  final double widthOfButton;
  final Widget child;
  final ErrorMessageProvider selectOptionsErrorProvider =
      new ErrorMessageProvider("");
  SelectOptions({
    Key key,
    this.aboveText,
    this.child,
    this.height,
    this.icon,
    this.width,
    this.heightOfButton,
    this.widthOfButton,
  }) : super(key: key);
  void readyToTheNext(BuildContext context) {
    var errors = selectOptionsErrorProvider.errorsMessageWithText;
    var selected = errors
        .where((element) => !element[1].selected)
        .map((element) => errors.indexOf(element));
    print(errors);
    print(selected);
    if (selected.length == 0) {
    } else {
      print("asdsad");
      selected.forEach((element) {
        var error = errors[element];
        error[1].setError(true);
        error[1].setNameOfHelper("Здесь ничего не выбрано");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ErrorMessageProvider>.value(
      value: selectOptionsErrorProvider,
      child: Base(
        width: width,
        height: height,
        icon: icon,
        aboveText: aboveText,
        child: ChildAndButton(
          width: width,
          heightOfButton: heightOfButton,
          widthOfButton: widthOfButton,
          size: EdgeInsets.fromLTRB(
              width * 0.03, width * 0.03, width * 0.03, width * 0.02),
          aboveChild: child,
          button: Buttons(
            width: width * 0.4,
            hexValueOFColor: "#7FA6C9",
            nameOfTheButton: "Готово",
            height: width,
            onPressed: readyToTheNext,
          ),
        ),
      ),
    );
  }
}
