import 'package:flutter/material.dart';

import 'Fee.dart';

class ListFee extends StatefulWidget {
  final List fee;
  ListFee({Key key, this.fee}):super(key:key);
  @override
  _ListFeeState createState() => _ListFeeState(
    fee: fee,
  );
}

class _ListFeeState extends State<ListFee> {
  final List fee;
  _ListFeeState({Key key, this.fee});

  List widgetFee = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preparationData();
  }
  void preparationData(){
    widgetFee = fee.map((e) => getWidgets(e)).toList();
  }
  Widget getWidgets(List element){
    return Fee(
      delition: (){
        fee.remove(element);
      },
      nameExpense: element[0],
      priceSpent: element[1],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(

      children: widgetFee,
    );
  }
}
