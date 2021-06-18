import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_projects/Pages/Inside/Map.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/dynamicLinks.dart';
import 'package:flutter_projects/helper_clesses/InsideOfAccount/StoreCards.dart';
import 'package:flutter_projects/helper_clesses/Payme/code_verification.dart';
import 'package:flutter_projects/helper_clesses/Payme/payme_pay.dart';
import 'package:flutter_projects/pages/Date.dart';
import 'package:flutter_projects/pages/Initial/DirectToThePage.dart';
import 'package:flutter_projects/pages/Initial/Language.dart';
import 'package:flutter_projects/pages/Initial/LogIn.dart';
import 'package:flutter_projects/pages/Initial/LogInSelectingOption.dart';
import 'package:flutter_projects/pages/Inside/Adds.dart';
import 'package:flutter_projects/pages/Inside/CreateCards.dart';
import 'package:flutter_projects/pages/Inside/Menu.dart';
import 'package:flutter_projects/pages/Inside/ModifyCards.dart';
import 'package:flutter_projects/pages/Inside/PointerLocation.dart';
import 'package:flutter_projects/pages/Inside/ProPurchase.dart';
import 'package:flutter_projects/pages/Inside/RecomendationService.dart';
import 'package:flutter_projects/pages/Inside/SingleRecomendation.dart';
import 'package:flutter_projects/pages/Inside/TrackLocation.dart';
import 'package:flutter_projects/pages/Inside/UpdateRun.dart';
import 'package:flutter_projects/pages/Inside/User.dart';
import 'package:flutter_projects/pages/Registration/Registration.dart';
import 'package:flutter_projects/pages/Registration/RegistrationAuto.dart';
import 'package:flutter_projects/pages/Registration/SelectUnit.dart';
import 'package:flutter_projects/service/fire_base_messaging.dart';
import 'package:flutter_projects/service/location_service.dart';
import 'package:flutter_projects/service/notification_service.dart';
import 'package:flutter_projects/service/translation_service.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'package:workmanager/workmanager.dart';
import 'Singleton/SingletonGlobal.dart';
import 'pages/Inside/ChoosePayment.dart';
import 'pages/Inside/History.dart';

void backTask() {
  Workmanager().executeTask((task, inputData)  async{
    await SingletonGlobal().init();
    NotificationService.initializeNotification('back_channel');
    if (SingletonUserInformation().isAuthorized) {
      NotificationService.initializeNotification('track_channel');
      AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'track_channel',
            title: "Обновить пробег!".tr,
            body: 'Хотите обновить ваш пробег ?'.tr),
        actionButtons: [
          NotificationActionButton(
              key: ButtonNotificationKeys.TRACKING_KEY,
              label: "Да, хочу обновить!",
              enabled: true,
          )
        ],
      );
    }
    else {

    }
    return Future.value(true);
  });
}

void initServices() async {
  Get.log('starting services ...');
  await Get.putAsync(() => TranslationService().init());
  await Get.putAsync(() => NotificationService().init());
  await SingletonGlobal().init();
  await Get.putAsync(() => FireBaseService().init());
  await Get.putAsync(() => LocationService().init());
  Get.log('All services started...');
}

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  FirebaseMessaging.onBackgroundMessage(FireBaseService.backGroundTasks);

  Workmanager().initialize(
    backTask,
    isInDebugMode: true,
  );

  Workmanager().registerPeriodicTask('2', "notification",
      inputData: {
        "auth": SingletonUserInformation().isAuthorized,
      },
      frequency: Duration(days: 1));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.autoScale(480, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ],
          background: Container(
            color: Color(0xFFF5F5F5),
          )),
      initialRoute: "/direct",
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: SingletonGlobal().locale,
      routes: <String, WidgetBuilder>{
        "/direct": (context) => DirectToThePage(),
        "/language": (context) => Language(),
        "/select/login": (context) => LogIn(),
        "/select": (context) => LogInSelectingOption(),
        "/select/registration": (context) => Registration(),
        "/select_unit": (context) => SelectUnit(),
        "/registration_auto": (context) => RegistrationAuto(),
        "/authorized": (context) => User(),
        "/create_cards": (context) => CreateCards(),
        "/modify_cards": (context) => ModifyCards(),
        "/recomendation_service": (context) => RecomendationService(),
        "/single_recomendation": (context) => SingleRecomendation(),
        "/dynamic": (context) => DynamicLinks(),
        "/menu": (context) => Menu(),
        "/location": (context) => PointerLocation(),
        "/pro_account": (context) => ProPurchase(),
        "/adds": (context) => Adds(),
        "/map": (context) => Map(),
        "/service": (context) => ChoosePayment(),
        "/history": (context) => History(),
        "/date": (context) => Date(),
        "/payme": (context) => PaymePay(),
        "/code-verification": (context) => CodeVerification(),
        "/track-user": (context) => TrackUser(),
        "/store-cards":(context) => StoreCards(),
        "/update-run" :(context) => UpdateRun()
      },
    );
  }
}
