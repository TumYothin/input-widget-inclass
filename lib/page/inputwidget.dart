import 'package:flutter/material.dart';
import 'package:flutter_input_widget/model/drink.dart';
import 'package:flutter_input_widget/model/food.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String? groupfood;
  List<Food>? foods;
  List<ListItem> types = ListItem.getItem();
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItem;
  late ListItem _selectedTypeItem;

  List checkedDrink = [];
  List<Drink>? drinks;

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    drinks = Drink.getDrink();

    _dropdownMenuItem = createDropdownMenuItem(types);
    _selectedTypeItem = _dropdownMenuItem[0].value!;
  }

  List<DropdownMenuItem<ListItem>> createDropdownMenuItem(
      List<ListItem> types) {
    List<DropdownMenuItem<ListItem>> items = [];

    for (var item in types) {
      items.add(DropdownMenuItem(
        child: Text(item.name!),
        value: item,
      ));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Widget'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Form(
                  child: Column(
                    children: [
                      usernameTextFormField(),
                      passwordTextFormField(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'FOOD',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      line(),
                      const SizedBox(height: 16),
                      Column(
                        children: createRadioFood(),
                      ),
                      Text('Radio Selected:  ${groupfood}'),
                      line(),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: createCheckboxDrink(),
                        ),
                      ),
                      Text('Radio Selected:  $checkedDrink'),
                      line(),
                      const SizedBox(height: 16),
                      DropdownButton(
                        value: _selectedTypeItem,
                        items: _dropdownMenuItem,
                        onChanged: (ListItem? value) {
                          setState(() {
                            _selectedTypeItem = value!;
                          });
                        },
                      ),
                      Text('Dropdown selected: ${_selectedTypeItem.name}'),
                      SubmitButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget SubmitButton() {
    return Container(
      // width: 150,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            //ถ้ามีการกรอกข้อความมาให้เเสดงอะไร
            print(_username.text);
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Widget usernameTextFormField() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _username,
        validator: (Value) {
          if (Value!.isEmpty) {
            return "Please Enter Username";
            //ถ้ากรอกเเล้วไม่ผ่าน
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Username',
          prefixIcon:
              Icon(Icons.person), //prefixIcon ไอคอนจะมาอยู่กล่องข้างในด้วย
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)), //ใส่ขอบกลม
          ), //จะมีเส้นขอบขึ้นมา
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: TextFormField(
        controller: _password,
        obscureText: true,
        validator: (Value) {
          if (Value!.isEmpty) {
            return "Please Enter Password";
            //ถ้ากรอกเเล้วไม่ผ่าน
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(
              Icons.vpn_key_sharp), //prefixIcon ไอคอนจะมาอยู่กล่องข้างในด้วย
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32)), //ใส่ขอบกลม
          ), //จะมีเส้นขอบขึ้นมา
        ),
      ),
    );
  }

  List<Widget> createRadioFood() {
    List<Widget> listFood = [];

    for (var food in foods!) {
      listFood.add(
        RadioListTile<dynamic>(
            title: Text(food.thname!),
            subtitle: Text(food.enname!),
            secondary: Text('${food.price} บาท'),
            value: food.foodvalue,
            groupValue: groupfood,
            onChanged: (value) {
              setState(() {
                groupfood = value;
              });
            }),
      );
    }
    return listFood;
  }

  List<Widget> createCheckboxDrink() {
    List<Widget> listDrink = [];
    for (var drink in drinks!) {
      listDrink.add(CheckboxListTile(
        value: drink.checked,
        title: Text(drink.thname!),
        subtitle: Text('${drink.price!.toString()} บาท'),
        onChanged: (value) {
          setState(() {
            drink.checked = value;
          });

          if (value!) {
            checkedDrink.add(drink.thname);
          } else {
            checkedDrink.remove(drink.thname);
          }
        },
      ));
    }
    return listDrink;
  }
}

class _dropdownMenuItem {}

class ListItem {
  int? value;
  String? name;

  //Contructor
  ListItem(this.value, this.name);

  static getItem() {
    return [
      ListItem(1, 'ข้าวคะน้าหมูกรอบไข่ดาว'),
      ListItem(2, 'ต้มยำกุ้งน้ำข้น'),
      ListItem(3, 'ก๋วยเตี่ยวต้มย่ำ')
    ];
  }
}

Widget line() => Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Divider(color: Colors.grey.shade600, thickness: 2),
          )),
        ],
      ),
    );
