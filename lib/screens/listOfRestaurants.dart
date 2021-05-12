import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodville/screens/placeOrder.dart';

class ListOfRestaurants extends StatefulWidget {
  final String foodCourtName;
  final String userName;
  final String userId;


  ListOfRestaurants({this.foodCourtName , this.userId , this.userName});
  @override
  _ListOfRestaurantsState createState() => _ListOfRestaurantsState();
}

class _ListOfRestaurantsState extends State<ListOfRestaurants> {
  List<String> listOfNames = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference restaurants = FirebaseFirestore.instance
        .collection("food_courts")
        .doc(widget.foodCourtName)
        .collection("restaurants");

    return StreamBuilder<QuerySnapshot>(
      stream: restaurants.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Scaffold(
          appBar: AppBar(
            title: Text("Restaurants" , style: TextStyle(color: Colors.white),),
            centerTitle: true,
            backgroundColor: Colors.redAccent,
          ),
          body: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlaceOrder(
                            restaurantId: document.data()['id'],
                            restaurantName: document.data()['name'],
                            foodCourtName: widget.foodCourtName,
                            userName: widget.userName,
                            userId: widget.userId,
                          )));
                },
                child: ListTile(
                  title: Text(document.data()['name']),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
