import 'package:ROSystem/screens/AddSubCat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubCategory extends StatefulWidget {
  static const routeName = '/add-subCategory';

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: new Text(value),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_to_photos,
          size: 28,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddSubCat()));
        },
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'SUB CATEGORIES',
          style: TextStyle(
            fontSize: 27,
            color: Colors.black,
            fontFamily: "ComicNeue-Light",
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 26,
            color: Colors.black,
          ),
          color: Colors.black,
        ),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("sub_cat_info").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  List<dynamic> categories =
                      snapshot.data.documents[index].data["categories"];
                  String sub_cat_name =
                      snapshot.data.documents[index].data["sub_category_name"];
                  var id = snapshot.data.documents[index].documentID;
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    secondaryActions: <Widget>[
                      Container(
                        height: 110,
                        width: 60,
                        margin: EdgeInsets.only(
                          top: 12,
                        ),
                        child: IconSlideAction(
                          caption: "Delete",
                          color: Colors.black,
                          icon: Icons.delete,
                          onTap: () async {
                            await Firestore.instance
                                .collection("sub_cat_info")
                                .document(id)
                                .delete();

                            await Firestore.instance
                                .collection("SUB CATEGORIE")
                                .where("sub_category_name",
                                    isEqualTo: sub_cat_name)
                                .getDocuments()
                                .then((docs) {
                              for (int i = 0; i < docs.documents.length; i++) {
                                var docId = docs.documents[i].documentID;
                                Firestore.instance
                                    .collection("SUB CATEGORIE")
                                    .document(docId)
                                    .delete();
                              }
                              print("ALL IS DONE NOW");
                              showInSnackBar("$sub_cat_name DELETED SUCCESSFULLY");
                            });
                          },
                        ),
                      ),
                    ],
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data.documents[index]
                                    .data["sub_category_icon"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                           ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    snapshot.data.documents[index]
                                        .data["sub_category_name"],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 23),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  child: CategoryChip(categories),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return SpinKitCircle(
                color: Colors.black,
              );
            }
          },
        ),
      ),
    );
  }
}

class CategoryChip extends StatefulWidget {
  final List<dynamic> reportList;
  CategoryChip(this.reportList);
  @override
  _CategoryChipState createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  String selectedChoice = "";
  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoice == item,
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Wrap(
        spacing: 4,
        runSpacing: 0,
        children: _buildChoiceList(),
      ),
    );
  }
}
