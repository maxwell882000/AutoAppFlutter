import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Errors {
  static Map payme = {
    'create_cards': "Произошла ошибка при отправке вашых данных".tr,
    'verify': "Введенный код неверен, попробуйте ещё раз".tr,
    "get_verify": "Не удалось отправить код. Попытайтесь позже".tr,
    "time_get_verify":
        "Пожалуйста подождите некоторое время перед отправкой кода ещё раз".tr,
    "not_sent_get_verify": "Не удалось отправить код! Попытайтесь позже".tr,
    -31900: "Данный тип карты не обслуживается.".tr,
    -31300: "Неверно указана дата истечения срока действия карты".tr,
    -31001: "Не подключено смс-информирование.".tr,
    -31300: "Карта с таким номером не найдена".tr,

  };

  static Map server = {
    'success' : "Вы успешно оформили подписку, ежемесячно с вашего баланса будет сниматься сумма в размере".tr,
    'error' : "Произошла ошибка во время оплаты, попытайтесь позже!".tr
  };

  static void handlePayme(Map errors, String elseThrow) {
    String throwing = "";
    try {
      throwing = payme[errors['error']['code']];
    } catch (e) {
      print(e);
      throw elseThrow;
    }
    throw throwing;
  }
  static void handleServer(Map errors) {
    String throwing = "";
    Navigator.of(Get.context).pop();
    Navigator.of(Get.context).pop();
    if (errors['success'] == false) {
      throw  server['error'];
    }
  }
}
