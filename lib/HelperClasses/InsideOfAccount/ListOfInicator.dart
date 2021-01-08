import 'package:TestApplication/HelperClasses/InsideOfAccount/Indicator.dart';
import 'package:flutter/material.dart';

class ListOfIndicator extends StatefulWidget {
  final List indicators;
  final Function logicForIndicator;
  ListOfIndicator({Key key, this.indicators, this.logicForIndicator})
      : super(key: key);

  @override
  _ListOfIndicatorState createState() => _ListOfIndicatorState(
        indicators: indicators,
        logicForIndicator: logicForIndicator,
      );
}

class _ListOfIndicatorState extends State<ListOfIndicator> {
  final List indicators;
  final Function logicForIndicator;
  _ListOfIndicatorState({this.indicators, this.logicForIndicator});
  var allIndicators;

  @override
  void initState() {
    super.initState();
    allIndicators =
        indicators.map((indicator) => getIndicators(indicator)).toList();
  }

  
  Widget getIndicators(List indicator) {
    return Column(
      children: [
        Indicator(
          textOfIndicator: indicator[0],
          logicForIndicator: logicForIndicator,
          dataToBeHandled: indicator[1],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: double.infinity,
        height: width*1.05,
        child: SingleChildScrollView(
                  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: allIndicators.toList(),
          ),
        ),
      );
  }
}
