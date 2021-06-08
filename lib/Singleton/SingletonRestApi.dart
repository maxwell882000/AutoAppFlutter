import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SingletonRestApi {
  static final String error = "Проблемы с подключением к сервису".tr;

  static void showErrorSnackBar(String error) {
    ScaffoldMessenger.of(Get.context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  static Future<http.Response> post(
      {String url, String body, Map<String, String> headers = const {}}) async {
    try {

      return await http.post(Uri.parse(url), headers: headers, body: body);
    } catch (e) {
      print("POST ERROR");
      showErrorSnackBar(error);
    }
  }

  static Future<http.Response> get(
      {String url, Map<String, String> headers = const {}}) async {
    try {
      return await http.get(Uri.parse(url), headers: headers);
    } catch (e) {
      print("GEt ERROR");
      showErrorSnackBar(error);
    }
  }

  static Future<http.Response> put(
      {String body, String url, Map<String, String> headers = const {}}) async {
    try {
      return await http.put(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);
    } catch (e) {
      print("PUT ERROR");
      showErrorSnackBar(error);
    }
  }

  static Future<http.Response> delete(
      {String url, Map<String, String> headers = const {}}) async {
    try {
      return await http.delete(Uri.parse(url), headers: headers);
    } catch (e) {
      print("DELTET ERORR");
      showErrorSnackBar(error);
    }
  }
}
