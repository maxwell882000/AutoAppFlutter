import 'package:flutter/material.dart';

class ErrorMessageProvider with ChangeNotifier {
  String _nameOfHelper;
  String _inputData;
  bool _error;
  bool _selected;
  bool _nextPage;
  List _errorsMessageWithText;
  ErrorMessageProvider(String nameOfHelper) {
    this._nameOfHelper = nameOfHelper;
    this._error = false;
    this._selected = false;
    this._nextPage = false;
    this._inputData = "";
    this._errorsMessageWithText = [];
  }
  List get errorsMessageWithText => _errorsMessageWithText;

  bool get error => _error;
  String get nameOfHelper => _nameOfHelper;
  bool get selected => _selected;
  bool get nextPage => _nextPage;
  String get inputData => _inputData;

  void setInputData(String inputData) {
    this._inputData = inputData;
    notifyListeners();
  }

  void setErrorsMessageWithText(List errorsMessageWithText) {
    this._errorsMessageWithText.add(errorsMessageWithText);
  }

  void setNextPage(bool nextPage) {
    this._nextPage = nextPage;
    notifyListeners();
  }

  void setError(bool error) {
    this._error = error;
    notifyListeners();
  }

  void setNameOfHelper(String nameOfHelper) {
    this._nameOfHelper = nameOfHelper;
    notifyListeners();
  }

  void setSelected(bool selected) {
    this._selected = selected;
    notifyListeners();
  }
}
