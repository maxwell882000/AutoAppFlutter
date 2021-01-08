import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

class AbovePartOfAccount extends StatelessWidget {
  final List informationAboutCar;
  final double width;
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
        padding: EdgeInsets.symmetric(
            vertical: width * 0.04, horizontal: width * 0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name OF The car",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold,
                fontSize: width * 0.038,
                color: HexColor("#FFFFFF"),
              ),
            ),
            SizedBox(
              height: width*0.07,
            ),
           Text(
           "Some Information",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.03,
             color: HexColor("#FFFFFF"),
           ),
            ),
       SizedBox(
              height: width*0.035,
            ),
            Text(
           "Some Information",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.03,
             color: HexColor("#FFFFFF"),
           ),
            ),
          SizedBox(
              height: width*0.035,
            ),
            Text(
           "Some Information",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.03,
             color: HexColor("#FFFFFF"),
           ),
            ),
        SizedBox(
              height: width*0.035,
            ),
            Text(
           "Some Information",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.03,
             color: HexColor("#FFFFFF"),
           ),
            ),
            SizedBox(
              height: width*0.035,
            ),
             Text(
           "Some Information",
           style: TextStyle(
             fontFamily: "Montserrat",
             fontSize: width * 0.03,
             color: HexColor("#FFFFFF"),
           ),
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
                  children: [
                    Flexible(
                      child: Text(
                        "Some information",
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
                  children: [
                    Flexible(
                      child: Text(
                        "Some information",
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
                  children: [
                    Flexible(
                      child: Text(
                        "Some information",
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
