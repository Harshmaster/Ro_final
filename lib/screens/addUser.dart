import 'package:ROSystem/screens/addUsers2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddUsers extends StatefulWidget {
  static const routeName = '/add-user';

  @override
  _AddUsersState createState() => _AddUsersState();
}

class _AddUsersState extends State<AddUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pushNamed(AddUser2.routeName, arguments: {});
        },
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 1)),
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'ALL USERS',
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
      body: Container(
        height: 500,
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection("Users").snapshots(),
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
                            Firestore.instance
                                .collection("Users")
                                .document(snapshot
                                    .data.documents[index].data["Mobile"])
                                .delete();
                          },
                        ),
                      ),
                    ],
                    child: Card(
                      margin: EdgeInsets.only(bottom: 20),
                      elevation: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            child: Icon(Icons.person, size: 35),
                          ),
                          Container(
                            child: Text(
                              snapshot.data.documents[index].data["Name"],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
