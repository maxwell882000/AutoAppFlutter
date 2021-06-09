class Subscribe {
  final int id;

  final String nameSubscribe;
  final int price;
  final int duration;
  TypeOfPayment type;

  Subscribe(
      {this.id, this.nameSubscribe, this.price, this.duration, int type}) {
    this.type = type == 1 ? TypeOfPayment.ONE_TIME : TypeOfPayment.SUBSCRIBE;
  }
}

enum TypeOfPayment { ONE_TIME, SUBSCRIBE }
