
import 'package:flutter/material.dart';
import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/Buttons.dart';
import 'package:flutter_projects/helper_clesses/ChildAndButton.dart';
import 'package:flutter_projects/helper_clesses/InitialPointOfAccount/Base.dart';
import 'package:flutter_projects/helper_clesses/TextInput/TextFieldHelper.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class UpdateRun extends StatefulWidget {


  UpdateRun({Key key}) : super(key: key);

  @override
  _UpdateRunState createState() => _UpdateRunState();
}

class _UpdateRunState extends State<UpdateRun> {
  final ErrorMessageProvider provider = new ErrorMessageProvider("Введите пробег".tr);

  Future updateRun(BuildContext context) async{
    ErrorMessageProvider provider = Provider.of<ErrorMessageProvider>(context, listen: false);
    if (provider.inputData.isNotEmpty){
      double run = double.parse(provider.inputData);
      print(run);
      print(SingletonUserInformation().run);
      print(SingletonUserInformation().emailOrPhone);
        if (run> SingletonUserInformation().run){
          SingletonUserInformation().setRun(run);
          SingletonUserInformation().updateRun();
          Navigator.of(context).pop();
        }
        else {
          provider.setError(true);
          provider.setNameOfHelper("Пробег всегда должен увеличиваться".tr);
        }
    }
    else {
      provider.setError(true);
      provider.setNameOfHelper("Пожалуйста заполните поле".tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider.value(
      value: provider,
      child: Base(
        width: width,
        height: width * 0.9,
        icon: "assets/car.svg",
        aboveText: "Обновить пробег машины".tr,
        child: ChildAndButton(
          width: Get.width,
          aboveChild: TextFieldHelper(
            onlyInteger: true,
          ),
          button: Buttons(
            hexValueOFColor: "#7FA6C9",
            nameOfTheButton: "Пременить".tr,
            onPressed: updateRun,
            height: width,
          ),
          size:
          EdgeInsets.fromLTRB(width * 0.15, width * 0.08, width * 0.15, 0),
          heightOfButton: width * 0.005,
        ),
      ),
    );
  }
}
