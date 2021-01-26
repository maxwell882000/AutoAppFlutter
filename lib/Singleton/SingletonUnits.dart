import 'dart:convert';

import 'package:TestApplication/Singleton/SingletonStoreToTheDiskAndLoad.dart';

class SingletonUnits {
  String _speed;
  String _distance;
  String _fuelConsumption;
  String _currency;
  static final SingletonUnits _instance = SingletonUnits._internal();

  factory SingletonUnits() {
    return _instance;
  }

  String get speed => _speed;

  String get distance => _distance;

  String get fuelConsumption => _fuelConsumption;

  String get currency => _currency;

  void setSpeed(String speed) {
    this._speed = speed;
  }

  void setDistance(String distance) {
    this._distance = distance;
  }

  void setFuelConsumption(String fuelConsumption) {
    this._fuelConsumption = fuelConsumption;
  }

  void setCurrency(String currency) {
    this._currency = currency;
  }

  Map<String, dynamic> toJson() => {
        'speedUnit': _speed,
        'distanseUnit': _distance,
        'fuelConsumption': _fuelConsumption,
        'volume': _currency,
      };
  void fromJson(Map<String,dynamic> json){
    _speed = json['speedUnit'];
    _distance = json['distanseUnit'];
    _fuelConsumption = json['fuelConsumption'];
    _currency = json['volume'];
  }


  void setToTheDisk() {
    SingletonStoreToTheDiskAndLoad().setToDisk('unit', json.encode(toJson()));
  }
 @override
 String toString() {
    return toJson().toString();
  }
  void getFromTheDisk() async {
    String result = await SingletonStoreToTheDiskAndLoad().getFromDisk('unit');
    fromJson(json.decode(result));
  }

  SingletonUnits._internal();
}
