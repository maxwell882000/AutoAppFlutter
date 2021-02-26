import 'package:TestApplication/HelperClasses/InitialPointOfAccount/Base.dart';
import 'package:TestApplication/HelperClasses/Buttons.dart';
import 'package:TestApplication/HelperClasses/ChildAndButton.dart';
import 'package:TestApplication/HelperClasses/DropDown/DropDownItem.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'file:///F:/ProjectsWork/FlutterProjects/AutoApp/AutoApp/lib/Singleton/SingletonGlobal.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatelessWidget {
  Language({Key key}) : super(key: key);

  final List items = ["Русский Язык", "O`zbek tili"];

  final ErrorMessageProvider errorsMessage =
      new ErrorMessageProvider("Выберите Язык");

  void selectLanguage(String choosenLanguage) {
    if (errorsMessage.nameOfHelper == choosenLanguage) {
      SingletonGlobal().language = Languages.EMPTY;
      return;
    } else if (choosenLanguage == items[0]) {
      SingletonGlobal().language = Languages.RUSSIAN;
    } else {
      SingletonGlobal().language = Languages.UZBEK;
    }
  }

  void selectedLanguage(BuildContext context) {
    print(errorsMessage.inputData);
    selectLanguage(errorsMessage.inputData);
    if (!errorsMessage.selected) {
      errorsMessage.setError(true);
      errorsMessage.setNameOfHelper("Сперва Выберите Языке!");
    } else {
      errorsMessage.setNextPage(true);
      saveData();
      Navigator.of(context).popAndPushNamed('/select');
    }
  }

  void saveData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setInt(
        'language', SingletonGlobal().language == Languages.UZBEK ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<ErrorMessageProvider>.value(

      value: errorsMessage,
      child: Base(
        width: width,
        height: width * 0.9,
        icon: "assets/languages.svg",
        aboveText: "Выбор Языка",
        child: ChildAndButton(
          key: UniqueKey(),
          aboveChild: DropDownItem(
            items: items,
            width: width,
            uzbekFlag: "assets/uzbekistan.svg",
            russionFlag: "assets/russion.svg",
            disabledHeight: width * 0.13,
            enabledHeight: width * 0.25,
          ),
          button: Buttons(
            hexValueOFColor: "#7FA6C9",
            nameOfTheButton: "Готово",
            onPressed: this.selectedLanguage,
            height: width,
          ),
          heightOfButton: width * 0.006,
          size: EdgeInsets.only(
              top: width * 0.04, left: width * 0.08, right: width * 0.08),
          width: width,
        ),
      ),
    );
  }
}
