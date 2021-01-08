// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:hexcolor/hexcolor.dart';

// class DropDownItem extends StatefulWidget {
//   final List items;
//   final String russionFlag;
//   final String uzbekFlag;
//   final String hintText;
//   final double width;
//   final double disabledHeight;
//   final double enabledHeight;

//   const DropDownItem(
//       {Key key,
//       this.items,
//       this.russionFlag = "",
//       this.uzbekFlag = "",
//       this.hintText,
//       this.width,
//       this.disabledHeight,
//       this.enabledHeight})
//       : super(key: key);

//   @override
//   _DropDownItemState createState() => _DropDownItemState(
//         items: items,
//         russionFlag: russionFlag,
//         uzbekFlag: uzbekFlag,
//         hintText: hintText,
//         width: width,
//         disabledHeight: disabledHeight,
//         enabledHeight: enabledHeight,
//       );
// }

// class _DropDownItemState extends State<DropDownItem> {
//   // getting from outside
//   final List items;
//   final String russionFlag;
//   final String uzbekFlag;
//   final String hintText;
//   final double width;
//   final double disabledHeight;
//   final double enabledHeight;

//   // inside
//   List connectAll;
//   bool visibility = true;
//   var dropDownWidget;
//   int scrolling = 0;
//   bool pressed = false;
//   String nameOfChoosenItem;

//   //contsturctor
//   _DropDownItemState(
//       {this.items,
//       this.russionFlag = "",
//       this.uzbekFlag = "",
//       this.hintText,
//       this.width,
//       this.disabledHeight,
//       this.enabledHeight});

//   void _updateState(double width, String choosenItem) {
//     setState(() {
//       scrolling++;

//       if (scrolling == 2) {
//         scrolling = 0;
//         visibility = !visibility;
//       }

//       this.nameOfChoosenItem = choosenItem;
//       pressed = !pressed;
//       toGetList();
//       dropDownWidget = connectAll
//           .asMap()
//           .map((i, item) => MapEntry(
//               i,
//               i == 0
//                   ? getChoices(item, width, true)
//                   : item == choosenItem
//                       ? getChoices(item, width, false)
//                       : getChoices(item, width, true)))
//           .values
//           .toList();
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     nameOfChoosenItem = hintText;
//     print("ASDSADSASAASSDS");
//     toGetList();
//     print(connectAll);
//     dropDownWidget = connectAll.map((e) => getChoices(e, width, true));
//   }

//   void toGetList() {
//     var temp1 = [
//       [nameOfChoosenItem],
//       items.map((e) => e).toList(),
//     ];
//     var temp2 = temp1.expand((i) => i).toList();
//     print(temp2);
//     connectAll = temp2;
//   }

//   Widget getChoices(String item, double width, bool visible) {
//     return Visibility(
//       visible: visible,
//       child: TextButton(
//         onPressed: () => _updateState(width, item),
//         style: TextButton.styleFrom(primary: Colors.transparent),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             item == hintText || russionFlag.isEmpty
//                 ? Text(
//                     item,
//                     style: TextStyle(
//                       color: Colors.blue,
//                     ),
//                   )
//                 : Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         item != connectAll[1] ? uzbekFlag : russionFlag,
//                         width: width * 0.05,
//                       ),
//                       SizedBox(
//                         width: width * 0.03,
//                       ),
//                       Text(
//                         item,
//                         style: TextStyle(
//                           color: Colors.blue,
//                         ),
//                       )
//                     ],
//                   ),
//             Visibility(
//               visible: nameOfChoosenItem == item ? true : false,
//               child: SvgPicture.asset(
//                 "assets/arrow_down.svg",
//                 width: width * 0.05,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Stack(
//       children: [
//         AnimationDropDownMenu(
//           pressed: pressed,
//           enabledHeight: enabledHeight,
//           width: width,
//           disabledHeight: disabledHeight,
//           dropDownWidget: dropDownWidget,
//           scrolling: scrolling,
//           visibility: visibility,
//         ),
//         AnimationDropDownMenu(
//           pressed: pressed,
//           enabledHeight: enabledHeight,
//           width: width,
//           disabledHeight: disabledHeight,
//           dropDownWidget: dropDownWidget,
//           scrolling: scrolling,
//           visibility: !visibility,
//         ),
//       ],
//     );
//   }
// }

