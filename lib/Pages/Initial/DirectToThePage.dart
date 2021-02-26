

import 'package:TestApplication/Singleton/SingletonConnection.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Singleton/SingletonGlobal.dart';

class DirectToThePage extends StatefulWidget {
  DirectToThePage({Key key}) : super(key: key);

  @override
  _DirectToThePageState createState() => _DirectToThePageState();
}

class _DirectToThePageState extends State<DirectToThePage> {

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    _directToRightPage(context);
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        print(deepLink);
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print(deepLink.path);
      Navigator.pushNamed(context, deepLink.path);
    }
  }
  
  Future<void> _directToRightPage(BuildContext context) async {
    SingletonGlobal().setPrefs(await SharedPreferences.getInstance());
    SharedPreferences prefs = SingletonGlobal().prefs;
    int language = prefs.getInt('language') ?? -1;
    List images = prefs.getStringList('images') ?? [];
    List expenses = prefs.getStringList('expenses')?? [];
    SingletonConnection().deleteCache(images, expenses);
    if (language == -1) {
      SingletonGlobal().language = Languages.EMPTY;
      Navigator.of(context).popAndPushNamed("/language");
    } else {
      SingletonGlobal().language =
          language == 0 ? Languages.RUSSIAN : Languages.UZBEK;
      Navigator.of(context).popAndPushNamed("/select");
    }
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor("F0F8FF"),
      body: SafeArea(
        child: Center(
          child: Container(
            width: width * 0.3,
            height: width * 0.3,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: width * 0.05,
            ),
          ),
        ),
      ),
    );
  }
}
