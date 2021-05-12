import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/screens/menuItem.dart';
import 'package:foodville/screens/menu.dart';
import 'package:foodville/models/order.dart';
import 'package:foodville/models/item.dart';
import 'package:foodville/methods/firebaseAdd.dart';

class PlaceOrder extends StatefulWidget {
  final String foodCourtName;
  final String restaurantId;
  final String userId;
  final String userName;
  final String restaurantName;

  PlaceOrder({this.foodCourtName, this.restaurantId , this.userId , this.userName , this.restaurantName});

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
//  List<String> items = [];
//  List<String> prices = [];
  List<Item> allItems = [];
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Place Order"),
          centerTitle: true,
          //backgroundColor: Color(0xFF30475e),
          backgroundColor: Colors.redAccent,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: "Menu",
                icon: Icon(Icons.restaurant_menu),
              ),
              Tab(
                text: "Cart",
                icon: Icon(Icons.shopping_cart),
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(bottom: 115),
          child: TabBarView(
            children: [
              Menu(
                foodCourtName: widget.foodCourtName,
                restaurantId: widget.restaurantId,
                returnData: (String dishName, String dishPrice) {
                  Item myItem = new Item();
                  myItem.itemName = dishName;
                  myItem.costOfItem = double.parse(dishPrice);

                  setState(() {
//                  items.add(dishName);
//                  prices.add(dishPrice);
                    allItems.add(myItem);
                    double price = double.parse(dishPrice);
                    totalPrice = totalPrice + price;
                  });
                },
              ),
              ListView.separated(
                itemCount: allItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                        allItems[index].itemName,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                        ),
                    ),
                    trailing: Text(
                        "₹" + allItems[index].costOfItem.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
//                  title: Text(),
//                  subtitle: Text(prices[index]),
                  );
                },
                separatorBuilder: (context , index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
              ),
            ],
          ),
        ),
        bottomSheet: BottomSheet(
          onClosing: () {},
          backgroundColor: Colors.red,
          builder: (context) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 115,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Total Amount:   $totalPrice",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: width-30,
                        child: ElevatedButton(
                          onPressed: () async{
                            Order myOrder = new Order();
//                            allItems.forEach((item) {
//                              myOrder.items.add(item.itemName);
//                            });
//                            allItems.forEach((item) {
//                              myOrder.itemPrices.add(item.costOfItem.toString());
//                            });
                            for(int i=0 ; i<allItems.length ; i++){
                              myOrder.items.add(allItems[i]);
                            }
                            myOrder.placedByUserId = widget.userId;
                            myOrder.placedByUserName = widget.userName;
                            myOrder.totalAmount = totalPrice;
                            myOrder.restaurantId = widget.restaurantId;
                            myOrder.restaurantName = widget.restaurantName;
                            myOrder.isCompleted = false;
                            myOrder.foodCourtName = widget.foodCourtName;
                            //adding to placed orders for restaurant
                            await FirebaseAdd().addOrderToRestaurantPlacedOrders(widget.foodCourtName, widget.restaurantId, myOrder);

                            //add to placed orders for user
                            await FirebaseAdd().addOrderToUserPlacedOrders(widget.userId, myOrder);

                            //show a snackbar
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Order Placed"),
                                duration: Duration(seconds: 2),
                            ));

                            //go back to previous screen
                            Navigator.pop(context);
                          },
                          child: Text("Place Order",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                            textStyle: MaterialStateProperty.all(TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

//class Menu extends StatefulWidget {
//  final String foodCourtName;
//  final String restaurantId;
//  final Function returnData;
//
//  Menu({this.restaurantId, this.foodCourtName, this.returnData});
//  @override
//  _MenuState createState() => _MenuState();
//}
//
//class _MenuState extends State<Menu> {
//  @override
//  Widget build(BuildContext context) {
//    CollectionReference restaurants = FirebaseFirestore.instance
//        .collection("food_courts")
//        .doc(widget.foodCourtName)
//        .collection("restaurants")
//        .doc(widget.restaurantId)
//        .collection('menu');
//
//    return StreamBuilder<QuerySnapshot>(
//      stream: restaurants.snapshots(),
//      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (snapshot.hasError) {
//          return Text('Something went wrong');
//        }
//
//        if (snapshot.connectionState == ConnectionState.waiting) {
//          return Center(
//            child: CircularProgressIndicator(),
//          );
//        }
//
//        return ListView(
//          children: snapshot.data.docs.map((DocumentSnapshot document) {
//            return InkWell(
//                onTap: () {
//                  widget.returnData(
//                    document.data()['dishName'],
//                    document.data()['dishPrice'],
//                  );
//                },
//                child: MenuItem(
//                  dishName: document.data()['dishName'],
//                  dishPrice: document.data()['dishPrice'],
//                  dishDesc: document.data()['dishDescription'],
//                  returnData: widget.returnData,
//                ));
//          }).toList(),
//        );
//      },
//    );
//  }
//}
