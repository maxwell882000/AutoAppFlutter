import 'package:TestApplication/HelperClasses/AnimatedContainerBorder.dart';
import 'package:TestApplication/HelperClasses/DropDown/DropDownItem.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/BaseOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/MainMenu.dart';
import 'package:TestApplication/HelperClasses/TextFlexible.dart';
import 'package:TestApplication/HelperClasses/TextInput/TextFieldHelper.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreateCards extends StatelessWidget {
  CreateCards({Key key}) : super(key: key);

  final ErrorMessageProvider provider = new ErrorMessageProvider("");

  Function swapToDrop(double width) {
    return () {
      final Widget DropDown = DropDownItem(
        items: ['Something', 'SomeThing', 'TwoSomething'],
        width: width,
        enabledHeight: width * 0.0,
      );
    };
  }

  Function swapToText(double width) {
    return () {};
  }
  Widget pencil(){
    return GestureDetector(
      onTap: () {},
      child: SvgPicture.asset(
        'assets/pencil.svg',
      ),
    );
  }
  Widget rowIcons(double width) {
    return Row(
      children: [
        SvgPicture.asset(
          'assets/pencil.svg',
        ),
        SizedBox(
          width: width * 0.05,
        ),
        SvgPicture.asset('assets/arrow_down.svg')
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider.value(
      value: provider,
      child: MainMenu(
          nameBar: TextFlexible(
            text: "Создание карточка",
            numberOfCharacters: 25,
          ),
          body: Container(
            margin: EdgeInsets.only(top: width * 0.05),
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: width * 0.1,
                    child: AnimatedContainerBorder(
                      duration: 100,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Название сервиса",
                            ),
                            rowIcons(width)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
    ;
  }
}
