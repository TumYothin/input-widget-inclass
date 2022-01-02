class Food {
  String? thname;
  String? enname;
  int? price;
  String? foodvalue;

  Food(this.thname, this.enname, this.price, this.foodvalue);

  static getFood() {
    return [
      Food('Pizza', 'พิซซ่า', 99, 'Pizza'),
      Food('Steak', 'สเต็ก', 129, 'Steak'),
      Food('Shabu', 'ชาบู', 399, 'Shabu'),
    ];
  }
}
