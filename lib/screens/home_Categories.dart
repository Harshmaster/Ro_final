import 'package:ROSystem/screens/AddSlot.dart';
import 'package:ROSystem/screens/addUser.dart';
import 'package:ROSystem/screens/add_category.dart';
import 'package:ROSystem/screens/add_icons.dart';
import 'package:ROSystem/screens/subCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-category-screen';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int icons = 0;
  int categories = 0;
  int business = 0;
  int users = 0;
  int slots = 0;
  int subCats = 0;

  getStats() async {
    await Firestore.instance
        .collection("stats")
        .document("count")
        .get()
        .then((value) {
      setState(() {
        icons = value["icons"];
        categories = value["categories"];
        business = value["business"];
        users = value["users"];
        slots = value["slots"];
        subCats = value["sub_cat"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getStats();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print((3 / 3.33) * MediaQuery.of(context).size.width);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey, width: 1)),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'ADMIN',
          style: TextStyle(
            fontSize: 27,
            color: Colors.black,
            fontFamily: "ComicNeue-Light",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(
              top: 7,
              bottom: 7,
            ),
            color: Colors.grey,
            width: 3,
          ),
          SizedBox(
            width: 1,
          ),
          Container(
            margin: EdgeInsets.only(
              right: 8,
            ),
            child: IconButton(
              icon: Icon(
                Icons.power_settings_new,
                size: 36,
              ),
              color: Colors.black,
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: 0,
          right: 0,
          top: 0,
        ),
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 3),
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddIcon.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/addIcon.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "ICONS",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$icons Icons',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddCategories.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/AddCategory.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "CATEGORIES",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$categories Categories',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SubCategory.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/addSubCategory.jpg',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "SUB CAT.",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$subCats SUB CATS',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 3),
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddUsers.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/createUser.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "USER",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$users Users',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddCategories.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/addBusinessType.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "BUSINESS",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$business Business',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, SubCategory.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/userPermission.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "PERMISSIONS",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(height: 5,), 
                          Text(
                            '' ,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: (MediaQuery.of(context).size.width / 3),
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddSlot.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          Container(
                            width: 70,
                            height: 60,
                            child: Image.asset(
                              'assets/images/Slot.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "SLOT",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          SizedBox(height: 5,), 
                          Text(
                            '$slots Slots' ,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AddCategories.routeName);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          left: 5,
                          right: 5,
                          bottom: 5,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        child: Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                          Text(
                            '',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ComicNeue-Light",
                            ),
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        // child: GridView(
        //   padding: EdgeInsets.all(0),
        //   children:getCatList().map((catData) {

        //         print(catData.subTitle);
        //           return InkWell(
        //             onTap: () {
        //               Navigator.pushNamed(context, catData.routeAddress);
        //             },
        //             child: Container(
        //               padding: EdgeInsets.only(
        //                 top: 10,
        //                 left: 5,
        //                 right: 5,
        //               ),
        //               decoration: BoxDecoration(
        //                   border: Border.all(color: Colors.grey, width: 1)),
        //               child: Column(children: [
        //                 Container(
        //                   width: 70,
        //                   height: 60,
        //                   child: Image.asset(
        //                     catData.imgLink,
        //                     fit: BoxFit.contain,
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 10,
        //                 ),
        //                 Text(
        //                   catData.title,
        //                   style: TextStyle(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                     fontFamily: "ComicNeue-Light",
        //                   ),
        //                 ),
        //                 Text(
        //                   catData.subTitle.toString(),
        //                   style: TextStyle(
        //                     fontSize: 15,
        //                     fontWeight: FontWeight.bold,
        //                     fontFamily: "ComicNeue-Light",
        //                   ),
        //                 ),
        //               ]),
        //             ),
        //           );
        //         }).toList(),
        //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 150,
        //     childAspectRatio: 0.9,
        //     crossAxisSpacing: 0,
        //     mainAxisSpacing: 0,
        //   ),
        // ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(
              child: Icon(Icons.home),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyHomePage()));
              },
            ),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            title: Text("Activity"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Results"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("Search"),
          ),
        ],
        selectedItemColor: Colors.black,
      ),
    );
  }
}
