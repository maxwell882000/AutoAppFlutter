import 'package:flutter/cupertino.dart';

class CheckProvider with ChangeNotifier {
  bool _checked;
  CheckProvider() {
    _checked = false;
  }
  bool get checked => _checked;
  void setChecked(bool checked) {
    this._checked = checked;
    notifyListeners();
  }
}
