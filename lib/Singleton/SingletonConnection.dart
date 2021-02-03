import 'dart:convert';

import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:http/http.dart' as http;
class SingletonConnection {
  static final SingletonConnection _instance = SingletonConnection._internal();
  factory SingletonConnection() {
    return _instance;
  }
  Future<void> authorizedData() async{
    final result = await http.get('https://autoapp.elite-house.uz/transport/+998911669982/', headers: {'Content-Type': 'application/json'});
    final json =   jsonDecode(utf8.decode(result.bodyBytes));
    print(json);
    SingletonUnits().fromJson(json['units']);
    SingletonUserInformation().setDate(DateTime.parse(json['date']));
    print(SingletonUserInformation().date);
    SingletonUserInformation().fromJson(json['cards']);
    print(SingletonUserInformation().toString());
  }
  SingletonConnection._internal();
}

enum Languages {
  EMPTY,
  UZBEK,
  RUSSIAN,
}
