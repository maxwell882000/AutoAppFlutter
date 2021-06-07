import 'package:flutter/material.dart';
import 'package:flutter_projects/helper_clesses/DropDown/ListFee.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';


class ListExpenses extends StatelessWidget {
  final Widget child;
  const ListExpenses({Key key,this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: Get.width * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Расходы".tr,
                style: TextStyle(
                  color: HexColor("#42424A"),
                  fontFamily: 'Montserrat',
                  fontSize:Get.width * 0.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: Get.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListFee(),
                    SizedBox(
                      height: Get.width * 0.01,
                    ),

                  ],
                ),
              ),
              child
            ],
          ),
        ),
      ],
    );
  }
}
