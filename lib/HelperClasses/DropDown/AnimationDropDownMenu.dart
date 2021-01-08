import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class AnimationDropDownMenu extends StatelessWidget {
  final bool pressed;
  final double enabledHeight;
  final double width;
  final double disabledHeight;
  final dropDownWidget;
  final int scrolling;
  final bool visibility;
  final bool error;
  AnimationDropDownMenu({
    Key key,
    this.pressed,
    this.enabledHeight,
    this.width,
    this.disabledHeight,
    this.dropDownWidget,
    this.scrolling,
    this.visibility,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var error = Provider.of<ErrorMessageProvider>(context);
    return Visibility(
      visible: visibility,
      child: AnimatedContainer(
        curve: Curves.easeInQuart,
        duration: Duration(milliseconds: pressed ? 1000 : 600),
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        height: pressed ? enabledHeight : disabledHeight,
        decoration: BoxDecoration(
          border: Border.all(
              color: !error.error ? HexColor("#7FA6C9") : HexColor("#DF5867"),
              width: 1.2),
          borderRadius:
              BorderRadius.circular(MediaQuery.of(context).size.width * 0.02),
        ),
        child: Center(
          child: SingleChildScrollView(
              physics: scrolling == 1
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: dropDownWidget.toList(),
              )),
        ),
      ),
    );
  }
}
