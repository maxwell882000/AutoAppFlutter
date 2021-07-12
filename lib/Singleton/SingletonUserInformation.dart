import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_projects/Singleton/SingletonConnection.dart';
import 'package:flutter_projects/Singleton/SingletonGlobal.dart';
import 'package:flutter_projects/Singleton/SingletonRecomendation.dart';
import 'package:flutter_projects/Singleton/SingletonRegistrationAuto.dart';
import 'package:flutter_projects/helper_clesses/Dialog/ChoiceDialog.dart';
import 'package:flutter_projects/service/fire_base_messaging.dart';

import 'SingletonStoreToTheDiskAndLoad.dart';
import 'package:get/get.dart';
import 'SingletonUnits.dart';

enum TypeOfCar { MECH, AUTO }

class SingletonUserInformation {
  bool _pop = false;
  bool _isAuthorized = false;
  bool _NO_ACCOUNT = false;
  int _id;
  String _emailOrPhone;
  int _userId;
  DateTime _date;
  String _nameOfTransport;
  String _marka;
  String _model;
  String _yearOfMade;
  String _yearOfPurchase;
  int _numberOfTank;
  String _firstTankType;
  int _firstTankVolume;
  String _secondTankType;
  int _secondTankVolume;
  String _number;
  double _run;
  String _techPassport;
  double _initialRun;
  bool _proAccount = false;
  double _average = 0;
  TypeOfCar _typeOfCar = TypeOfCar.MECH;
  final Expenses _expenses = new Expenses();
  final Cards _cards = new Cards();
  CardUser _newCard = new CardUser.newCard();
  static final SingletonUserInformation _instance =
      SingletonUserInformation._internal();

  void cleanTransport() {
    _id = 0;
    _nameOfTransport = "";
    _marka = "";
    _model = "";
    _yearOfMade = "";
    _yearOfPurchase = "";
    _number = "";
    _numberOfTank = 0;
    _firstTankType = "";
    _firstTankVolume = 0;
    _secondTankType = "";
    _secondTankVolume = 0;
    _run = 0;
    _techPassport = "";
    _initialRun = 0;
    _average = 0;
    expenses.clean();
    _newCard.cleanFully();
    _cards.clean();
    _pop = false;
  }

  void clean() {
    _userId = 0;
    cleanTransport();
    _NO_ACCOUNT = false;
    _isAuthorized = false;
    _proAccount = false;
  }

  bool get pop => _pop;

  bool get NO_ACCOUNT => _NO_ACCOUNT;

  int get id => _id;

  int get userId => _userId;

  bool get proAccount => _proAccount;

  CardUser get newCard => _newCard;

  double get average => _average;

  String get nameOfTransport => _nameOfTransport ?? "";

  String get emailOrPhone => _emailOrPhone;

  String get marka => _marka;

  String get model => _model;

  String get yearOfMade => _yearOfMade;

  String get yearOfPurchase => _yearOfPurchase;

  int get numberOfTank => _numberOfTank;

  String get firstTankType => _firstTankType;

  int get firstTankVolume => _firstTankVolume;

  String get secondTankType => _secondTankType;

  int get secondTankVolume => _secondTankVolume;

  String get number => _number;

  double get run => _run;

  String get techPassport => _techPassport;

  DateTime get date => _date ?? "";

  double get initialRun => _initialRun;

  Expenses get expenses => _expenses;

  Cards get cards => _cards;

  bool get isAuthorized => _isAuthorized;

  int getTypeOfCarToBack() {
    return _typeOfCar.index + 1;
  }

  void setTypeOfCarBack(int typeOfCar) {
    if (typeOfCar == 1) {
      _typeOfCar = TypeOfCar.MECH;
    } else if (typeOfCar == 2) {
      _typeOfCar = TypeOfCar.AUTO;
    }
  }

  void setTypeOfCar(String typeOfCar) {
    if (typeOfCar == "Механика".tr) {
      _typeOfCar = TypeOfCar.MECH;
    } else if (typeOfCar == "Автомат".tr) {
      _typeOfCar = TypeOfCar.AUTO;
    }
  }

  void setIsAthorized(bool isAuthorized) {
    _isAuthorized = isAuthorized;
  }

  void setUserId(int id) {
    this._userId = id;
  }

  void setPop(bool pop) {
    _pop = pop;
  }

  void setNOACCOUNT(bool NO_ACCOUNT) {
    _NO_ACCOUNT = NO_ACCOUNT;
  }

  void setProAccount(bool proAccount) {
    _proAccount = proAccount;
  }

  void setId(int id) {
    _id = id;
  }

  void newCardClean() {
    _newCard = CardUser.newCard();
  }

  void setNewCard(int id) {
    _newCard = _cards.card.firstWhere((element) => element.id == id,
        orElse: () =>
            _cards.storeCards.firstWhere((element) => element.id == id));
  }

