import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarForAccount extends StatelessWidget {
  const AppBarForAccount({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        //CAMERA
        onPressed: () {},
        icon: Icon(
          Icons.menu,
        ),
        color: Color.fromRGBO(66, 66, 74, 1),
      ),
      title: Center(
        child: Text(
          "AUTOAPP",
          style: TextStyle(
            color: Color.fromRGBO(66, 66, 74, 1),
            fontSize: width * 0.035,
          ),
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        GestureDetector(
          child: SvgPicture.asset("assets/CogWheelt.svg",
          height: width*0.07,
          ),
        ),
      SizedBox(
        width: width*0.05,
      ),
        GestureDetector(
          child: SvgPicture.asset("assets/funel.svg",
               height: width*0.07,
          ),
        ),
      ],
    );
  }
}
