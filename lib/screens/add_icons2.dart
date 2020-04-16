import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddIcon2 extends StatefulWidget {
  static const routeName = '/add-icon2';

  @override
  _AddIcon2State createState() => _AddIcon2State();
}

class _AddIcon2State extends State<AddIcon2> {
  final nameController = TextEditingController();
  File _image;
  String _uploadedFileURL;
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
            'ADD ICON',
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
          margin: EdgeInsets.only(top: 100),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: _image == null
                    ? InkWell(
                        onTap: getImage,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black,
                          ),
                          height: 200,
                          width: 200,
                          child: Center(
                            child: Text(
                              'Insert Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Image.file(_image, fit: BoxFit.cover),
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue[700],
                        ),
                        height: 200,
                        width: 200,
                      ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: TextField(
                  controller: nameController,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'ICON NAME',
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
              RaisedButton(
                color: Colors.black,
                child: Text(
                  'UPLOAD',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                onPressed: uploadFile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    print("Upload image");
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadFile() async {
    showDialog(
        context: context,
        builder: (context) {
          return SpinKitCircle(
            color: Colors.white,
          );
        });

    String id = Uuid().v4();
    StorageReference storageReference =
        FirebaseStorage.instance.ref().child('icons/$id');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
      });
      Firestore.instance.collection("icons").document(id).setData({
        "link": _uploadedFileURL,
        "id": id,
        "Name": nameController.text,
      });
      print("done");

      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }
}
