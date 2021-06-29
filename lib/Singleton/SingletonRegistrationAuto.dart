import 'dart:convert';
import 'package:get/get.dart';

class SingletonRegistrationAuto {
  List _item = [
    [1, "НАЗВАНИЕ".tr, "Выберите название".tr, 0],
    [2, "ГОД ПРОИЗВОДСТВА".tr, "Выберите год производства".tr],
    [2, "ГОД ПРИОБРЕТЕНИЯ".tr, "Выберите год приобретения".tr],
    [1, "НОМЕР".tr, "Введите номер".tr, 0],
    [1, "ПРОБЕГ".tr, "Введите пробег".tr, 2],
    [1, "ПРОБЕГ ВО ВРЕМЯ ПРИОБРЕТЕНИЯ".tr, "Введите пробег".tr, 2],
    [1, "ТЕХ ПАСПОРТ".tr, "Введите тех паспорт".tr, 0],
    [0, "ВИД МАШИНЫ".tr, "Выберите тип машины".tr, "Механика".tr, "Автомат".tr],
    [0, "КОЛИЧЕСТВО БАКОВ".tr, "Выберите количество баков".tr, "1", "2"],
  ];

  List _marka = [0, "МАРКА".tr, "Выберите марку".tr];
  List _additionalTank = [
    [
      "1",
      [
        [0, "ТИП".tr, "Выберите тип".tr, "Бензин".tr, "Газ".tr]
      ],
      "ОБЬЕМ".tr,
      1
    ],
    [
      "2",
      [
        [0, "ТИП 1го бака".tr, "Выберите тип".tr, "Бензин".tr, "Газ".tr],
        [0, "ТИП 2го бака".tr, "Выберите тип".tr, "Бензин".tr, "Газ".tr]
      ],
      "ОБЬЕМ".tr,
      1
    ],
    [
      "Бензин".tr,
      [
        [1, "ОБЬЕМ".tr, "Введите обьем".tr, 1]
      ],
      "",
      2
    ],
    [
      "Газ".tr,
      [
        [1, "ОБЬЕМ".tr, "Введите обьем".tr, 1]
      ],
      "",
      2
    ],
  ];

  static final SingletonRegistrationAuto _instance =
      SingletonRegistrationAuto._internal();

  factory SingletonRegistrationAuto() {
    return _instance;
  }

  void clean() {
    _item = [
      [1, "НАЗВАНИЕ".tr, "Выберите название".tr, 0],
      [2, "ГОД ПРОИЗВОДСТВА".tr, "Выберите год производства".tr],
      [2, "ГОД ПРИОБРЕТЕНИЯ".tr, "Выберите год приобретения".tr],
      [1, "НОМЕР".tr, "Введите номер".tr, 0],
      [1, "ПРОБЕГ".tr, "Введите пробег".tr, 2],
      [1, "ПРОБЕГ ВО ВРЕМЯ ПРИОБРЕТЕНИЯ".tr, "Введите пробег".tr, 2],
      [1, "ТЕХ ПАСПОРТ".tr, "Введите тех паспорт".tr, 0],
      [0, "ВИД МАШИНЫ".tr, "Выберите тип машины".tr, "Механика".tr, "Автомат".tr],
      [0, "КОЛИЧЕСТВО БАКОВ".tr, "Выберите количество баков".tr, "1", "2"],
    ];
    _marka = [0, "МАРКА".tr, "Выберите марку".tr];
    _additionalTank = [
      [
        "1",
        [
          [0, "ТИП".tr, "Выберите тип".tr, "Бензин".tr, "Газ".tr]
        ],
        "ОБЬЕМ".tr,
        1
      ],
      [
        "2",
        [
          [0, "ТИП 1го бака".tr, "Выберите тип".tr, "Бензин".tr, "Газ".tr],
          [0, "ТИП 2го бака".tr, "Выберите тип".tr, "Бензин".tr, "Газ".tr]
        ],
        "ОБЬЕМ".tr,
        1
      ],
      [
        "Бензин".tr,
        [
          [1, "ОБЬЕМ".tr, "Введите обьем".tr, 1]
        ],
        "",
        2
      ],
      [
        "Газ".tr,
        [
          [1, "ОБЬЕМ".tr, "Введите обьем".tr, 1]
        ],
        "",
        2
      ],
    ];
  }

  List subList(String chosenItem, String nameOfSection) {
    List sub = _additionalTank
        .where((element) => element[0] == chosenItem)
        .map((e) => e)
        .toList();
    print(sub);
    return sub.isEmpty ? [] : sub[0];
  }

  List get item => _item;

  void setItem(List item) {
    _item = item;
  }

  void fromJson(Map<String, dynamic> json) {
    List tempAll = [];
    List storeElements = [0, "МОДЕЛЬ".tr, "Выберите модель".tr];
    print(json);
    json.forEach((key, value) => {
          if (key == "name_of_marka")
            {_marka.add(value)}
          else if (key == "model")
            {
              tempAll.add(_marka.last),
              value.forEach((v) => {
                    storeElements.add(v['name_of_model']),
                  }),
              tempAll.add([storeElements])
            }
        });
    tempAll.add("МОДЕЛЬ".tr);
    tempAll.add(1);
    _additionalTank.add(tempAll);
    // _item.insert(1, _marka);
  }

  void finish() {
    _item.insert(1, _marka);
  }

  SingletonRegistrationAuto._internal();
}
