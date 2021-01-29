import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Recomendation extends StatelessWidget {
  final Widget child;
  final Image image;
  Recomendation({Key key, this.child,this.image}):super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(width*0.05),
      child: Column(
        children: [
          Container(
            height: width*0.45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width*0.02),
          ),
            child: Container(
              margin: EdgeInsets.all(width*0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Image.asset(
                        'assets/images/menu/background.png',
                        fit: BoxFit.fill,
                      )
                  ),
                  SizedBox(
                    width: width*0.02,
                  ),
                  Expanded(child: Text("sadsadasdasdasdsjsakfjaskasdgdsgsdgagagsgasgasdgasdgdsag fsdadg asdf lfasfkljfklasjaskfajkfaskfaf0",
                    style: TextStyle(
                      color: HexColor("#42424A"),
                      fontFamily: 'Montserrat',
                      fontSize: width * 0.03,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: width*0.04,
          ),
         child
        ],
      ),
    );
  }
}
