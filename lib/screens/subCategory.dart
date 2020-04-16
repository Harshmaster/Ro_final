import 'package:ROSystem/screens/AddSubCat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubCategory extends StatefulWidget {
  static const routeName = '/add-subCategory';  

  @override
  _SubCategoryState createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
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
          stream: Firestore.instance.collection("SUB CATEGORIE").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Container(
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
                                  .data["SUB Category_Icon"],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          snapshot
                              .data.documents[index].data["SUB Category Name"],
                          style: TextStyle(color: Colors.black, fontSize: 23),
                        )
                      ],
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
