import 'package:ROSystem/screens/AddSlot.dart';
import 'package:ROSystem/screens/addUser.dart';
import 'package:ROSystem/screens/add_category.dart';
import 'package:ROSystem/screens/add_icons.dart';
import 'package:ROSystem/screens/subCategory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './models/home_Category_modal.dart';

Future<List<Category>> getCatList() async {


  List<Category> categoryList;

  return categoryList = [
    Category(
      title: "Icons",
      subTitle: await Firestore.instance
          .collection("stats")
          .document("count")
          .get()
          .then((docs) {
        return docs["icons"];
      }),
      imgLink: 'assets/images/addIcon.png',
      routeAddress: AddIcon.routeName,
    ),
    Category(
      title: 'CATEGORIES',
      subTitle: Firestore.instance
          .collection("stats")
          .document("count")
          .get()
          .then((docs) {
        return docs["icons"];
      }),
      imgLink: 'assets/images/AddCategory.png',
      routeAddress: AddCategories.routeName,
    ),
    Category(
      title: 'SUB CAT.',
      subTitle: Firestore.instance
          .collection("stats")
          .document("count")
          .get()
          .then((docs) {
        return docs["icons"];
      }),
      imgLink: 'assets/images/addSubCategory.jpg',
      routeAddress: SubCategory.routeName,
    ),
    Category(
      title: 'USER',
      subTitle: Firestore.instance
          .collection("stats")
          .document("count")
          .get()
          .then((docs) {
        return docs["icons"];
      }),
      imgLink: 'assets/images/createUser.png',
      routeAddress: AddUsers.routeName,
    ),
    Category(
        title: 'BUSINESS',
        subTitle: Firestore.instance
            .collection("stats")
            .document("count")
            .get()
            .then((docs) {
          return docs["icons"];
        }),
        imgLink: 'assets/images/addBusinessType.png',
        routeAddress: '/add-business-type'),
    Category(
      title: 'PERMISSIONS',
      subTitle: Firestore.instance
          .collection("stats")
          .document("count")
          .get()
          .then((docs) {
        return docs["icons"];
      }),
      imgLink: 'assets/images/userPermission.png',
    ),
    Category(
        title: 'SLOT',
        subTitle: Firestore.instance
            .collection("stats")
            .document("count")
            .get()
            .then((docs) {
          return docs["icons"];
        }),
        imgLink: 'assets/images/Slot.png',
        routeAddress: AddSlot.routeName),
  ];
}
