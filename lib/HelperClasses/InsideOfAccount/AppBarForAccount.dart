import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarForAccount extends StatelessWidget {
  final Widget nameBar;
  final double heightBar;
  const AppBarForAccount({Key key, this.nameBar , this.heightBar}) : super(key: key);

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
          size: width*0.1,
        ),
        color: Color.fromRGBO(66, 66, 74, 1),
      ),
      title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            nameBar,
            Flexible(child:Text("") ,),
          ],
        ),
    toolbarHeight: width*0.15,
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
