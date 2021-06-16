import 'package:flutter/material.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  final Function dispose;

  const StatefulWrapper(
      {Key key, this.child, this.onInit, this.dispose = _default})
      : super(key: key);

  static void _default() {}

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState(
        onInit: onInit,
        child: child,
      );
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  final Function onInit;
  final Widget child;

  _StatefulWrapperState({this.onInit, this.child});

  @override
  void initState() {
    super.initState();
    onInit();
  }


  @override
  Widget build(BuildContext context) {
    return child;
  }
}
