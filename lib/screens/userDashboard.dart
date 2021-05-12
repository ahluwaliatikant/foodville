import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/screens/chooseFoodCourt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/screens/userOrderSummary.dart';

class UserDashboard extends StatefulWidget {
  final String userId;
  final String name;

  UserDashboard({this.userId, this.name});
  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                expandedHeight: 150,
                title: Text("Dashboard", style: TextStyle(color: Colors.white),),
                centerTitle: true,
                //backgroundColor: Color(0xFF30475e),
                backgroundColor: Colors.redAccent,
                floating: true,
                pinned: true,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      text: "Place\nOrder",
                      icon: Icon(Icons.restaurant_menu),
                    ),
                    Tab(
                      text: "In The\nKitchen",
                      icon: Icon(Icons.kitchen),
                    ),
                    Tab(
                      text: "Ready To\nCollect",
                      icon: Icon(Icons.check),
                    ),
                    Tab(
                      text: "Profile",
                      icon: Icon(Icons.person),
                    )
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              ChooseFoodCourt(
                userID: widget.userId,
                userName: widget.name,
              ),
              PlacedOrders(
                uid: widget.userId,
              ),
              ReadyOrders(
                uid: widget.userId,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 100,
//                      backgroundColor: Color(0xFF30475e),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: GetImage(widget.userId),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GetUserName(widget.userId),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlacedOrders extends StatefulWidget {
  final String uid;

  PlacedOrders({this.uid});
  @override
  _PlacedOrdersState createState() => _PlacedOrdersState();
}

class _PlacedOrdersState extends State<PlacedOrders> {
  @override
  Widget build(BuildContext context) {
    Query placedOrders = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('placedOrders')
        .where('isCompleted', isEqualTo: false);

    return StreamBuilder<QuerySnapshot>(
      stream: placedOrders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if(snapshot.data.docs.length == 0){
          return Center(child: Text("No Orders Placed" , style: TextStyle(color: Colors.red , fontSize: 20),),);
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserOrderSummary(
                          restaurantName: document.data()['restaurantName'],
                          items: document.data()['items'],
                          totalAmount: document.data()['totalAmount'],
                          isCompleted: false,
                          uid: document.data()['placedByUserId'],
                          resId: document.data()['restaurantId'],
                          foodCourtName: document.data()['foodCourtName'],
                        )));
              },
              child: Card(
                child: ListTile(
                  title: Text(
                    document.data()['restaurantName'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,),
                  ),
                  subtitle: Text(
                    "₹" + document.data()['totalAmount'].toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class ReadyOrders extends StatefulWidget {
  final String uid;
  ReadyOrders({this.uid});
  @override
  _ReadyOrdersState createState() => _ReadyOrdersState();
}

class _ReadyOrdersState extends State<ReadyOrders> {
  @override
  Widget build(BuildContext context) {
    Query readyOrders = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .collection('placedOrders')
        .where('isCompleted', isEqualTo: true);

    return StreamBuilder<QuerySnapshot>(
      stream: readyOrders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if(snapshot.data.docs.length == 0){
          return Center(child: Text("No Ready Orders" , style: TextStyle(color: Colors.red , fontSize: 20),),);
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => UserOrderSummary(
                          restaurantName: document.data()['restaurantName'],
                          items: document.data()['items'],
                          totalAmount: document.data()['totalAmount'],
                          uid: document.data()['placedByUserId'],
                          resId: document.data()['restaurantId'],
                          foodCourtName: document.data()['foodCourtName'],
                          isCompleted: true,
                        )));
              },
              child: ListTile(
                title: Text(
                  document.data()['restaurantName'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                subtitle: Text(
                    "₹" + document.data()['totalAmount'].toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class GetImage extends StatelessWidget {
  final String documentId;

  GetImage(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Icon(Icons.error);
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Icon(Icons.account_circle);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return CachedNetworkImage(
            imageUrl: data['profilePicUrl'],
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          );
        }

        return Text("loading");
      },
    );
  }
}


class GetUserName extends StatelessWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text(
            "Hi! ${data['name']}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
            ),
          );
        }

        return Text("loading");
      },
    );
  }
}