// class AnimationDropDownMenu extends StatelessWidget {
//   final bool pressed;
//   final double enabledHeight;
//   final double width;
//   final double disabledHeight;
//   final dropDownWidget;
//   final int scrolling;
//   final bool visibility;
//   AnimationDropDownMenu(
//       {Key key,
//       this.pressed,
//       this.enabledHeight,
//       this.width,
//       this.disabledHeight,
//       this.dropDownWidget,
//       this.scrolling,
//       this.visibility})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: visibility,
//       child: AnimatedContainer(
//         curve: Curves.easeInCubic,
//         duration: Duration(milliseconds: pressed ? 1000 : 600),
//         padding: EdgeInsets.zero,
//         margin: EdgeInsets.zero,
//         height: pressed ? enabledHeight : disabledHeight,
//         decoration: BoxDecoration(
//           border: Border.all(color: HexColor("#7FA6C9"), width: 1.2),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: SingleChildScrollView(
//             physics: scrolling == 1
//                 ? AlwaysScrollableScrollPhysics()
//                 : NeverScrollableScrollPhysics(),
//             child: Column(
//               children: dropDownWidget.toList(),
//             )),
//       ),
//     );
//   }
// }

// class ListOfDropDownItemWithText extends StatefulWidget {
//   final List item;
//   final double width;
//   final double disabledHeightOfItem;
//   final double enabledHeightOfItem;
//   final double heightOfDropDownItems;
//   ListOfDropDownItemWithText(
//       {Key key,
//       this.item,
//       this.width,
//       this.disabledHeightOfItem,
//       this.enabledHeightOfItem,
//       this.heightOfDropDownItems,
//       })
//       : super(key: key);

//   @override
//   _ListOfDropDownItemWithTextState createState() =>
//       _ListOfDropDownItemWithTextState(
//         item: item,
//         width: width,
//         disabledHeightOfItem: disabledHeightOfItem,
//         enabledHeightOfItem: enabledHeightOfItem,
//         heightOfDropDownItems:heightOfDropDownItems,
//       );
// }

// class _ListOfDropDownItemWithTextState
//     extends State<ListOfDropDownItemWithText> {
//   final List item;
//   final double width;
//   final double disabledHeightOfItem;
//   final double enabledHeightOfItem;
//     final double heightOfDropDownItems;
//     _ListOfDropDownItemWithTextState(
//       {this.item,
//       this.width,
//       this.disabledHeightOfItem,
//       this.enabledHeightOfItem,
//       this.heightOfDropDownItems,
//       });

//   String hintText;
//   String nameOfTextHelper;
//   List dropDownItem;
//   var rowWithText;
//   List collectionOfPreparedData;
//   @override
//   void initState() {
//     super.initState();
//     collectionOfPreparedData = item.map((value) => prepareData(value)).toList();
//     rowWithText = collectionOfPreparedData
//         .map((value) => getTextWithChoices(value))
//         .toList();
//   }

//   List prepareData(List item) {
//     nameOfTextHelper = item[0];
//     hintText = item[1];
//     dropDownItem = item.sublist(2);
//     return [nameOfTextHelper, hintText, dropDownItem];
//   }

//   Widget getTextWithChoices(List value) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(value[0]),
//             SizedBox(
//               width: width * 0.04,
//             ),
//             Container(
//               width: width * 0.5,
//               child: DropDownItem(
//                 items: value[2],
//                 hintText: value[1],
//                 width: width,
//                 disabledHeight: disabledHeightOfItem,
//                 enabledHeight: enabledHeightOfItem,
//               ),
//             )
//           ],
//         ),
//         SizedBox(
//           height: width * 0.04,
//         ),
//       ],
//     );
//   }

  
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: heightOfDropDownItems,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: rowWithText.toList(),
//         ),
//       ),
//     );
//   }
// }
