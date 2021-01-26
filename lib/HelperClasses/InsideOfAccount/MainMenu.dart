import 'package:TestApplication/HelperClasses/InsideOfAccount/AbovePartOfAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/AppBarForAccount.dart';
import 'package:TestApplication/HelperClasses/InsideOfAccount/ListOfInicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';

class MainMenu extends StatelessWidget {
  final Widget body;
  final Widget floatingActionButton;
  final Widget nameBar;
  final double heightBar;
  MainMenu({Key key, this.body, this.floatingActionButton , this.nameBar,this.heightBar}) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForAccount(nameBar:this.nameBar,).build(context),
      backgroundColor: HexColor("F0F8FF"),
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
