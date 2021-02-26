import 'package:flutter/material.dart';

class CustomDialog {
 static  Future dialog({double width, BuildContext context,
   Widget child, bool barrierDismissible = true,
    Color color = Colors.white}) {
    return showGeneralDialog(
        barrierColor: Colors.black54,
        barrierDismissible: barrierDismissible,
        barrierLabel: 'Label',
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05, vertical: width * 0.2),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(width * 0.02)),
                  child: child),
            ),
          );
        });
  }

}
