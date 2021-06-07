import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonUnits.dart';

import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ExportExcel {
  Excel excel;

  ExportExcel() {

   this.excel =  Excel.createExcel();
  }

  Future getPermission() async {
    var status = await Permission.storage.status;

    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
  Future getMainData() async {
    excel.rename("Sheet1", "Главное".tr);
    var sheet = excel['Главное'.tr];
    sheet.appendRow(
        ["Название транспорта".tr, SingletonUserInformation().nameOfTransport]);
    sheet.appendRow(["Mарка".tr, SingletonUserInformation().marka]);
    sheet.appendRow(["Модель".tr, SingletonUserInformation().model]);
    sheet.appendRow(
        ["Год производства".tr, SingletonUserInformation().yearOfMade]);
    sheet.appendRow(
        ["Год покупки".tr, SingletonUserInformation().yearOfPurchase]);
    sheet.appendRow(["Тип".tr, SingletonUserInformation().firstTankType]);
    sheet.appendRow(["Обьем".tr, SingletonUserInformation().firstTankVolume]);
    if (SingletonUserInformation().numberOfTank == 2) {
      sheet.appendRow(["Тип".tr, SingletonUserInformation().secondTankType]);
      sheet
          .appendRow(["Обьем".tr, SingletonUserInformation().secondTankVolume]);
    }
    sheet.appendRow(["Номер".tr, SingletonUserInformation().number]);
    sheet
        .appendRow(["Тех Паспорт".tr, SingletonUserInformation().techPassport]);
    sheet.appendRow(
        ["Средний пробег".tr, "${SingletonUserInformation().average} км/д"]);
    sheet.appendRow([
      "Пробег".tr,
      "${SingletonUserInformation().run} ${SingletonUnits().distance}"
    ]);
    sheet.appendRow([
      "Расходы в этом месяце".tr,
      "${SingletonUserInformation().expenses.in_this_month} ${SingletonUnits().currency}"
    ]);
    sheet.appendRow([
      "Расходы за все время".tr,
      "${SingletonUserInformation().expenses.all_time} ${SingletonUnits().currency}"
    ]);
  }
  Future save() async{
    Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
    String appDocPath = tempDir.path;
    String pathOfFile = appDocPath.split("/").last;
    print(appDocPath);
    File(join(appDocPath, "autoapp.xlsx"))
      ..createSync()
      ..writeAsBytesSync(excel.encode());
    return pathOfFile;
  }
  Future getCards() async {

    SingletonUserInformation().cards.storeCards.forEach((element) { });
  }
  Future getCard(CardUser store) async {
    var sheet = excel[store.nameOfCard];
    sheet.appendRow(["".tr, ]);
  }
  Future<String> export() async {
    await SingletonUserInformation().cards.loadStoreCards();
    await getPermission();
    await getMainData();

    return await save();
  }
}
