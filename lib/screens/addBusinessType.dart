import 'package:ROSystem/screens/addBusinessTypes2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddBusinessType extends StatefulWidget {
  static const routeName = '/add-business-type';

  @override
  _AddBusinessTypeState createState() => _AddBusinessTypeState();
}

class _AddBusinessTypeState extends State<AddBusinessType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add_to_photos,
          size: 28,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context)
              .pushNamed(AddBusinessTypes2.routeName, arguments: {});
        },
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'BUSINESS',
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
          stream: Firestore.instance.collection("Business Types").snapshots(),
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
                                        .collection("Business Types")
                                        .document(snapshot.data.documents[index]
                                            .data["id"])
                                        .delete();
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
                                snapshot.data.documents[index]
                                    .data["BusinessType_Icon"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            snapshot.data.documents[index]
                                .data["BusinessType Name"],
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