  void setInitialRun(double initialRun) {
    _initialRun = initialRun;
  }

  void setDate(DateTime date) {
    _date = date;
  }

  void setTechPassport(String techPassport) {
    _techPassport = techPassport;
  }

  void setRun(double run) {
    _run = run;
  }

  void setNameOfTransport(String nameOfTransport) {
    _nameOfTransport = nameOfTransport;
  }

  void setEmailOrPhone(String emailOrPhone) {
    _emailOrPhone = emailOrPhone;
  }

  void setMarka(String marka) {
    _marka = marka;
  }

  void setModel(String model) {
    _model = model;
  }

  void setNumber(String number) {
    _number = number;
  }

  void setYearOfMade(String yearOfMade) {
    _yearOfMade = yearOfMade;
  }

  void setYearOfPurchase(String yearOfPurchase) {
    _yearOfPurchase = yearOfPurchase;
  }

  void setNumberOfTank(int numberOfTank) {
    _numberOfTank = numberOfTank;
  }

  void setFirstTankVolume(int firstTankVolume) {
    _firstTankVolume = firstTankVolume;
  }

  void setFirstTankType(String firstTankType) {
    _firstTankType = firstTankType;
  }

  void setSecondTankType(String secondTankType) {
    _secondTankType = secondTankType;
  }

  void setSecondTankVolume(int secondTankVolume) {
    _secondTankVolume = secondTankVolume;
  }

  List indicators() {
    this.averageRun();
    if (cards.card.isNotEmpty)
      return cards.card.map((element) => createList(element)).toList();
    return [];
  }

  List indicatorsStore() {
    if (cards.storeCards.isNotEmpty)
      return cards.storeCards.map((element) => createList(element)).toList();
    return [];
  }

  void averageRun() {
    final DateTime d = DateTime.parse("2021-02-04 09:45:54.925347Z");
    final now = DateTime.now();

    final dateYear = DateTime(int.parse(yearOfPurchase));
    final int days = now.difference(dateYear).inDays;

    if (days == 0) {
      SingletonUnits().convertSpeedForUser(0, days);
      _average = 0;
      return;
    }

    final double differenceRun = run - initialRun;

    final double runKM = SingletonUnits().convertDistanceForDB(differenceRun);

    _average = SingletonUnits().convertSpeedForUser(runKM, days);

    if (_average == null) {
      _average = 0;
    }
  }

  List createList(CardUser element) {
    if (element.change.run == 0) {
      DateTime now = DateTime.now();
      int days = now.difference(element.date).inDays;
      int current = element.change.time - days;
      current = current < 0 ? 0 : current;
      int time = SingletonUnits()
          .translateTimeFromDays(SingletonUnits().time, current);
      double distance = time * _average;
      double translatedDistance = SingletonUnits()
          .translateDistance(SingletonUnits().distance, distance);
      double done = days > element.change.time.toDouble()
          ? element.change.time
          : days.toDouble();
      double percentage = done / element.change.time.toDouble();
      return [
        element.nameOfCard,
        percentage,
        current,
        _average == 0 ? "незивестно".tr : translatedDistance,
        element.id,
        element.date
      ];
    } else {
      double total = element.change.run - element.change.initialRun;
      double rest = element.change.run - _run;
      double done = _run - element.change.initialRun;
      rest = rest < 0 ? 0 : rest;

      double tranRest = SingletonUnits().convertDistanceForDB(rest);

      double tranRun = SingletonUnits()
          .translateDistance(SingletonUnits().speedDistance, tranRest);
      int time = 0;
      if (_average > 0) time = tranRun ~/ _average;
      int days =
          SingletonUnits().translateTimeToDays(SingletonUnits().time, time);
      done = done > total ? total : done;

      double percantage = done / total;
      if (percantage.isNaN) {
        percantage = 0;
      }
      return [
        element.nameOfCard,
        percantage,
        _average == 0 ? "неизвестно".tr : days.toDouble(),
        rest,
        element.id,
        element.date
      ];
    }
  }

  factory SingletonUserInformation() {
    return _instance;
  }

