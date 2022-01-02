class Drink {
  String? thname;
  int? price;
  bool? checked;

  Drink(this.thname, this.price, this.checked);

  static getDrink() {
    return [
      Drink('ชาเย็น', 30, true),
      Drink('กาเเฟ', 20, true),
      Drink('ชาเขียน', 20, true),
    ];
  }
}
