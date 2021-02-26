import 'dart:convert';
import 'dart:io';

import 'package:TestApplication/Singleton/SingletonAdds.dart';
import 'package:TestApplication/Singleton/SingletonGlobal.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class SingletonConnection {
  static final SingletonConnection _instance = SingletonConnection._internal();
  factory SingletonConnection() {
    return _instance;
  }
  Future<void> loadAdds() async{

      final response = await http.get("https://autoapp.elite-house.uz/adds/",
          headers: {'Content-Type': 'application/json'});
      if(response.statusCode == 200){
          Map json = jsonDecode(utf8.decode(response.bodyBytes));
          final result = await http.get("https://autoapp.elite-house.uz/adds/${json['id']}/",
              headers: {'Content-Type': 'application/json'});
          print(json['links']);
          print(result.bodyBytes);
          SingletonAdds().setLinks(json['links']);
          SingletonAdds().setImages(result.bodyBytes);
      }

  }
  Future<bool> getLocation()async{
    Location location = SingletonUserInformation().newCard.attach.location;
    print("LOCATION GET");
    print(location.toJson());
    if (location.longitude != -1 && location.latitude != -1){
      return true;
    }
    if (location.id != 0) {
      final result = await http.get(
          'https://autoapp.elite-house.uz/location/${location.id}/',
          headers: {'Content-Type': 'application/json'});
      print("Status code ${result.statusCode}");
      if (result.statusCode == 200) {
        final json = jsonDecode(utf8.decode(result.bodyBytes));
        print(json);
        location.fromJson(json);
        print(location.toJson());
        if (location.latitude != 0 && location.longitude != 0){
          return true;
        }

      }
    }
    return false;
  }

  Future<Requests> shareTransport(String account, String id) async{
    bool internet = await checkConnection();
    if(internet) {
      final response = await http.post(
          "https://autoapp.elite-house.uz/shareChoice/${SingletonUserInformation()
              .emailOrPhone}/",
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'emailOrPhone': account,
            'id': id,
          })
      );

      if (response.statusCode == 200) {
        return Requests.SUCCESSFULLY_CREATED;
      }
      else if (response.statusCode == 400) {
        return Requests.BAD_REQUEST;
      }
      else if (response.statusCode == 404){
        return Requests.NOT_FOUND;
      }
    }
    return Requests.NO_INTERNET;
  }
  Future<List> getTransports()async{
    final result = await http.get('https://autoapp.elite-house.uz/shareChoice/${SingletonUserInformation().emailOrPhone}/',
        headers: {'Content-Type': 'application/json'});

    final json = jsonDecode(utf8.decode(result.bodyBytes));
    return json;
  }

  Future<bool> checkConnection()async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  Future<void> deleteCache(List images, List expenses)async{

         images.forEach((element) {
           deleteImage(int.parse(element));
         });
         expenses.forEach((element) {
           deleteExpense(int.parse(element));
         });
  }

  Future<void> deleteImage(int id) async{
    bool connection =await checkConnection();
    List images = SingletonGlobal().prefs.getStringList('images');
    if (connection) {
      final result  = await http.delete("https://autoapp.elite-house.uz/cards/images_upload/$id/",
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      if(jsonDecode(result.body)['status'] == 200){
        images.remove(id.toString());
        SingletonGlobal().prefs.setStringList('images', images);
        return;
      }
    }
    images.add(id.toString());
    SingletonGlobal().prefs.setStringList('images', images);
  }

  Future<void> deleteExpense(int id) async{
    bool connection = await checkConnection();
    List expenses = SingletonGlobal().prefs.getStringList('expenses');

    if (connection) {
      final response = await http.delete(
        'https://autoapp.elite-house.uz/expense/$id/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if(jsonDecode(response.body)['status'] == 200){
        expenses.remove(id.toString());
        SingletonGlobal().prefs.setStringList('expenses', expenses);
        return;
      }
    }

    expenses.add(id.toString());
    SingletonGlobal().prefs.setStringList('expenses', expenses);
  }
  void deleteUser() async{

  final response =  await  http.delete("https://autoapp.elite-house.uz/units/${SingletonUserInformation().emailOrPhone}/",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },);

  }
  void updateExpenses(){
    http.put("https://autoapp.elite-house.uz/updateExpenses/${SingletonUserInformation().expenses.id}/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "all_time":SingletonUserInformation().expenses.all_time,
          "in_this_month":SingletonUserInformation().expenses.in_this_month,
        }));
  }
  void updateExpense(int id, Map<String,dynamic> json){
     http.put("https://autoapp.elite-house.uz/expense/$id/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(json));
  }
  Future<Map> createExpense() async {
    final response = await http.post("https://autoapp.elite-house.uz/expense/",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': "_",
          'sum': 0,
          'amount':0,
        }));
    Map json = jsonDecode(response.body);

    return json;
  }
  Future<void> recommendData() async {
    final  response = await http.post(
        'https://autoapp.elite-house.uz/recomendations/',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name_of_marka': SingletonUserInformation().marka,
          'name_of_model': SingletonUserInformation().model,
        }));
    final json =  jsonDecode(utf8.decode(response.bodyBytes));

    SingletonRecomendation().fromJson(json);
  }

  Future<http.Response> downloadImage(int id) async {
    final response = await http.get("https://autoapp.elite-house.uz/download/$id/");
    return response;
  }
  Future<void> recommendImage() async{
    final response = await http.get("https://autoapp.elite-house.uz/recomendations/${SingletonRecomendation().id}/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },);
    SingletonRecomendation().setImageUnit(response.bodyBytes);
  }

  Future<StreamedResponse> sendImage(String path) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://autoapp.elite-house.uz/cards/images_upload"));
    request.files.add(await http.MultipartFile.fromPath("image", path));
    request.headers.addAll({
      'Content-type': 'multipart/form-data',
    });
      return await  request.send();
  }

  Future<void> modifyCard()async{

    CardUser card =SingletonUserInformation().newCard;
    Map<String, dynamic> json= card.toJson();
    if(card.attach.uploadedImage.isNotEmpty){
      json.addAll({"images_list": card.attach.uploadedImage});
    }
    if(card.attach.location.longitude != -1 && card.attach.location.latitude != -1 ){
      print(card.attach.location.toJson());
      json.addAll({"location": card.attach.location.toJson()});
    }

      if (card.change.run == 0){
        json.addAll({'time':card.change.time});
      }
      else{
        json.addAll({'run':SingletonUnits().convertDistanceForDB(card.change.run)});
        json.addAll({'initial_run':SingletonUnits().convertDistanceForDB(SingletonUserInformation().run)});
      }
      json.addAll({'id_attach':card.attach.id});
      json.addAll({'id_change':card.change.id});


      if(card.uploadedExpense.isNotEmpty)
      json.addAll({'expense_list':card.uploadedExpense});
      await http.put(
          'https://autoapp.elite-house.uz/cards/${card.id}/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(json));
  }

  Future<void> createCards()async{
    CardUser card =SingletonUserInformation().newCard;
    Map<String, dynamic> json= card.toJson();
    if(card.attach.uploadedImage.isNotEmpty){
      json.addAll({"images_list": card.attach.uploadedImage});
    }
    if(card.attach.location.longitude != -1 && card.attach.location.latitude != -1 ){
      json.addAll({"location": card.attach.location.toJson()});
    }
    json.addAll({'run':SingletonUnits().convertDistanceForDB(card.change.run)});
    json.addAll({'initial_run':SingletonUnits().convertDistanceForDB(SingletonUserInformation().run)});

    Map  got;
    if(SingletonUserInformation().cards.id != null && SingletonUserInformation().cards.id != 0){
      json.addAll({"id":SingletonUserInformation().cards.id});
    final  response = await http.post(
          'https://autoapp.elite-house.uz/cards/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(json));
      got = jsonDecode(response.body);
    }
    else {

     final  response = await http.post(
          'https://autoapp.elite-house.uz/cards/${SingletonUserInformation().id}/',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(json));

     got = jsonDecode(response.body);
      SingletonUserInformation().cards.setId(got['id_cards']);
    }
    SingletonUserInformation().newCard.attach.setId(got['id_attach']);
    SingletonUserInformation().newCard.change.setId(got['id_change']);
    SingletonUserInformation().newCard.setId(got['id_card']);
    SingletonUserInformation().newCard.attach.location.setId(got['id_card']);
  }

  Future<void> authorizedData({String text = ""}) async{

    if (text.isEmpty){
      text = "${SingletonUserInformation().emailOrPhone}/";
    }
    final result = await http.get('https://autoapp.elite-house.uz/transport/$text',
        headers: {'Content-Type': 'application/json'});

    final json =   jsonDecode(utf8.decode(result.bodyBytes));

    SingletonUnits().fromJson(json['units']);
    SingletonUserInformation().setDate(DateTime.parse(json['date']));

    SingletonUserInformation().setProAccount(json['pro_account']);
    if (json["cards"]==null)
      SingletonUserInformation().setNOACCOUNT(true);
    else{
      SingletonUserInformation().fromJson(json['cards']);
      await recommendData();
    }



  }

  SingletonConnection._internal();
}


