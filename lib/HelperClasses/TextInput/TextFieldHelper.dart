import 'package:TestApplication/Provider/ErrorMessageProvider.dart';
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
  var provider;

  //"#DF5867"
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void controllerListener() {
    controller.addListener(() {
      provider.setInputData(controller.text);
      setState(() {
        cursor = controller.text.isEmpty ? false : true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    provider = Provider.of<ErrorMessageProvider>(context);
    controllerListener();
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      width: double.infinity,
      height: width * 0.13,
      padding: EdgeInsets.all(0),
      child: TextField(
        controller: controller,
        cursorColor: Color.fromRGBO(66, 66, 74, 1),
        showCursor: cursor,
        cursorHeight: width * 0.045,
        textAlign: TextAlign.left,
        autocorrect: false,
        style: TextStyle(
          fontSize: width * 0.04,
          fontFamily: "Roboto",
          color: Color.fromRGBO(66, 66, 74, 1),
        ),
        decoration: new InputDecoration(
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(
              width * 0.02, width * 0.12, width * 0.02, width * 0.08),
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
