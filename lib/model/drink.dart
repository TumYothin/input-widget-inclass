class Drink {
  String? thname;
  int? price;
  bool? checked;

  Drink(this.thname, this.price, this.checked);

  static getDrink() {
    return [
      Drink('ชาเย็น', 30, false),
      Drink('กาเเฟ', 20, false),
      Drink('ชาเขียว', 20, false),
    ];
  }
}
