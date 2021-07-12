import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PressedProvider with ChangeNotifier{
  bool _isPressed;
  bool get isPressed => _isPressed;
  PressedProvider(this._isPressed);
  set isPressed(bool isPressed){
    _isPressed = isPressed;
    notifyListeners();
  }
}