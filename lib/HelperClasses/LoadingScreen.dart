import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final bool visible;
  const LoadingScreen({Key key, this.visible}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Visibility(
        visible: visible,
          child: Container(
        width: width * 0.3,
        height: width * 0.3,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: width * 0.05,
        ),
      ),
    );
  }
}
