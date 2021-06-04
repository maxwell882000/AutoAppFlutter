
import 'package:flutter/material.dart';
import 'package:flutter_projects/helper_clesses/DropDown/Fee.dart';

import 'package:flutter_projects/provider/FeeProvider.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:provider/provider.dart';



class ListFee extends StatelessWidget {

  Widget getWidgets(FeeProvider element){

    return element.delete?SizedBox()
        :ChangeNotifierProvider.value(
      value: element,
      child: Fee(
          id: element.id,
          initAmount: element.amount,
        initName: element.name,
        initSum: element.sum,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fee = Provider.of<ErrorMessageProvider>(context);
    final List<Widget> widgetFee =fee.items.map((e) => getWidgets(e)).toList();
    return Column(
      children: widgetFee,
    );
  }
}
