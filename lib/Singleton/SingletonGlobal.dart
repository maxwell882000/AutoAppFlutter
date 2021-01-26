class SingletonGlobal {
  Languages language;
  String nameOfTheNextPage;
  static final SingletonGlobal _instance = SingletonGlobal._internal();
  factory SingletonGlobal() {
    return _instance;
  }
  SingletonGlobal._internal();
}

enum Languages {
  EMPTY,
  UZBEK,
  RUSSIAN,
}
