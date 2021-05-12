import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Menu extends StatefulWidget {
  final String foodCourtName;
  final String restaurantId;
  final Function returnData;

  Menu({this.restaurantId, this.foodCourtName, this.returnData});
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CollectionReference restaurants = FirebaseFirestore.instance
        .collection("food_courts")
        .doc(widget.foodCourtName)
        .collection("restaurants")
        .doc(widget.restaurantId)
        .collection('menu');

    return StreamBuilder<QuerySnapshot>(
      stream: restaurants.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: height * 0.20,
                  child: Flexible(
                    child: Card(
                      color: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 15,
                      child: Row(
                        children: [
                          SizedBox(
                            width: width * 0.28,
                          ),
                          Container(
                            width: width * 0.7,
                            decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 15, top: 10, bottom: 10),
                                  width: width * 0.78,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
//                              SizedBox(
//                                width: 10,
//                              ),
                                      Text(
                                        document.data()['dishName'],
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
//                              SizedBox(
//                                width: 100,
//                              ),
                                      Text("₹${document.data()['dishPrice']}",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 15, bottom: 10),
                                  child: Text(
                                    document.data()['dishDescription'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15,
                  top: 15,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: document.data()['dishImageUrl'],
                        placeholder: (context, url) => SizedBox(
                          child: CircularProgressIndicator(),
                          height: 75,
                          width: 75,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.returnData(
                        document.data()['dishName'],
                        document.data()['dishPrice'],
                      );
                    },
                    child: Text("Add",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent),
                      textStyle: MaterialStateProperty.all(TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                          left: 50, right: 50, top: 10, bottom: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        );
      },
    );
  }
}
