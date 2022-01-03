import 'package:flutter/material.dart';
import 'package:flutter_input_widget/model/drink.dart';
import 'package:flutter_input_widget/model/food.dart';

class Inputwidgets extends StatefulWidget {
  const Inputwidgets({Key? key}) : super(key: key);

  @override
  _InputwidgetsState createState() => _InputwidgetsState();
}

class _InputwidgetsState extends State<Inputwidgets> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _pasw = TextEditingController();

  String? groupfood;
  List<Food>? foods;
  List checkDrink = [];
  List<Drink>? drinks;
  List<ListItem>? types = ListItem.getItem();
  late List<DropdownMenuItem<ListItem>> _dropdownMenuItem;
  late ListItem _selectedTypeItem;

  @override
  void initState() {
    super.initState();
    foods = Food.getFood();
    drinks = Drink.getDrink();
    _dropdownMenuItem = createDropdownMenuItem(types!);
    _selectedTypeItem = _dropdownMenuItem[0].value!;

    // print(foods);
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
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Input Widget')),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              usernameTextFormField(),
              passwordTextFormField(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'FOOD',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
              Text('Radio Selected:  $checkDrink'),
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
      ),
    );
  }

  Center dropdown() {
    return Center(
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
          child: DropdownButton(
            items: _dropdownMenuItem,
            value: _selectedTypeItem,
            onChanged: (ListItem? value) {
              setState(() {
                _selectedTypeItem = value!;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget SubmitButton() {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(_username.text);
          }
        },
        child: Text('Submit'),
      ),
    );
  }

  Widget usernameTextFormField() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: TextFormField(
          style: TextStyle(color: Colors.purple),
          controller: _username,
          validator: (vaLue) {
            if (vaLue!.isEmpty) {
              return "please enter username";
            }
            return null;
          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              labelText: 'username',
              prefixIcon: Icon(Icons.vpn_key),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32)),
              )),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextFormField(
        obscureText: true,
        obscuringCharacter: '*',
        controller: _pasw,
        validator: (vaLue) {
          if (vaLue!.isEmpty) {
            return "please enter your password";
          }
          return null;
        },
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            )),
      ),
    );
  }

  List<Widget> createRadioFood() {
    List<Widget> listFood = [];

    for (var food in foods!) {
      listFood.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: RadioListTile<dynamic>(
              title: Text(
                food.thname!,
              ),
              subtitle: Text(
                food.enname!,
              ),
              secondary: Text(
                '${food.price} บาท',
              ),
              value: food.foodvalue!,
              groupValue: groupfood,
              onChanged: (value) {
                setState(() {
                  groupfood = value;
                });
              },
            ),
          ),
        ),
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
            checkDrink.add(drink.thname);
          } else {
            checkDrink.remove(drink.thname);
          }
        },
      ));
    }
    return listDrink;
  }
}

class ListItem {
  int? value;
  String? name;

  ListItem(this.value, this.name);

  static getItem() {
    return [
      ListItem(1, 'ข้าวคะน้าหมูกรอบไข่ดาว'),
      ListItem(2, 'ต้มยำกุ้งน้ำข้น'),
      ListItem(3, 'ก๋วยเตี่ยวต้มย่ำ')
    ];
  }

  // void add(DropdownMenuItem dropdownMenuItem) {}
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
