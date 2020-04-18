import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uuid/uuid.dart';
import '../models/icon-model.dart';

class AddBusinessTypes2 extends StatefulWidget {
  static const routeName = '/add-business-type-2';

  @override
  _AddBusinessTypes2State createState() => _AddBusinessTypes2State();
}

class _AddBusinessTypes2State extends State<AddBusinessTypes2> {
  List myIconList;
  List<MyIcon> dropList;
  MyIcon catImage;

  @override
  void initState() {
    super.initState();
    getIconList();
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

  // List<MyIcon> dropList = [
  //   MyIcon(imgLink: 'hellotheworld'),
  //   MyIcon(imgLink: 'hellotheworld'),
  //   MyIcon(imgLink: 'hellotheworld'),
  //   MyIcon(imgLink: 'hellotheworld'),
  //   MyIcon(imgLink: 'hellotheworld'),
  // ];

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

    var id = Uuid().v4();
    var ref = Firestore.instance.collection("Business Types");
    await ref.document(id).setData({
      "BusinessType Name": categoryController.text,
      "BusinessType_Icon": catImage.imgLink, 
      "id": id,
    });

    Navigator.of(context).pop();
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
              'ADD BUSINESS',
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
                  height: MediaQuery.of(context).size.height - 70,
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
                              hintText: "Enter business Type"),
                          controller: categoryController,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            left: 40, right: 40, top: 20, bottom: 20),
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
                      Expanded(
                        child: SizedBox(
                          height: 0,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: RaisedButton(
                          padding: EdgeInsets.all(6),
                          color: Colors.black,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "ComicNeue-Light"),
                          ),
                          onPressed: () {
                            writeData();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              )
            : SpinKitCircle(
                color: Colors.blue,
              ));
  }
}
