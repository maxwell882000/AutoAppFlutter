import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/Provider/UserProvider.dart';
import 'package:flutter_projects/Singleton/SingletonUnits.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AbovePartOfAccount extends StatelessWidget {
  final List informationAboutCar;
  final double width;

  // final String nameOfCar = "${SingletonUserInformation().marka} ${SingletonUserInformation().model}";
  // final String number = "${SingletonUserInformation().number}";
  // final String techPassport ="${SingletonUserInformation().techPassport}";
  // final String run ="${SingletonUserInformation().run} ${SingletonUnits().distance}";
  // final String tenure = "${SingletonUserInformation().tenure()} лет";
  // final String averageRun = "${SingletonUserInformation().average} ${SingletonUnits().speed}";
  // final String changeDetails = "${SingletonUserInformation().cards.changeDetails}";
  // final String allExpense = "${SingletonUserInformation().expenses.all_time} ${SingletonUnits().currency}";
  // final String inMonthExpense = "${SingletonUserInformation().expenses.in_this_month} ${SingletonUnits().currency}";

  AbovePartOfAccount({Key key, this.informationAboutCar, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        height: width * 0.6,
        width: width * 0.52,
        decoration: BoxDecoration(
          color: Color.fromRGBO(62, 124, 165, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${provider.nameOfCar}",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: width * 0.038,
                color: HexColor("#FFFFFF"),
              ),
            ),
            SizedBox(
              height: width * 0.05,
            ),
            Text(
              "${provider.number}",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: width * 0.034,
                color: HexColor("#FFFFFF"),
              ),
            ),
            SizedBox(
              height: width * 0.035,
            ),
            Text(
              "${provider.techPassport}",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: width * 0.034,
                color: HexColor("#FFFFFF"),
              ),
            ),
            SizedBox(
              height: width * 0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Текущий пробег:".tr,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.025,
                    color: HexColor("#FFFFFF"),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${provider.run.toStringAsFixed(0)} ${SingletonUnits().distance}",
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
              height: width * 0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Срок Владения:".tr,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.025,
                    color: HexColor("#FFFFFF"),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${provider.tenure}",
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
              height: width * 0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Средний пробег:".tr + " ",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.025,
                    color: HexColor("#FFFFFF"),
                  ),
                ),
                Flexible(
                  child: Text(
                    "${provider.averageRun.toStringAsFixed(0)} ${SingletonUnits().speed}",
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
              child: GestureDetector(
                onTap: () => provider.setSortChange(true),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(223, 88, 103, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "нуждаются в замене/проверке".tr +
                          "\n" +
                          "${provider.changeDetail}" +
                          "\n" +
                          "деталей".tr,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: width * 0.03,
                        color: HexColor("#FFFFFF"),
                      ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: width * 0.02,
            ),
            containerTextRight(
              title: "Расход на детали за всё время".tr,
              body: "${provider.expenseAll} ${SingletonUnits().currency}",
            ),
            SizedBox(
              height: width * 0.02,
            ),
            containerTextRight(
                title: "Расход на детали за этот месяц".tr,
                body: "${provider.expenseMonth} ${SingletonUnits().currency}")
          ],
        ),
      ),
    ]);
  }

  Widget containerTextRight({String title, String body}) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 204, 51, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                title,
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
                body,
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
    );
  }
}
