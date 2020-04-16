import 'package:ROSystem/models/bTypeModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './addUser.dart';

class AddUser2 extends StatefulWidget {
  static const routeName = '/add-user2';

  @override
  _AddUser2State createState() => _AddUser2State();
}

class _AddUser2State extends State<AddUser2> {
  var selectedUser;
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final salaryController = TextEditingController();
  final monthoffController = TextEditingController();
  final emailController = TextEditingController();
  List<BType> bTypeNames;
  BType businessType;

  void writeData() async {
    showDialog(
        context: (context),
        builder: (context) {
          return SpinKitCircle(
            color: Colors.blue,
          );
        });
    await Firestore.instance.collection("Users").add({
      "Name": nameController.text,
      "Mobile": mobileController.text,
      "Monthly Salary": salaryController.text,
      "Monthoff": monthoffController.text,
      "Email": emailController.text,
      "Business Type": businessType.name,
    }).whenComplete(() {
      print("KEMCHO");
      nameController.clear();
      mobileController.clear();
      salaryController.clear();
      monthoffController.clear();
    }).catchError((e) {
      print(e);
    });

    Navigator.of(context).pushNamed(
      AddUsers.routeName,
    );
  }

  @override
  void initState() {
    super.initState();
    getBusinessTypes();
  }

  getBusinessTypes() async {
    Firestore.instance
        .collection('Business Types')
        .getDocuments()
        .then((QuerySnapshot docs) {
      setState(() {
        bTypeNames = List.generate(docs.documents.length, (index) {
          return BType(
            name: docs.documents[index].data["BusinessType Name"].toString(),
            imgLink: docs.documents[index].data["BusinessType_Icon"].toString(),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 27,
                      child: Icon(
                        Icons.supervised_user_circle,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    SizedBox(
                        width: ((MediaQuery.of(context).size.width - 92) / 2) -
                            28),
                    Container(
                      width: 92,
                      child: Text(
                        'Add User',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontFamily: "ComicNeue-Light",
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )),
            elevation: 0,
            backgroundColor: Colors.grey[200],
            automaticallyImplyLeading: false),
        body: bTypeNames != null
            ? Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ComicNeue-Light",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                              size: 25,
                            ),

                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            // filled: true,
                            // fillColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontFamily: "ComicNeue-Light",
                              fontSize: 24,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: 'Name',
                          ),
                          controller: nameController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ComicNeue-Light",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.phone, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            // filled: true,
                            // fillColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontFamily: "ComicNeue-Light",
                              fontSize: 24,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: 'Mobile',
                          ),
                          keyboardType: TextInputType.number,
                          controller: mobileController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ComicNeue-Light",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.email, color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            // filled: true,
                            // fillColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontFamily: "ComicNeue-Light",
                              fontSize: 24,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: 'Email',
                          ),
                          keyboardType: TextInputType.text,
                          controller: emailController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ComicNeue-Light",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.monetization_on,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            // filled: true,
                            // fillColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontFamily: "ComicNeue-Light",
                              fontSize: 24,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: 'Monthly Salary',
                          ),
                          keyboardType: TextInputType.number,
                          controller: salaryController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "ComicNeue-Light",
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.hotel,
                              color: Colors.black,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.blueGrey,
                                  width: 2,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )),
                            // filled: true,
                            // fillColor: Colors.amber,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              fontFamily: "ComicNeue-Light",
                              fontSize: 24,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            labelText: 'Monthly Off',
                          ),
                          keyboardType: TextInputType.text,
                          controller: monthoffController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 20),
                        padding: EdgeInsets.all(8),
                        child: DropdownButton<BType>(
                          itemHeight: 80, 
                          isExpanded: true,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 30,
                          underline: Container(
                            color: Colors.white,
                          ),
                          style: TextStyle(
                              color: Color.fromRGBO(82, 90, 101, 1),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          hint: Text(
                            'Select business types',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                fontFamily: "ComicNeue-Light",
                                color: Colors.grey),
                          ),
                          value: selectedUser,
                          onChanged: (BType value) {
                            setState(() {
                              selectedUser = value;
                              businessType = value;
                            });
                          },
                          items: bTypeNames.map(
                            (BType variable) {
                              return DropdownMenuItem<BType>(
                                value: variable,
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(3),
                                        margin: EdgeInsets.only(bottom: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            variable.imgLink,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width: 50,
                                        height: 50,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        variable.name,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      // Multi(bTypeList:bTypeNames),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: 100,
                        height: 40,
                        child: RaisedButton(
                          padding: EdgeInsets.all(6),
                          color: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'ADD',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            writeData();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : SpinKitCircle(
                color: Colors.blue,
              ));
  }
}
