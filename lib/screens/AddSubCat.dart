import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../models/icon-model.dart';

class AddSubCat extends StatefulWidget {
  static const routeName = '/add-sub-category2';

  @override
  _AddSubCatState createState() => _AddSubCatState();
}

class _AddSubCatState extends State<AddSubCat> {
  List myIconList;
  List<MyIcon> dropList;
  MyIcon catImage;
  List<String> categoryList;

  @override
  void initState() {
    super.initState();
    getCategoryList();
    getIconList();
  }

  getCategoryList() async {
    await Firestore.instance
        .collection('Categories')
        .getDocuments()
        .then((docs) {
      setState(() {
        categoryList = List.generate(docs.documents.length, (index) {
          return docs.documents[index].data["Category Name"];
        });
      });
    });

    for (int i = 0; i < categoryList.length; i++) {
      print(categoryList[i]);
    }
  }

  getIconList() async {
    await Firestore.instance
        .collection('icons')
        .getDocuments()
        .then((QuerySnapshot docs) {
      myIconList = List.generate(docs.documents.length, (index) {
        return docs.documents[index].data['link'];
      });
      createDropList();
    });
  }

  createDropList() async {
    setState(() {
      dropList = List.generate(myIconList.length, (index) {
        return MyIcon(imgLink: myIconList[index]);
      });
    });
  }

  var selectedUser;

  final categoryController = TextEditingController();

  void writeData() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitCircle(
            color: Colors.white,
          );
        });
    await Firestore.instance.collection("SUB CATEGORIE").add({
      "SUB Category Name": categoryController.text,
      "SUB Category_Icon": catImage.imgLink,
    }).whenComplete(() {
      print("KEMCHO");
      categoryController.clear();
    }).catchError((e) {
      print(e);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey, width: 1)),
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'ADD SUB CATEGORY',
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
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(15)),
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
        body: dropList != null
            ? SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(top: 120, left: 40, right: 40),
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter a SUB Category Name"),
                          controller: categoryController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        height: 120,
                        margin: EdgeInsets.only(
                            left: 40, right: 40, top: 20, bottom: 0),
                        padding: EdgeInsets.all(8),
                        child: DropdownButton<MyIcon>(
                          itemHeight: 120,
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
                          hint: Text('Select an icon '),
                          value: selectedUser,
                          onChanged: (MyIcon value) {
                            catImage = value;
                            setState(() {
                              selectedUser = value;
                            });
                          },
                          items: dropList.map(
                            (MyIcon variable) {
                              return DropdownMenuItem<MyIcon>(
                                value: variable,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.all(6),
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      variable.imgLink,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                      categoryList != null
                          ? Container(
                              width: 130,
                              child: Wrap(
                                  spacing: 5,
                                  runSpacing: 10,
                                  children: categoryList.map((variable) {
                                    return FilterChipWidget(variable);
                                  }).toList()),
                            )
                          : Container(),
                      Expanded(
                          child: SizedBox(
                        height: 0,
                      )),
                      Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        width: double.infinity,
                        height: 40,
                        child: RaisedButton(
                          padding: EdgeInsets.all(6),
                          color: Colors.black,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: "ComicNeue-Light",
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          onPressed: () {
                            writeData();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              )
            : SpinKitCircle(
                color: Colors.black,
              ));
  }
}

class FilterChipWidget extends StatefulWidget {
  final String name;
  FilterChipWidget(this.name);
  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.name),
      labelStyle: TextStyle(
        fontSize: 17,
        color: Colors.white,
      ),
      selected: _isSelected,
      backgroundColor: Colors.black,
      onSelected: (isSelected) {
        if (isSelected) {
            
        } 
        else {

        }
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: Colors.amber,
      showCheckmark: false,
    );
  }
}
