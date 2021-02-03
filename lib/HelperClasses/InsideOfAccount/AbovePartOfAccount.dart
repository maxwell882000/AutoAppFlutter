import 'package:TestApplication/Singleton/SingletonUnits.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class AbovePartOfAccount extends StatelessWidget {
  final List informationAboutCar;
  final double width;
  final String nameOfCar = "${SingletonUserInformation().marka} ${SingletonUserInformation().model}";
  final String number = "${SingletonUserInformation().number}";
  final String techPassport ="${SingletonUserInformation().techPassport}";
  final String run ="${SingletonUserInformation().run} ${SingletonUnits().distance}";
  final String tenure = "${SingletonUserInformation().tenure()} лет";
  final String averageRun = "${SingletonUserInformation().averageRun()} ${SingletonUnits().speed}";
  final String changeDetails = "11";
  final String allExpense = "${SingletonUserInformation().expenses.all_time} ${SingletonUnits().currency}";
  final String inMonthExpense = "${SingletonUserInformation().expenses.in_this_month} ${SingletonUnits().currency}";
  AbovePartOfAccount({Key key, this.informationAboutCar, this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Container(
        height: width * 0.6,
        width: width * 0.52,
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 124, 165, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric( horizontal: width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$nameOfCar",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: width * 0.038,
                color: HexColor("#FFFFFF"),
              ),
            ),
            SizedBox(
              height: width*0.05,
            ),
           Text(
           "$number",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.034,
             color: HexColor("#FFFFFF"),
           ),
            ),
       SizedBox(
              height: width*0.035,
            ),
            Text(
           "$techPassport",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.034,
             color: HexColor("#FFFFFF"),
           ),
            ),
          SizedBox(
              height: width*0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Текущий пробег:",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.025,
                    color: HexColor("#FFFFFF"),
                  ),
                ),
                Flexible(
                  child: Text(
                    "$run",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: width * 0.025,
                      color: HexColor("#FFFFFF"),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        SizedBox(
              height: width*0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
           "Срок Владения:",
           style: TextStyle(
                 fontFamily: "Montserrat",
                 fontSize: width * 0.025,
                 color: HexColor("#FFFFFF"),
           ),
                ),
                Flexible(
                  child: Text(
                    "$tenure",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: width * 0.025,
                      color: HexColor("#FFFFFF"),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width*0.035,
            ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
           "Средний пробег:  ",
           style: TextStyle(
                 fontFamily: "Montserrat",
                 fontSize: width * 0.025,
                 color: HexColor("#FFFFFF"),
           ),
            ),
                 Flexible(
                   child: Text(
                     "$averageRun",
                     style: TextStyle(
                       fontFamily: "Montserrat",
                       fontSize: width * 0.025,
                       color: HexColor("#FFFFFF"),
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                 ),
               ],
             ),
          ],
        ),
      ),
  
      Container(
        height: width * 0.6,
        width: width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                height: width * 0.19,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(223, 88, 103, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "$changeDetails",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.03,
                          color: HexColor("#FFFFFF"),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "деталей нуждаются в проверке/замене",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.03,
                          color: HexColor("#FFFFFF"),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: width * 0.02,
            ),
            Expanded(
              child: Container(
                height: width * 0.19,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 204, 51, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Расход на детали за всё время",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.03,
                          color: HexColor("#42424A"),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "$allExpense",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.03,
                          color: HexColor("#42424A"),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: width * 0.02,
            ),
            Expanded(
              child: Container(
                height: width * 0.19,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: width * 0.04, horizontal: width * 0.04),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 204, 51, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Расход на детали за этот месяц",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.03,
                          color: HexColor("#42424A"),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "$inMonthExpense",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: width * 0.03,
                          color: HexColor("#42424A"),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
