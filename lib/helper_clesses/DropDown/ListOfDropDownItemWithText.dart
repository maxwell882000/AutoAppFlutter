import 'package:flutter_projects/Pages/Date.dart';

import 'package:flutter_projects/Singleton/SingletonRegistrationAuto.dart';
import 'package:flutter_projects/Singleton/SingletonUnits.dart';
import 'package:flutter_projects/helper_clesses/TextInput/TextFieldHelper.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'DropDownItem.dart';

class ListOfDropDownItemWithText extends StatefulWidget {
  final List item;
  final double width;
  final double disabledHeightOfItem;
  final double enabledHeightOfItem;
  final double heightOfDropDownItems;
  final List itemWithTextField;
  final ErrorMessageProvider provider;

  ListOfDropDownItemWithText({
    Key key,
    this.item,
    this.width,
    this.disabledHeightOfItem,
    this.enabledHeightOfItem,
    this.heightOfDropDownItems,
    this.itemWithTextField,
    this.provider,
  }) : super(key: key);

  @override
  _ListOfDropDownItemWithTextState createState() =>
      _ListOfDropDownItemWithTextState(
        item: item,
        width: width,
        disabledHeightOfItem: disabledHeightOfItem,
        enabledHeightOfItem: enabledHeightOfItem,
        heightOfDropDownItems: heightOfDropDownItems,
        itemWithTextField: itemWithTextField,
      );
}

