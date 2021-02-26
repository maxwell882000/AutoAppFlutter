import 'package:TestApplication/HelperClasses/InsideOfAccount/Indicator.dart';
import 'package:TestApplication/Pages/Inside/User.dart';
import 'package:TestApplication/Provider/UserProvider.dart';
import 'package:TestApplication/Singleton/SingletonRecomendation.dart';
import 'package:TestApplication/Singleton/SingletonUserInformation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../LoadingScreen.dart';

class ListOfIndicator extends StatefulWidget {
  ListOfIndicator({Key key}) : super(key: key);

  @override
  _ListOfIndicatorState createState() => _ListOfIndicatorState();
}

class _ListOfIndicatorState extends State<ListOfIndicator> {
  List indicators;

  _ListOfIndicatorState({this.indicators});

  List<Widget> allIndicators = [];
  UserProvider provider;

  @override
  void initState() {
    super.initState();

    SingletonUserInformation().cards.loadCards().then((value) => {
          if (mounted) {loadCards()}
        });
  }

  void loadCards() {
    setState(() {

      provider = Provider.of<UserProvider>(context, listen: false);
      provider.setChangeDetails(0);
      provider.setIndicators(SingletonUserInformation().indicators());
      provider.setAverageRun(SingletonUserInformation().average);
      if (provider.indicators.isNotEmpty)
        allIndicators = provider.indicators.map((indicator) {
          double handle = indicator[1];
          int detail = provider.changeDetail;
          provider.setChangeDetails(handle > 0.8 ? 1 + detail : detail);
          return getIndicators(indicator);
        }).toList();
      provider.setLoading(false);
    });
  }

  Widget getIndicators(List indicator) {
    return Indicator(
        key: UniqueKey(),
        textOfIndicator: indicator[0],
        dataPercent: indicator[1],
        dataTime: indicator[2],
        dataDistance: indicator[3],
        id: indicator[4]);
  }

  void _delete(UserProvider provider) {
    if (provider.deletedIndicators.isNotEmpty) {

      List deleting = [];
      provider.deletedIndicators.forEach((el) {
        provider.indicators
            .where((element) => element[4] == el)
            .forEach((element) {
          deleting.add(element);
        });
      });

      deleting.forEach((element) {
        int index = provider.indicators.indexOf(element);
        allIndicators.removeAt(index);
        SingletonUserInformation().cards.card.removeWhere((elem) => elem.id==element[4]);
        provider.indicators.remove(element);
        WidgetsBinding.instance
            .addPostFrameCallback((_) {
              provider.setClean();
            });

      });
    }
  }
  void sortChange(UserProvider provider){
    allIndicators.clear();
    provider.indicators.sort((b, a) => a[1].compareTo(b[1]));
    allIndicators = provider.indicators
        .map((element) => getIndicators(element))
        .toList();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => provider.setSortChange(false));
  }
  void sortRecent(UserProvider provider){
    allIndicators.clear();

    int sMonth;
    int index;
    List zet = provider.indicators;
    for(int i = 0; i< zet.length; i++){

      index = i;
      for(int k = i+1; k <zet.length;k++){

        int year =  zet[index][5].year - zet[k][5].year;
        int month = zet[index][5].month - zet[k][5].month;
        int day = zet[index][5].day - zet[k][5].day ;
        int hour  =zet[index][5].hour - zet[k][5].hour;
        int minute = zet[index][5].minute - zet[k][5].minute;
        int sec =zet[index][5].second - zet[k][5].second;
        int ans = year != 0?year:month != 0?month:
        day != 0? day:hour !=0 ?hour:minute!=0?minute:sec;

        if(ans<0) {
          index = k;
        }
      }

      if(i!=index) {

        List temp = zet[i];
        zet[i] = zet[index];
        zet[index] = temp;
      }
    }
    allIndicators = zet
        .map((element) => getIndicators(element))
        .toList();
    WidgetsBinding.instance
        .addPostFrameCallback((_){
      provider.setSortRecent(false);});
  }
  void sortUser(UserProvider provider){
    List own = [];
    List def = [];
    provider.indicators.forEach((element) {
      if(SingletonRecomendation().checkRecomm(element[0]) == 1){


        def.add(element);
      }
      else{
        own.add(element);
      }
    });
    own.addAll(def);

    allIndicators = own
        .map((element) => getIndicators(element))
        .toList();
    WidgetsBinding.instance
        .addPostFrameCallback((_){
      provider.setSortOfUser(false);});
  }
  void changed(UserProvider provider){
    int count = 0;
    allIndicators = provider.indicators.map((indicator) {
      double handle = indicator[1];
      count = handle > 0.8 ? 1 + count : count;
      return getIndicators(indicator);
    }).toList();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      provider.setChangeDetails(count);
      provider.setLoading(false);
      provider.setChanged(false);});
  }
  void _modified(UserProvider provider) {
    if (provider.indicators.isNotEmpty) {
      _delete(provider);
      if (provider.sortChange) {
          sortChange(provider);
      } else if (provider.sortRecent) {
        sortRecent(provider);
      } else if (provider.sortOfUser) {
       sortUser(provider);
      }
    }
    if (provider.changed) {
      changed(provider);
    }
  }

  @override

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final provider = Provider.of<UserProvider>(context);
    if (provider != null) {
      _modified(provider);
    }

    return Stack(
      children: [
        Center(
          child: Align(
            alignment: Alignment.center,
            child: LoadingScreen(
              visible: provider.loading,
            ),
          ),
        ),
        Visibility(
          visible: !provider.loading,
          child: Container(
            width: double.infinity,
            height: width * 1.05,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: allIndicators.toList(),
              ),
            ),
          ),
        )
      ],
    );
  }
}
