import 'package:ROSystem/screens/AddSlot.dart';
import 'package:ROSystem/screens/addBusinessType.dart';
import 'package:ROSystem/screens/addBusinessTypes2.dart';
import 'package:ROSystem/screens/addUser.dart';
import 'package:ROSystem/screens/addUsers2.dart';
import 'package:ROSystem/screens/add_category.dart';
import 'package:ROSystem/screens/add_category2.dart';
import 'package:flutter/material.dart';
import './screens/home_Categories.dart';
import './screens/add_icons.dart';
import './screens/add_icons2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        MyHomePage.routeName: (ctx) => MyHomePage(),
        AddIcon.routeName: (ctx) => AddIcon(),
        AddIcon2.routeName: (ctx) => AddIcon2(),
        AddCategories.routeName: (ctx) => AddCategories(),
        AddCategory2.routeName: (ctx) => AddCategory2(),
        AddUsers.routeName: (ctx) => AddUsers(),
        AddUser2.routeName: (ctx) => AddUser2(),
        AddBusinessTypes2.routeName: (ctx) => AddBusinessTypes2(),
        AddBusinessType.routeName: (ctx) => AddBusinessType(),
        AddSlot.routeName:(ctx) => AddSlot(), 
      },
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
