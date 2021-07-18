import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';
import 'package:foodville/screens/restaurantDashboard.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/screens/addAnItemCard.dart';
import 'package:foodville/screens/itemCard.dart';
import 'package:foodville/methods/firebaseAdd.dart';
import 'dart:io';

class CreateMenu extends StatefulWidget {
  final String userID;
  final String foodCourtName;

  CreateMenu({this.userID, this.foodCourtName});

  @override
  _CreateMenuState createState() => _CreateMenuState();
}

class _CreateMenuState extends State<CreateMenu> {
  @override
  List<String> listOfNames = [];
  List<String> listOfDesc = [];
  List<String> listOfPrice = [];
  List<File> imageFiles = [];

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: FocusWatcher(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RestaurantDashboard(
                          resId: widget.userID,
                          foodCourtName: widget.foodCourtName,
                        )));
              },
              label: Text("Proceed" , style: TextStyle(fontSize: 20 ),)),
          appBar: AppBar(
            title: "Create Menu".text.white.make(),
            centerTitle: true,
            //backgroundColor: Color(0xFF30475e),
            backgroundColor: Colors.redAccent,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Add\nItem",
                ),
                Tab(
                  text: "Menu",
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AddAnItemCard(
                returnData:
                    (String name, String desc, String price, File image) {
                  print("Inside return data");
                  setState(() {
                    listOfNames.add(name);
                    listOfDesc.add(desc);
                    listOfPrice.add(price);
                    imageFiles.add(image);
                  });
                  //print("Reached Firebase line");
                  FirebaseAdd().addMenuItem(widget.foodCourtName, widget.userID,
                      name, desc, price, image);
                  //print("After Firebase line");

                  //show a snakbar
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Item Added To Menu"),
                    backgroundColor: Colors.green,
                  ));
                },
              ),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listOfNames.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCard(
                      dishName: listOfNames[index],
                      dishDesc: listOfDesc[index],
                      dishPrice: listOfPrice[index],
                      //imageUrl: imageFiles[index],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
