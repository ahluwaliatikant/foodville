import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodville/screens/createMenu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/screens/orderSummary.dart';

class RestaurantDashboard extends StatefulWidget {
  final String resId;
  final String foodCourtName;

  RestaurantDashboard({this.foodCourtName, this.resId});

  @override
  _RestaurantDashboardState createState() => _RestaurantDashboardState();
}

class _RestaurantDashboardState extends State<RestaurantDashboard> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          //backgroundColor: Color(0xFF30475e),
          backgroundColor: Colors.redAccent,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Text(
                "Current\nOrders",
                textAlign: TextAlign.center,
              ),
              Text(
                "Completed\nOrders",
                textAlign: TextAlign.center,
              ),
              Text(
                "Profile",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CurrentOrders(
              resId: widget.resId,
              foodCourtName: widget.foodCourtName,
            ),
            CompletedOrders(
              resId: widget.resId,
              foodCourtName: widget.foodCourtName,
            ),
            Profile(resId: widget.resId, foodCourtName: widget.foodCourtName,),
          ],
        ),
      ),
    );
  }
}

class CurrentOrders extends StatefulWidget {
  final String resId;
  final String foodCourtName;

  CurrentOrders({this.foodCourtName, this.resId});

  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    Query placedOrders = FirebaseFirestore.instance
        .collection('food_courts')
        .doc(widget.foodCourtName)
        .collection('restaurants')
        .doc(widget.resId)
        .collection('placedOrders')
        .where('isCompleted', isEqualTo: false);

    return StreamBuilder<QuerySnapshot>(
      stream: placedOrders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.data.docs.length == 0){
          return Center(child: Text("No Orders" , style: TextStyle(color: Colors.red , fontSize: 20),),);
        }


        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderSummary(
                          uid: document.data()['placedByUserId'],
                          userName: document.data()['placedByUserName'],
                          items: document.data()['items'],
                          totalAmount: document.data()['totalAmount'],
                          resId: widget.resId,
                          foodCourtName: widget.foodCourtName,
                          enabled: true,
                        )));
              },
              child: ListTile(
                title: Text(
                  document.data()['placedByUserName'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                subtitle: Text(
                  document.data()['totalAmount'].toString(),
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

class CompletedOrders extends StatefulWidget {
  final String resId;
  final String foodCourtName;

  CompletedOrders({this.foodCourtName, this.resId});
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  @override
  Widget build(BuildContext context) {
    Query placedOrders = FirebaseFirestore.instance
        .collection('food_courts')
        .doc(widget.foodCourtName)
        .collection('restaurants')
        .doc(widget.resId)
        .collection('placedOrders')
        .where('isCompleted', isEqualTo: true);

    return StreamBuilder<QuerySnapshot>(
      stream: placedOrders.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.data.docs.length == 0){
          return Center(child: Text("No Orders" , style: TextStyle(color: Colors.red , fontSize: 20),),);
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OrderSummary(
                      uid: document.data()['placedByUserId'],
                      userName: document.data()['placedByUserName'],
                      items: document.data()['items'],
                      totalAmount: document.data()['totalAmount'],
                      resId: widget.resId,
                      foodCourtName: widget.foodCourtName,
                      enabled: false,
                    )));
              },
              child: ListTile(
                title: Text(
                  document.data()['placedByUserName'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                subtitle: Text(
                  document.data()['totalAmount'].toString(),
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

class Profile extends StatefulWidget {
  final String resId;
  final String foodCourtName;

  Profile({this.resId, this.foodCourtName});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        CircleAvatar(
          radius: 100,
//        backgroundColor: Color(0xFF30475e),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: GetImage(documentId: widget.resId , foodCourtName: widget.foodCourtName),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GetUserName(widget.resId , widget.foodCourtName),
      ],
    );
  }
}


class GetImage extends StatelessWidget {
  final String documentId;
  final String foodCourtName;

  GetImage({this.documentId , this.foodCourtName});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('food_courts').doc(foodCourtName).collection('restaurants');

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
  final String foodCourtName;

  GetUserName(this.documentId , this.foodCourtName);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('food_courts').doc(foodCourtName).collection('restaurants');

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
            "${data['name']}",
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