class _ListOfDropDownItemWithTextState
    extends State<ListOfDropDownItemWithText> {
  final List item;
  final double width;
  final double disabledHeightOfItem;
  final double enabledHeightOfItem;
  final double heightOfDropDownItems;
  final List itemWithTextField;

  _ListOfDropDownItemWithTextState({
    this.item,
    this.width,
    this.disabledHeightOfItem,
    this.enabledHeightOfItem,
    this.heightOfDropDownItems,
    this.itemWithTextField,
  });

  int selection;
  String hintText;
  String nameOfTextHelper;
  List dropDownItem;
  List<Widget> rowWithText;
  List collectionOfPreparedData;

  @override
  void initState() {
    super.initState();
    widget.provider.errorsMessageWithText.clear();
    dataPreparing();
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

    return ChangeNotifierProvider<ErrorMessageProvider>(
      key: UniqueKey(),
      create: (_) {
        final ErrorMessageProvider errors = new ErrorMessageProvider(textHint);
        final List errorsWithText = [textHelper, errors];
        widget.provider.setErrorsMessageWithText(errorsWithText);
        return errors;
      },
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

  Function getAdditionalItems(List element) {
    return (String chosenItem) {
      print("CHOSen : $chosenItem");
      print(element);
      int index = this.collectionOfPreparedData.indexOf(element);
      print(index);
      print(this.collectionOfPreparedData.length);
      if (this.collectionOfPreparedData.length > index + 1) {
        print("NEXT ELEMENT");

        String name = element[1];

        if (name == "ТИП 1го бака".tr ||
            name == "ТИП 2го бака".tr ||
            name == "ТИП".tr) {
          List nextElement = this.collectionOfPreparedData[index + 1];
          if (nextElement[1] == "ОБЬЕМ".tr) {
            return;
          }
        }
      }
      print("ELEMT ${element[1] == "КОЛИЧЕСТВО БАКОВ".tr}");
      print(element);
      List sub = SingletonRegistrationAuto().subList(chosenItem, element[1]);
      if (sub.isNotEmpty) {
        List prepared = sub[1].map((e) => prepareDataWithTextField(e)).toList();
        String additional = sub[2];
        int index;
        setState(() {
          print(additional);
          print(prepared[0][1]);
          List str_prepared =
              SingletonRegistrationAuto().deleteBelow(element[1], chosenItem);
          List removed = collectionOfPreparedData
              .where((element) =>
                  element[1] == str_prepared[0] ||
                  element[1] == str_prepared[1] ||
                  (element[1] == additional))
              .map((e) => e)
              .toList();
          if (removed.isNotEmpty) {
            int index = collectionOfPreparedData.indexOf(element) + 1;
            if (sub[3] == 1) {
              removed.forEach((e) => {
                    rowWithText.removeAt(collectionOfPreparedData.indexOf(e)),
                    widget.provider.errorsMessageWithText
                        .removeAt(collectionOfPreparedData.indexOf(e)),
                    collectionOfPreparedData.remove(e),
                  });
            } else if (sub[3] == 2 && index < collectionOfPreparedData.length) {
              rowWithText.removeAt(index);
              widget.provider.errorsMessageWithText.removeAt(index);
              collectionOfPreparedData.removeAt(index);
            }
          }
          index = collectionOfPreparedData.indexOf(element);
          prepared.asMap().forEach((i, e) => {
                collectionOfPreparedData.insert(index + i + 1, e),
                rowWithText.insert(index + i + 1, getUpdate(e, index + i + 1))
              });
        });
      }
    };
  }

  Widget getUpdate(List v, int index) {
    final String textHelper = v[1];
    final String textHint = v[2];
    ErrorMessageProvider errors =
        widget.provider.newErrorMessageProvider(textHint);
    if (v[0] == 1) {
      errors.setTextField(true);
    } else {
      errors.setItems(v[3]);
    }
    final List errorsWithText = [textHelper, errors];
    widget.provider.errorsMessageWithText.insert(index, errorsWithText);
    return getWidget(widget.provider, errorsWithText, textHelper, v, errors);
  }

  Widget getTextCombiningWithTextField(List v, {int index}) {
    final String textHelper = v[1];
    final String textHint = v[2];
    ErrorMessageProvider errors =
        widget.provider.newErrorMessageProvider(textHint);
    if (v[0] == 1) {
      errors.setTextField(true);
    } else if (v[0] == 0) {
      errors.setItems(v[3]);
    }
    final List errorsWithText = [textHelper, errors];
    widget.provider.errorsMessageWithText.add(errorsWithText);
    return getWidget(widget.provider, errorsWithText, textHelper, v, errors,
        index: index);
  }

  Widget choiceOfWidget(List element, ErrorMessageProvider errors,
      {int index}) {
    Widget choice;
    if (element[0] == 1) {
      choice = TextFieldHelper(
        onlyInteger: element[3] == 2 || element[3] == 1 ? true : false,
        suffixIcon: element[3] != 2
            ? null
            : SizedBox(
                height: width * 0.1,
                child: Container(
                  margin: EdgeInsets.only(right: width * 0.03),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        SingletonUnits().distance ?? "",
                        style: TextStyle(
                          color: HexColor("#42424A"),
                          fontFamily: 'Roboto',
                          fontSize: width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      );
    } else if (element[0] == 2) {
      choice = Date();
    } else {
      choice = DropDownItem(
        items: errors.items,
        width: width,
        disabledHeight: disabledHeightOfItem,
        enabledHeight: enabledHeightOfItem,
        additionalItemsFunction: getAdditionalItems(element),
      );
    }
    return choice;
  }

  Widget getWidget(ErrorMessageProvider provider, List errorsWithText,
      String textHelper, List v, ErrorMessageProvider errors,
      {int index}) {
    return ChangeNotifierProvider<ErrorMessageProvider>.value(
      key: UniqueKey(),
      value: provider.errorsMessageWithText[
          provider.errorsMessageWithText.indexOf(errorsWithText)][1],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: width * 0.04,
          ),
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
                  child: choiceOfWidget(v, errors, index: index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List prepareDataWithTextField(List item) {
    selection = item[0];
    nameOfTextHelper = item[1];
    hintText = item[2];
    if (selection == 0) {
      dropDownItem = item.sublist(3);
      return [selection, nameOfTextHelper, hintText, dropDownItem];
    }
    List selected = [selection, nameOfTextHelper, hintText];
    if (selection == 1) {
      selected.add(item[3]);
      return selected;
    }
    return selected;
  }

  void dataPreparing() {
    if (itemWithTextField == null) {
      collectionOfPreparedData =
          item.map((value) => prepareData(value)).toList();

      rowWithText = collectionOfPreparedData
          .map((value) => getTextWithChoices(value))
          .toList();
    } else {
      collectionOfPreparedData = itemWithTextField
          .map((value) => prepareDataWithTextField(value))
          .toList();
      rowWithText = collectionOfPreparedData
          .asMap()
          .entries
          .map((value) =>
              getTextCombiningWithTextField(value.value, index: value.key))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
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
