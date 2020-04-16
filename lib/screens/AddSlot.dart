import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddSlot extends StatefulWidget {
  static const routeName = '/add-slot';
  @override
  _AddSlotState createState() => _AddSlotState();
}

class _AddSlotState extends State<AddSlot> {
  final nameController = TextEditingController();
  String selectedToTime;
  String selectedFromTime;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    );

    if (picked != null && picked != _date) {
      print('Date Selected: ${picked.toIso8601String()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      print('Date Selected: ${picked.toString()}');
      setState(() {
        selectedToTime = picked.format(context);
      });
    }
  }

  Future<Null> _selectFromTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      print('Date Selected: ${picked.toString()}');
      setState(() {
        selectedFromTime = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 1)),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'ADD SLOT',
            style: TextStyle(
              fontSize: 27,
              color: Colors.black,
              fontFamily: "ComicNeue-Light",
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
                color: Colors.black,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 70,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'SLOT NAME',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w900,
                          fontSize: 23,
                          fontFamily: "ComicNeue-Light",
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 20,
                    bottom: 20,
                  ),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _selectTime(context);
                        },
                        child: Container(
                          child: Column(children: <Widget>[
                            Text('TIME TO',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                )),
                            selectedToTime !=null ? Text(selectedToTime.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )): Text('SELECT',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ))
                          ]),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _selectFromTime(context);
                        },
                        child: Container(
                          child: Column(children: <Widget>[
                            Text('TIME FROM',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                )),
                            selectedFromTime!= null ? Text(selectedFromTime.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                )): Text('SELECT',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ))
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                    color: Colors.black,
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SpinKitCircle(
                              color: Colors.white,
                            );
                          });
                      await Firestore.instance.collection('slot').add({
                        "slot_name": nameController.text,
                        "time_to": selectedToTime,
                        "time_from": selectedFromTime,
                      });
                      print('DONE');
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ]),
        ),
      ),
    );
  }
}
