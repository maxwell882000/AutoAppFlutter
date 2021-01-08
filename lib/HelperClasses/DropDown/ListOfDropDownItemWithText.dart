import 'package:TestApplication/HelperClasses/DropDown/DropDownItem.dart';
import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOfDropDownItemWithText extends StatefulWidget {
  final List item;
  final double width;
  final double disabledHeightOfItem;
  final double enabledHeightOfItem;
  final double heightOfDropDownItems;
  ListOfDropDownItemWithText({
    Key key,
    this.item,
    this.width,
    this.disabledHeightOfItem,
    this.enabledHeightOfItem,
    this.heightOfDropDownItems,
  }) : super(key: key);
  @override
  _ListOfDropDownItemWithTextState createState() =>
      _ListOfDropDownItemWithTextState(
        item: item,
        width: width,
        disabledHeightOfItem: disabledHeightOfItem,
        enabledHeightOfItem: enabledHeightOfItem,
        heightOfDropDownItems: heightOfDropDownItems,
      );
}

class _ListOfDropDownItemWithTextState
    extends State<ListOfDropDownItemWithText> {
  final List item;
  final double width;
  final double disabledHeightOfItem;
  final double enabledHeightOfItem;
  final double heightOfDropDownItems;
  _ListOfDropDownItemWithTextState({
    this.item,
    this.width,
    this.disabledHeightOfItem,
    this.enabledHeightOfItem,
    this.heightOfDropDownItems,
  });

  String hintText;
  String nameOfTextHelper;
  List dropDownItem;
  var rowWithText;
  List collectionOfPreparedData;
  ErrorMessageProvider provider;
  @override
  void initState() {
    super.initState();
  }

  List prepareData(List item) {
    nameOfTextHelper = item[0];
    hintText = item[1];
    dropDownItem = item.sublist(2);
    return [nameOfTextHelper, hintText, dropDownItem];
  }

  Widget getTextWithChoices(List value) {
    final String textHelper = value[0];
    final String textHint = value[1];
    final ErrorMessageProvider errors = ErrorMessageProvider(textHint);
    final List errorsWithText = [textHelper, errors];
    provider.setErrorsMessageWithText(errorsWithText);
    return ChangeNotifierProvider<ErrorMessageProvider>.value(
      value: errors,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  textHelper,
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: width * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  child: DropDownItem(
                    items: value[2],
                    width: width,
                    disabledHeight: disabledHeightOfItem,
                    enabledHeight: enabledHeightOfItem,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: width * 0.04,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<ErrorMessageProvider>(context);
    collectionOfPreparedData = item.map((value) => prepareData(value)).toList();
    rowWithText = collectionOfPreparedData
        .map((value) => getTextWithChoices(value))
        .toList();
    return Container(
      height: heightOfDropDownItems,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: rowWithText.toList(),
        ),
      ),
    );
  }
}
