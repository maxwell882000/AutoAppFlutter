import 'package:flutter/material.dart';
import 'package:flutter_projects/Singleton/SingletonUserInformation.dart';
import 'package:flutter_projects/helper_clesses/AnimatedContainerBorder.dart';
import 'package:flutter_projects/helper_clesses/InsideOfAccount/CardsImages.dart';
import 'package:flutter_projects/helper_clesses/InsideOfAccount/MainMenu.dart';
import 'package:flutter_projects/helper_clesses/ListExpenses.dart';
import 'package:flutter_projects/helper_clesses/TextFlexible.dart';
import 'package:flutter_projects/models/visibility.dart';
import 'package:flutter_projects/provider/ErrorMessageProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StoreCards extends StatefulWidget {
  const StoreCards({Key key}) : super(key: key);

  @override
  _StoreCardsState createState() => _StoreCardsState();
}

class _StoreCardsState extends State<StoreCards> {
  List<Widget> imagesChosen = [];
  final f = new DateFormat.yMd().add_Hm();

  Widget textStart(
      {String mainText = "", String secondaryText = "", String svg}) {
    return AnimatedContainerBorder(
      duration: 600,
      margin: EdgeInsets.only(bottom: Get.width * 0.04),
      child: Container(
        margin: EdgeInsets.all(Get.width * 0.03),
        child: Row(
          children: [
            SvgPicture.asset(
              svg,
              width: Get.width * 0.05,
            ),
            SizedBox(
              width: Get.width * 0.02,
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      mainText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: HexColor("#42424A"),
                          fontFamily: 'Montserrat',
                          fontSize: Get.width * 0.03),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      secondaryText,
                      style: TextStyle(
                          color: HexColor("#42424A"),
                          fontFamily: "Roboto",
                          fontSize: Get.width * 0.03),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    List image = SingletonUserInformation().newCard.attach.image;
    if (image.isNotEmpty)
      image.forEach((element) {
        imagesChosen.add(CardsImages(
          unique: element,
        ));
      });
  }

  Widget imagesAttach() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: imagesChosen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final result = new ErrorMessageProvider("sa");
        result.itemsFill();
        return result;
      },
      child: MainMenu(
        visible: VisibilityClass(
          filterVisible: false,
          menuVisible: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: Get.width * 0.05),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    textStart(
                        svg: 'assets/calendar.svg',
                        mainText: "Дата на момент замены".tr,
                        secondaryText:
                            f.format(SingletonUserInformation().newCard.date)),
                    textStart(
                        svg: 'assets/car.svg',
                        mainText: "Пробег на момент замены".tr,
                        secondaryText: SingletonUserInformation()
                            .newCard
                            .change
                            .run
                            .toString()),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/location', arguments: true);
                      },
                        child: textStart(
                            svg: 'assets/location.svg',
                            mainText: "Посмотреть отмеченные точки на карте".tr)),
                    SizedBox(
                      height: Get.width * 0.02,
                    ),
                    imagesAttach(),
                    SizedBox(
                      height: Get.width * 0.02,
                    ),
                    ListExpenses(
                      child: SizedBox(),
                    ),
                    textStart(
                        svg: 'assets/speech_bubble.svg',
                        mainText: "Коментарий".tr,
                        secondaryText:
                            SingletonUserInformation().newCard.comments),
                  ],
                )),
          ),
        ),
        nameBar: TextFlexible(
          text: SingletonUserInformation().newCard.nameOfCard,
          numberOfCharacters: 25,
        ),
      ),
    );
  }
}
