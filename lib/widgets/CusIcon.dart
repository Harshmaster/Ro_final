import 'package:flutter/material.dart';

class CusIcon extends StatelessWidget {
  final String imgLink;

  CusIcon({this.imgLink});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 2,
      child: Container(
        margin: EdgeInsets.all(0),
        height: 80,
        width: 80, 
        child: Image.network(
          imgLink,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
