import 'package:TestApplication/Pages/Initial/Language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SingletonGlobal {
  Languages language;
  SharedPreferences _prefs;
  String _nameOfTheNextPage;
  List _images = [];
  List _expenses = [];
  static final SingletonGlobal _instance = SingletonGlobal._internal();
  factory SingletonGlobal() {
    return _instance;
  }
  SharedPreferences get prefs => _prefs;
  List get images => _images;
  List get expenses => _expenses;
  void setImages(List images){
    _images =images;
  }
  void setExpenses(List expenses){
    _expenses = expenses;
  }

  void setPrefs(SharedPreferences prefs){
    _prefs = prefs;
  }

  SingletonGlobal._internal();
}
enum MenuPOP{
  POP,
  NEW_TRANSPORT,
  CHANGE_TRANSPORT,
  NO_ACCOUNT,
}
enum Languages {
  EMPTY,
  UZBEK,
  RUSSIAN,
}

enum Requests{
  SUCCESSFULLY_CREATED,
  NOT_FOUND,
  BAD_REQUEST,
  NO_INTERNET
}