  Future<bool> LOGOUT() async {
    bool response = await showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (context) => ChoiceDialog(
        text: "Вы уверены что хотите выйти ?".tr,
      ),
    );
    if (response) {
      if (SingletonUserInformation().pop) {
        response = false;
      }
      SingletonGlobal().prefs.remove("user");
      SingletonGlobal().prefs.remove("token");
      FireBaseService().deleteToken();
      SingletonUserInformation().setEmailOrPhone("");
      SingletonUserInformation().clean();
      SingletonRecomendation().clean();
      SingletonRegistrationAuto().clean();
      if (!response) {
        Navigator.of(Get.context).popAndPushNamed("/select");
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'nameOfTransport': _nameOfTransport,
        'marka': _marka,
        'model': _model,
        'yearOfMade': _yearOfMade,
        'yearOfPurchase': _yearOfPurchase,
        'number': _number,
        'numberOfTank': _numberOfTank,
        'firstTankType': _firstTankType,
        'firstTankVolume': _firstTankVolume,
        'secondTankType': _secondTankType,
        'secondTankVolume': _secondTankVolume,
        'run': SingletonUnits().convertDistanceForDB(_run),
        'initial_run': _initialRun != null ? SingletonUnits().convertDistanceForDB(_initialRun) : SingletonUnits().convertDistanceForDB(_run),
        'tech_passport': _techPassport,
        'expenses': expenses.toJson(),
        'type_car': getTypeOfCarToBack(),
      };

  void fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _nameOfTransport = json['nameOfTransport'];
    _marka = json['marka'];
    _model = json['model'];
    _yearOfMade = json['yearOfMade'];
    _yearOfPurchase = json['yearOfPurchase'];
    _number = json['number'];
    _numberOfTank = json['numberOfTank'];
    _firstTankType = json['firstTankType'];
    _firstTankVolume = json['firstTankVolume'];
    _secondTankType = json['secondTankType'];
    _secondTankVolume = json['secondTankVolume'];
    _run = SingletonUnits().convertDistanceForUser(json['run']);
    _techPassport = json['tech_passport'];
    _initialRun = SingletonUnits().convertDistanceForUser(json['initial_run']);
    setTypeOfCarBack(json['type_car']);
    expenses.fromJson(json['expenses']);
    if (json['cards_user'] != null)
      cards.fromJson(json['cards_user']);
    else {
      cards.clean();
    }
  }

  void setToTheDisk() {
    SingletonStoreToTheDiskAndLoad().setToDisk('user', json.encode(toJson()));
  }

  @override
  String toString() {
    return toJson().toString();
  }

  void getFromTheDisk() async {
    String result = await SingletonStoreToTheDiskAndLoad().getFromDisk('user');
    fromJson(json.decode(result));
  }
  int toInt(String date) {
    return date != null && date.isNotEmpty
        ? int.parse(date)
        : 0;
  }
  String tenure() {
    if (!_NO_ACCOUNT) {

      final int year = DateTime.now().year;
      print(_yearOfPurchase);
      final int yearOfPurchase = toInt(_yearOfPurchase);

      print("YEAR OF PURCHASE");
      print(yearOfPurchase);
      print(yearOfMade);
      print(year);
      final int tenure = year - yearOfPurchase;
      if(tenure==0 ){
        return "Меньше года".tr;
      }
      return tenure.toString() +
          " " +
          SingletonUnits().convertYearToString(tenure);
    }
    return "";
  }

  void updateRun() {
    SingletonConnection().updateRunOfUser(id, run);
  }

  SingletonUserInformation._internal();
}

class Expenses {
  int _id;
  int _allTime;
  int _inThisMonth;

  int get id => _id;

  int get all_time => _allTime;

  int get in_this_month => _inThisMonth;

  Expenses() {
    _allTime = 0;
    _inThisMonth = 0;
  }

  void clean() {
    _id = 0;
    _allTime = 0;
    _inThisMonth = 0;
  }

  void setAllTime(int allTime) {
    _allTime = allTime;
  }

  void setInThisMonth(int inThisMonth) {
    _inThisMonth = inThisMonth;
  }

  void setId(int id) {
    _id = id;
  }

  Map<String, dynamic> toJson() => {
        "all_time": all_time,
        "in_this_month": in_this_month,
      };

  void fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _allTime = json['all_time'];
    _inThisMonth = json['in_this_month'];
  }
}

class Cards {
  int _id;
  List<CardUser> _card = [];
  List<CardUser> _storeCards = [];
  int _changeDetails = 0;

  int get id => _id;

  int get changeDetails => _changeDetails;

  void setChangeDetails(int changeDetails) {
    _changeDetails = changeDetails;
  }

  List<CardUser> get card => _card;

  List<CardUser> get storeCards => _storeCards;

  void clean() {
    _id = 0;
    _card = [];
    _changeDetails = 0;
    _storeCards = [];
  }

  void setId(int id) {
    _id = id;
  }

  void fromJson(Map<String, dynamic> json) {
    _id = json['id'];
  }

  Future<void> loadCards() async {
    _card = [];
    await SingletonConnection().getStoreCards("cards/$_id", _card);
  }

  Future<void> loadStoreCards() async {
    _storeCards = [];
    await SingletonConnection().getStoreCards("cards/store/$_id", _storeCards);
  }
}

