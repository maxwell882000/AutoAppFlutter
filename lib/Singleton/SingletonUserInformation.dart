import 'dart:convert';

import 'package:TestApplication/Singleton/SingletonUnits.dart';

import 'SingletonStoreToTheDiskAndLoad.dart';

class SingletonUserInformation {
  String _emailOrPhone;
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
  final Expenses _expenses = new Expenses();
  final Cards  _cards = new Cards();
  static final SingletonUserInformation _instance = SingletonUserInformation._internal();
  String get nameOfTransport => _nameOfTransport;
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
  DateTime get date => _date;
  double get initialRun => _initialRun;
  Expenses get expenses => _expenses;
  Cards get cards => _cards;
  void setInitialRun(double initialRun){
    _initialRun = initialRun;
  }
  void setDate(DateTime date){
    _date = date;
  }
  void setTechPassport(String techPassport){
    _techPassport = techPassport;
  }
  void setRun(double run){
    _run = run;
  }
  void setNameOfTransport(String nameOfTransport){
    _nameOfTransport = nameOfTransport;
  }
  void setEmailOrPhone(String emailOrPhone){
    _emailOrPhone = emailOrPhone;
  }
  void setMarka(String marka){
    _marka = marka;
  }
  void setModel(String model){
    _model = model;
  }
  void setNumber(String number){
    _number = number;
  }
  void setYearOfMade(String yearOfMade){
    _yearOfMade = yearOfMade;
  }
  void setYearOfPurchase(String yearOfPurchase){
    _yearOfPurchase = yearOfPurchase;
  }
  void setNumberOfTank(int numberOfTank){
    _numberOfTank = numberOfTank;
  }
  void setFirstTankVolume(int firstTankVolume){
    _firstTankVolume = firstTankVolume;
  }
  void setFirstTankType(String firstTankType){
    _firstTankType = firstTankType;
  }
  void setSecondTankType(String secondTankType){
    _secondTankType = secondTankType;
  }
  void setSecondTankVolume(int secondTankVolume){
    _secondTankVolume = secondTankVolume;
  }

  factory SingletonUserInformation() {
    return _instance;
  }
  Map<String, dynamic> toJson() => {
    'nameOfTransport': _nameOfTransport,
    'marka': _marka,
    'model': _model,
    'yearOfMade': _yearOfMade,
    'yearOfPurchase': _yearOfPurchase,
    'number': _number,
    'numberOfTank':_numberOfTank,
    'firstTankType': _firstTankType,
    'firstTankVolume': _firstTankVolume,
    'secondTankType': _secondTankType,
    'secondTankVolume': _secondTankVolume,
    'run':SingletonUnits().convertDistanceForDB(_run),
    'tech_passport':_techPassport,
    'expenses': expenses.toJson(),
  };
  void fromJson(Map<String,dynamic> json){
    _nameOfTransport = json['nameOfTransport'];
    _marka = json['marka'];
    _model = json ['model'];
    _yearOfMade = json['yearOfMade'];
    _yearOfPurchase= json['yearOfPurchase'];
    _number       = json['number'];
    _numberOfTank= json['numberOfTank'];
    _firstTankType = json['firstTankType'];
    _firstTankVolume = json['firstTankVolume'];
    _secondTankType = json['secondTankType'];
    _secondTankVolume = json['secondTankVolume'];
    _run = SingletonUnits().convertDistanceForUser(json['run']);
    _techPassport = json['tech_passport'];
    _initialRun =  SingletonUnits().convertDistanceForUser(json['initial_run']);
    expenses.fromJson(json['expenses']);
    cards.fromJson(json['cards_user']);
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

  String tenure (){
    final int year = DateTime.now().year;
    final int yearOfPurchase = int.parse(_yearOfPurchase);
    final int tenure = year - yearOfPurchase;
    return tenure.toString();
  }
  String averageRun(){
   final now = DateTime.now();
   final int days = now.difference(_date).inDays;
   if (days == 0){
     return "0";
   }
   final double differenceRun = run - initialRun;
   final double runKM= SingletonUnits().convertDistanceForDB(differenceRun);
   final double average = SingletonUnits().convertSpeedForUser(runKM, days);
    return average.toString();
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

  Expenses(){
    _allTime = 0;
    _inThisMonth = 0;
  }

  void setAllTime(int allTime){
    _allTime = allTime;
  }
  void setInThisMonth(int inThisMonth){
    _inThisMonth = inThisMonth;
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
  List<Card> _card = [];
  int get id => _id;
  List<Card> get card => _card;

  void fromJson(Map<String, dynamic> json) {
    print("Here cards_user : $json");
    _id = json['id'];
    print("ID OF Cards ${json['card'][0]}");
     json['card'].forEach((e)=>  card.add(new Card(e)));
  }

}
class Card{
   int _id;
   String _nameOfCard;
   DateTime _date;
   String _comments;
   final Attach _attach  = new Attach();
   final Change _change =  new Change();

   Card(int id){
     this._id = id;
   }
   int get id => _id;
   String get nameOfCard => _nameOfCard;
   DateTime get date => _date;
   String get comments => _comments;
   Attach get attach => _attach;
   Change get change => _change;

   void setNameOfCard(String nameOfCard){
     _nameOfCard = nameOfCard;
   }
   void setDate(DateTime date){
     _date = date;
   }
   void setComments(String comments){
     _comments = comments;
   }

}
class Attach{
  int _id;
  String _location;
  List _image;
  List _updatedImage;
  int get id => _id;
  String get location => _location;
  List get image=> _image;
  List get updatedImage => _updatedImage;

  void setLocation(String location){
    _location = location;
  }
}

class Change{
  int _id;
  double _run;
  DateTime _time;
  int get id => _id;
  double get run => _run;
  DateTime get time => _time;

  void setRun(double run){
    _run = run;
  }
  void setDateTime(DateTime time){
    _time = time;
  }
}