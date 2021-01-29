import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:hexcolor/hexcolor.dart';

class Fee extends StatefulWidget {
  final Function delition;
  final String nameExpense;
  final String priceSpent;
  Fee({Key key, this.delition,this.nameExpense ,this.priceSpent}):super(key: key);
  @override
  _FeeState createState() => _FeeState(
    delition: delition,
    nameExpense: nameExpense,
    priceSpent: priceSpent,
  );
}

class _FeeState extends State<Fee> {
  bool pressed = false;
  final Function delition;
  final String nameExpense;
  final String priceSpent;
  _FeeState({this.delition,this.nameExpense, this.priceSpent});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: pressed?0:width*0.15,
      margin: EdgeInsets.only(bottom: pressed?0:width*0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              setState(() {
                pressed=true;
                delition();
              });
            },
           child: SvgPicture.asset(
               "assets/cross.svg",
             width: width*0.05,
           ),
          ),
          SizedBox(width: width*0.02,),

          Container(
                height: width*0.15,
                decoration: BoxDecoration(
                  color: HexColor("#C9CACE"),
                  borderRadius: BorderRadius.circular(width*0.02),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal:width*0.01),
                  width: width*0.65,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(nameExpense,
                    style: TextStyle(
                      color: HexColor("#42424A"),
                      fontFamily: 'Montserrat',
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w500,
                    ),),
                      Row(
                        children: [
                          Text(priceSpent,
                            style: TextStyle(
                              color: HexColor("#42424A"),
                              fontFamily: 'Montserrat',
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.bold,),
                          ),
                          Text("сум",
                            style: TextStyle(
                              color: HexColor("#42424A"),
                              fontFamily: 'Montserrat',
                              fontSize: width * 0.03,
                              fontWeight: FontWeight.w500,
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
    );
  }
}
