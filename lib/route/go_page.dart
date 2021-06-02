import 'package:flutter_projects/pages/Initial/Language.dart';
import 'package:get/get.dart';

class GoPage{
  static String menu;
  static List<GetPage> routes = [
    GetPage(name: menu, page: () => Language()),
  ];
}