class CardUser {
  int _id;
  String _nameOfCard;
  DateTime _date;
  DateTime _date_of_change;
  String _comments;
  final Attach _attach = new Attach();
  final Change _change = new Change();
  List<Expense> _expense = [];
  final List<int> _uploadedExpense = [];
  final List<int> _deletedExpense = [];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'name_of_card': nameOfCard,
      'date': date.toString(),
    };
    if (comments.isNotEmpty) {
      json.addAll({'comments': comments});
    }
    return json;
  }

  CardUser.newCard() {
    _date = DateTime.now();
    _comments = "";
    _nameOfCard = "";
  }

  void cleanFully() {
    _id = 0;
    _nameOfCard = "";
    _date = DateTime.now();
    _date_of_change = DateTime.now();
    _comments = "";
    clean();
    _expense = [];
    _attach.cleanFully();
    _change.clean();
  }

  CardUser(
      int id,
      String nameOfCard,
      DateTime date,
      String comments,
      int id_attach,
      int location,
      List image,
      int id_change,
      double run,
      double initialRun,
      int time,
      List expense) {
    this._id = id;
    this._nameOfCard = nameOfCard;
    this._date = date;
    this._comments = comments;
    attach.setId(id_attach);
    attach.setIdLocation(location);
    attach.setImage(image);
    change.setId(id_change);
    change.setRun(run);
    change.setInitialRun(initialRun);
    change.setTime(time);
    if (expense.isNotEmpty) {
      expense.forEach((element) {
        this._expense.add(new Expense(
            element['id'], element['name'], element['sum'], element['amount']));
      });
    }
  }

  List<int> get deletedExpense => _deletedExpense;

  List<int> get uploadedExpense => _uploadedExpense;

  int get id => _id;

  String get nameOfCard => _nameOfCard;

  DateTime get date => _date;

  String get comments => _comments;

  Attach get attach => _attach;

  Change get change => _change;

  List<Expense> get expense => _expense;

  void clean() {
    _uploadedExpense.clear();
  }

  void setExpense(List<Expense> expense) {
    _expense = expense;
  }

  void setId(int id) {
    _id = id;
  }

  void setNameOfCard(String nameOfCard) {
    _nameOfCard = nameOfCard;
  }

  void setDate(DateTime date) {
    _date = date;
  }

  void setComments(String comments) {
    _comments = comments;
  }
}

class Attach {
  int _id;
  Location _location = new Location();
  List _image = [];
  List _updatedImage = [];
  List _uploadedImage = [];

  void cleanFully() {
    _id = 0;
    _location = new Location();
    _image = [];
    clean();
  }

  int get id => _id;

  List get uploadedImage => _uploadedImage;

  Location get location => _location;

  List get image => _image;

  List get updatedImage => _updatedImage;

  void setId(int id) {
    this._id = id;
  }

  void setImage(List image) {
    this._image = image;
  }

  void clean() {
    _uploadedImage = [];
    _updatedImage = [];
  }

  void setIdLocation(int id) {
    _location.setId(id);
  }
}

class Location {
  int _id;
  double _longitude;
  double _latitude;
  String _comment;

  Location.getter(int id) {
    _id = id;
    _longitude = -1;
    _latitude = -1;
    _comment = "";
  }

  Location() {
    _id = 0;
    _longitude = -1;
    _latitude = -1;
    _comment = "";
  }

  int get id => _id;

  double get longitude => _longitude;

  double get latitude => _latitude;

  String get comment => _comment;

  void setId(int id) {
    _id = id;
  }

  void setLongitude(double longitude) {
    _longitude = longitude;
  }

  void setLatitude(double latitude) {
    _latitude = latitude;
  }

  void setComments(String comments) {
    _comment = comments;
  }

  void fromJson(Map<String, dynamic> json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _comment = json['comment'];
  }

  Map<String, dynamic> toJson() =>
      {"latitude": latitude, "longitude": longitude, "comment": comment};
}

class Change {
  int _id;
  double _run;
  int _time;
  double _initialRun;

  int get id => _id;

  double get run => _run;

  int get time => _time;

  double get initialRun => _initialRun;

  void clean() {
    _id = 0;
    _run = 0;
    _time = 0;
    _initialRun = 0;
  }

  void setInitialRun(double initialRun) {
    _initialRun = initialRun;
  }

  void setId(int id) {
    this._id = id;
  }

  void setRun(double run) {
    _run = run;
  }

  void setTime(int time) {
    _time = time;
  }
}

class Expense {
  int _id;
  String _name;
  int _sum;
  int _amount;

  Expense(int id, String name, int sum, int amount) {
    this._id = id;
    this._name = name;
    this._amount = amount;
    this._sum = sum;
  }

  int get id => _id;

  String get name => _name;

  int get sum => _sum;

  int get amount => _amount;

  void setName(String name) {
    this._name = name;
  }

  void setSum(int sum) {
    this._sum = sum;
  }

  void setAmount(int amount) {
    this._amount = amount;
  }
}
