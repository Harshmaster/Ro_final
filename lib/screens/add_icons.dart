import 'package:ROSystem/screens/add_icons2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddIcon extends StatefulWidget {
  static const routeName = '/add-icon';

  @override
  _AddIconState createState() => _AddIconState();
}

class _AddIconState extends State<AddIcon> {
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
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) => AddIcon2()));
        },
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'ICONS',
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
          stream: Firestore.instance.collection("icons").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
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
                            print("HELLO");
                            await Firestore.instance
                                .collection("icons")
                                .document(
                                    snapshot.data.documents[index].data["id"])
                                .delete();
                            print("AGAIN HELLO");

                            showInSnackBar(
                                "${snapshot.data.documents[index].data["Name"]} DELETED SUCCESSFULLY");
                          },
                        ),
                      ),
                    ],
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                snapshot.data.documents[index].data["link"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            snapshot.data.documents[index].data["Name"],
                            style: TextStyle(color: Colors.black, fontSize: 23),
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
