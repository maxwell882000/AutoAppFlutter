import 'package:TestApplication/HelperClasses/AnimatedContainerBorder.dart';

import 'package:flutter/material.dart';


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
    return Visibility(
      visible: visibility,
      child: AnimatedContainerBorder(
        duration:pressed ? 1000 : 600,
        height: pressed ? enabledHeight : disabledHeight,
        child: SingleChildScrollView(
            physics: scrolling == 1
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            child: Column(
              children: dropDownWidget.toList(),
            )),
      ),
    );
  }
}
