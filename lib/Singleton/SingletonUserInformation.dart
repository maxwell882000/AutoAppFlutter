import 'dart:convert';

import 'SingletonStoreToTheDiskAndLoad.dart';

class SingletonUserInformation {
  String _emailOrPhone;
  String _nameOfTransport;
  String _marka;
  String _model;
  String _yearOfMade;
  String _yearOfPurchase;
  int _numberOfTank;
  String _firstTankType;
  int _firstTankVolume;
  String _secondTankType;
  int _secondTankVolume;
  String _number;

  static final SingletonUserInformation _instance = SingletonUserInformation._internal();
  String get nameOfTransport => _nameOfTransport;
  String get emailOrPhone => _emailOrPhone;
  String get marka => _marka;
  String get model => _model;
  String get yearOfMade => _yearOfMade;
  String get yearOfPurchase => _yearOfPurchase;
  int get numberOfTank => _numberOfTank;
  String get firstTankType => _firstTankType;
  int get firstTankVolume => _firstTankVolume;
  String get secondTankType => _secondTankType;
  int get secondTankVolume => _secondTankVolume;
  String get number => _number;
  void setNameOfTransport(String nameOfTransport){
    _nameOfTransport = nameOfTransport;
  }
  void setEmailOrPhone(String emailOrPhone){
    _emailOrPhone = emailOrPhone;
  }
  void setMarka(String marka){
    _marka = marka;
  }
  void setModel(String model){
    _model = model;
  }
  void setNumber(String number){
    _number = number;
  }
  void setYearOfMade(String yearOfMade){
    _yearOfMade = yearOfMade;
  }
  void setYearOfPurchase(String yearOfPurchase){
    _yearOfPurchase = yearOfPurchase;
  }
  void setNumberOfTank(int numberOfTank){
    _numberOfTank = numberOfTank;
  }
  void setFirstTankVolume(int firstTankVolume){
    _firstTankVolume = firstTankVolume;
  }
  void setFirstTankType(String firstTankType){
    _firstTankType = firstTankType;
  }
  void setSecondTankType(String secondTankType){
    _secondTankType = secondTankType;
  }
  void setSecondTankVolume(int secondTankVolume){
    _secondTankVolume = secondTankVolume;
  }

  factory SingletonUserInformation() {
    return _instance;
  }
  Map<String, dynamic> toJson() => {
    'nameOfTransport': _nameOfTransport,
    'marka': _marka,
    'model': _model,
    'yearOfMade': _yearOfMade,
    'yearOfPurchase': _yearOfPurchase,
    'number': _number,
    'numberOfTank':_numberOfTank,
    'firstTankType': _firstTankType,
    'firstTankVolume': _firstTankVolume,
    'secondTankType': _secondTankType,
    'secondTankVolume': _secondTankVolume,
  };
  void fromJson(Map<String,dynamic> json){
    _nameOfTransport = json['nameOfTransport'];
    _marka = json['marka'];
    _model = json ['model'];
    _yearOfMade = json['yearOfMade'];
    _yearOfPurchase= json['yearOfPurchase'];
    _number       = json['number'];
    _numberOfTank= json['numberOfTank'];
    _firstTankType = json['firstTankType'];
    _firstTankVolume = json['firstTankVolume'];
    _secondTankType = json['secondTankType'];
    _secondTankVolume = json['secondTankVolume'];
  }

  void setToTheDisk() {
    SingletonStoreToTheDiskAndLoad().setToDisk('user', json.encode(toJson()));
  }
  @override
  String toString() {
    return toJson().toString();
  }
  void getFromTheDisk() async {
    String result = await SingletonStoreToTheDiskAndLoad().getFromDisk('user');
    fromJson(json.decode(result));
  }
  SingletonUserInformation._internal();
}







