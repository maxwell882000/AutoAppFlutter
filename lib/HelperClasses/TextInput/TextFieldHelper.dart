import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldHelper extends StatefulWidget {
  TextFieldHelper({Key key}) : super(key: key);

  @override
  _TextFieldHelperState createState() => _TextFieldHelperState();
}

class _TextFieldHelperState extends State<TextFieldHelper> {
  final controller = TextEditingController();
  bool cursor = true;
  ErrorMessageProvider provider;
  String text = ""; // empty string to carry what was there before it onChanged
  int maxLength = 40;

  //"#DF5867"
  @override
  void initState() {
    super.initState();
  }

  void controllerListener() {
    controller.addListener(() {
      if (controller.text.length <= maxLength) {
        text = controller.text;
      } else {
        controller.text = text;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
      provider.setInputData(controller.text);

      provider.setSelected(controller.text.isNotEmpty ? true : false);
      if (controller.text.isNotEmpty) {
        provider.setError(false);
      }
      setState(() {
        cursor = controller.text.isEmpty ? false : true;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    provider = Provider.of<ErrorMessageProvider>(context);
    controllerListener();
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      width: double.infinity,
      height: width * 0.16,
      padding: EdgeInsets.zero,
      child: TextField(
        scrollPhysics: AlwaysScrollableScrollPhysics(),
        controller: controller,
        cursorColor: Color.fromRGBO(66, 66, 74, 1),
        showCursor: cursor,
        cursorHeight: width * 0.045,
        textAlign: TextAlign.left,
        autocorrect: false,
        maxLines: 1,
        style: TextStyle(
          fontSize: width * 0.04,
          fontFamily: "Roboto",
          color: Color.fromRGBO(66, 66, 74, 1),
        ),
        decoration: new InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          counterText: '',
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: width * 0.01),
          labelText: provider.nameOfHelper,
          labelStyle: TextStyle(
            fontSize: width * 0.03,
            fontFamily: "Roboto",
            color: Color.fromRGBO(66, 66, 74, 1),
          ),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: !provider.error
                    ? Color.fromRGBO(127, 165, 201, 1)
                    : Color.fromRGBO(223, 88, 103, 1),
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(width * 0.02)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: !provider.error
                    ? Color.fromRGBO(127, 165, 201, 1)
                    : Color.fromRGBO(223, 88, 103, 1),
                width: 1),
            borderRadius: BorderRadius.all(Radius.circular(width * 0.02)),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
