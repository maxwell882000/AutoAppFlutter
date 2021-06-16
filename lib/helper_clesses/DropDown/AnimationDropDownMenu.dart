



import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../AnimatedContainerBorder.dart';


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
  final ScrollController scroll = new ScrollController();
  void pressedScroll() {
    if(scroll.hasClients){
      if(pressed == false)
        scroll.animateTo(scroll.initialScrollOffset, duration: Duration(milliseconds: 400), curve: Curves.linear);
    }
  }
  @override
  Widget build(BuildContext context) {
    pressedScroll();
    return AnimatedContainerBorder(
      duration:pressed ? 1000 : 600,
      height: pressed ? null : Get.width * 0.12,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        controller: scroll,
          physics: scrolling == 1
                  ? AlwaysScrollableScrollPhysics()
                  : NeverScrollableScrollPhysics(),
        children: dropDownWidget.toList(),
      ),
    );
  }
}

