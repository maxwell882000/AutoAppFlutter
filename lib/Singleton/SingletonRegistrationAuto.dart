import 'dart:convert';

class SingletonRegistrationAuto {
  List _item = [
    [1,"НАЗВАНИЕ","Выберите название",0],
    [0,"ГОД ПРОИЗВОДСТВА","Выберите год производства","2000", "2001"],
    [0,"ГОД ПРИОБРЕТЕНИЯ","Выберите год приобретения","2000", "2010"],
    [1,"НОМЕР", "Введите номер",0],
    [1,"ПРОБЕГ", "Введите пробег",2],
    [1,"ТЕХ ПАСПОРТ", "Введите тех паспорт",0],
    [0,"КОЛИЧЕСТВО БАКОВ","Выберите количество баков","1", "2"],

  ];
  List _marka = [0,"МАРКА", "Выберите марку"];
  List _additionalTank = [
    ["1",[[0, "ТИП", "Выберите тип", "Бензин", "Газ"]],"ОБЬЕМ",1],
    ["2",[[0, "ТИП", "Выберите тип", "Бензин", "Газ"],[0, "ТИП", "Выберите тип", "Бензин", "Газ"]],"ОБЬЕМ",1],
    ["Бензин",[[0,"ОБЬЕМ","Выберите обьем","10","20","30"]],"",2],
    ["Газ",[[0,"ОБЬЕМ","Выберите обьем","10","20","30"]],"",2],
  ];

  static final SingletonRegistrationAuto _instance = SingletonRegistrationAuto._internal();
  factory SingletonRegistrationAuto() {
    return _instance;
  }
  List subList(String chosenItem,String nameOfSection){
      List sub = _additionalTank.where((element) => element[0]==chosenItem).map((e) => e).toList();
      return sub.isEmpty?[]:sub[0];
  }
  List get item => _item;
  void setItem(List item){
     _item = item;
  }
  void fromJson(Map<String,dynamic> json){
    List tempAll = [];
    List storeElements = [0,"МОДЕЛЬ","Выберите модель"];
        json.forEach((key, value) =>{
          if (key == "name_of_marka"){
            _marka.add(value)
          }
          else if (key == "model"){
            tempAll.add(_marka.last),
            value.forEach((v)=> {
              storeElements.add(v['name_of_model']),
            }),
            tempAll.add([storeElements])
          }
        });
        tempAll.add("МОДЕЛЬ");
        tempAll.add(1);
        _additionalTank.add(tempAll);
  }
  void finish(){
    _item.insert(1, _marka);
  }
  SingletonRegistrationAuto._internal();
}