import 'dart:convert';

import 'package:TestApplication/Singleton/SingletonStoreToTheDiskAndLoad.dart';
import 'package:TestApplication/Singleton/SingletonStoreUnits.dart';

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

  void fromJson(Map<String, dynamic> json) {
    _speed = json['speedUnit'];
    _distance = json['distanseUnit'];
    _fuelConsumption = json['fuelConsumption'];
    _currency = json['volume'];
  }

  double convertDistanceForDB(double run) {
    if (distance == SingletonStoreUnits().distance.MM) {
      return run / (1000 * 1000);
    } else if (distance == SingletonStoreUnits().distance.CM) {
      return run / (1000 * 100);
    } else if (distance == SingletonStoreUnits().distance.M) {
      return run / 1000;
    } else if (distance == SingletonStoreUnits().distance.KM) {
      return run;
    }
  }

  double convertDistanceForUser(double run) {
    return _translateDistance(distance, run);
  }
  double _translateDistance(String distance,double run) {
  if (distance == SingletonStoreUnits().distance.MM) {
  return run * 1000 * 1000;
  } else if (distance == SingletonStoreUnits().distance.CM) {
  return run * 1000 * 100;
  } else if (distance == SingletonStoreUnits().distance.M) {
  return run * 1000;
  } else if (distance == SingletonStoreUnits().distance.KM) {
  return run;
  }
}
 int _translateTime(String time, int days){
   if (time == SingletonStoreUnits().time.S) {
     return days*24*60*60;
   } else if (time == SingletonStoreUnits().time.H) {
     return days*24;
   } else if (time == SingletonStoreUnits().time.D) {
     return days;
   } else if (time == SingletonStoreUnits().time.Y) {
     return days/365 as int;
   }
 }
  double convertSpeedForUser(double run,int days) {
    if (speed == SingletonStoreUnits().speed.M_D) {
      return _averageFind(run, SingletonStoreUnits().distance.M, days, SingletonStoreUnits().time.D);
    } else if (speed == SingletonStoreUnits().speed.M_Y) {
      return _averageFind(run, SingletonStoreUnits().distance.M, days, SingletonStoreUnits().time.Y);
    } else if (speed == SingletonStoreUnits().speed.M_H) {
      return _averageFind(run, SingletonStoreUnits().distance.M, days, SingletonStoreUnits().time.H);
    } else if (speed == SingletonStoreUnits().speed.M_C) {
      return _averageFind(run, SingletonStoreUnits().distance.M, days, SingletonStoreUnits().time.S);
    } else if (speed == SingletonStoreUnits().speed.KM_D) {
      return _averageFind(run, SingletonStoreUnits().distance.KM, days, SingletonStoreUnits().time.D);
    } else if (speed == SingletonStoreUnits().speed.KM_Y) {
      return _averageFind(run, SingletonStoreUnits().distance.KM, days, SingletonStoreUnits().time.Y);
    } else if (speed == SingletonStoreUnits().speed.KM_H) {
      return _averageFind(run, SingletonStoreUnits().distance.KM, days, SingletonStoreUnits().time.H);
    } else if (speed == SingletonStoreUnits().speed.KM_C) {
      return _averageFind(run, SingletonStoreUnits().distance.KM, days, SingletonStoreUnits().time.S);
    }
  }
  double _averageFind(double run, String translateRun, int days, String translateTime){
        double translatedRun = _translateDistance(translateRun, run);
        int translatedTime = _translateTime(translateTime,days);
        return translatedRun/translatedTime;
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
