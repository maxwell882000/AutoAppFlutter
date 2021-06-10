class Subscribe {
  final int id;

  final String nameSubscribe;
  final int price;
  final int duration;
  TypeOfPayment type;

  Subscribe(
      {this.id, this.nameSubscribe, this.price, this.duration, int type}) {
    this.type = TypeOfPayment.values[type];
  }
}

enum TypeOfPayment { ONE_TIME, SUBSCRIBE }
