import 'package:TestApplication/HelperClasses/InsideOfAccount/AbovePartOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/AppBarForAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/ListOfInicator.dart';
import 'package:TestApplication/Provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatelessWidget {
  final Widget body;
  final Widget floatingActionButton;
  final Widget nameBar;
  final double heightBar;
  final bool filterVisible;
  final bool menuVisible;
  final bool settingsCross;
  final int menu;
  MainMenu({Key key,
    this.body,
    this.floatingActionButton,
    this.nameBar,
    this.heightBar,
    this.menuVisible,
    this.filterVisible,
    this.settingsCross,
  this.menu})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size
        .width;
    if(filterVisible == false && menu == null){
      return ChangeNotifierProvider(
        create:(BuildContext context) => UserProvider() ,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBarForAccount(
            settingsCross: settingsCross,
            filterVisible: filterVisible,
            menuVisible: menuVisible,
            nameBar: this.nameBar,
            width: width,
          ),
          backgroundColor: HexColor("F0F8FF"),
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        appBar: AppBarForAccount(
          settingsCross: settingsCross,
          filterVisible: filterVisible,
          menuVisible: menuVisible,
          nameBar: this.nameBar,
          width: width,
        ),
        backgroundColor: HexColor("F0F8FF"),
        body: body,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }
}
