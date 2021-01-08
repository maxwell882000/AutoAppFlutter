import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Indicator extends StatefulWidget {
  final Function logicForIndicator;
  final String textOfIndicator;
  final double dataToBeHandled;
  Indicator(
      {Key key,
      this.logicForIndicator,
      this.textOfIndicator,
      this.dataToBeHandled})
      : super(key: key);

  @override
  _IndicatorState createState() => _IndicatorState(
        logicForIndicator: logicForIndicator,
        textOfIndicator: textOfIndicator,
        dataToBeHandled: dataToBeHandled,
      );
}

class _IndicatorState extends State<Indicator> {
  final Function logicForIndicator;
  final String textOfIndicator;
  final double dataToBeHandled;
  _IndicatorState({
    this.logicForIndicator,
    this.textOfIndicator,
    this.dataToBeHandled,
  });
  void deleteObject() {
    setState(() {
      delete = true;
    });
  }

  Color color;
  double width;
  double widthOfInidcator;
  bool delete = false;
  var colorAndWidth;

  void setInitialVartiables(double width) {
    setState(() {
      colorAndWidth = logicForIndicator(dataToBeHandled, width);

      color = colorAndWidth[0];
      widthOfInidcator = colorAndWidth[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    setInitialVartiables(width);

    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: delete ? 0 : width * 0.25,
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
              width * 0.02, width * 0.02, width * 0.02, width * 0.02),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => deleteObject(),
                    child: SvgPicture.asset(
                      "assets/cross.svg",
                      height: width * 0.05,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    textOfIndicator,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.03,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Container(
                      height: width * 0.05,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(201, 202, 206, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 1000),
                      height: width * 0.05,
                      width: widthOfInidcator,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          height: delete ? 0 : width * 0.05,
        )
      ],
    );
  }
}
