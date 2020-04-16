import 'package:ROSystem/categoryList.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  static const routeName = '/home-category-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.of(context).pop();
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
        child: GridView(
          padding: EdgeInsets.all(0),
          children: categoryList.map((catData) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, catData.routeAddress);
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Column(children: [
                  Container(
                    width: 70,
                    height: 60,
                    child: Image.asset(
                      catData.imgLink,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    catData.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ComicNeue-Light",
                    ),
                  ),
                ]),
              ),
            );
          }).toList(),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1.1,
            crossAxisSpacing: 0,
            mainAxisSpacing: 0,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: InkWell(child: Icon(Icons.home), onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
            },),
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
      ),    );
  }
}
