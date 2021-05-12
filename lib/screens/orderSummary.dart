import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodville/models/item.dart';
import 'package:foodville/methods/firebaseRemove.dart';
import 'package:foodville/methods/firebaseAdd.dart';

class OrderSummary extends StatefulWidget {
  final String uid;
  final String userName;
  final List<dynamic> items;
  final double totalAmount;
  final String foodCourtName;
  final String resId;
  final bool enabled;

  OrderSummary(
      {this.totalAmount,
      this.userName,
      this.items,
      this.uid,
      this.resId,
      this.foodCourtName,
      this.enabled});
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
//      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
//        backgroundColor: Color(0xFF30475e),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "${widget.userName}'s Order:",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(
                        widget.items[index]['itemName'],
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      trailing: Text(
                        "₹" + widget.items[index]['itemPrice'].toString(),
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
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.black,
                    );
                  },
                  itemCount: widget.items.length),
            )
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
                      "Total Amount:   ${widget.totalAmount.toString()}",
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
                      width: width - 30,
                      child: ElevatedButton(
                        onPressed: widget.enabled ? () async {
                          await FirebaseFirestore.instance
                              .collection('food_courts')
                              .doc(widget.foodCourtName)
                              .collection('restaurants')
                              .doc(widget.resId)
                              .collection('placedOrders')
                              .doc(widget.uid)
                              .update({'isCompleted': true})
                              .then((value) => _showSnackBar(context))
                              .catchError((error) =>
                                  print("Error Occured while updating"));

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.uid)
                              .collection('placedOrders')
                              .doc(widget.resId)
                              .update({'isCompleted': true})
                              .then((value) => _showSnackBar(context))
                              .catchError((error) =>
                                  print("Error Occured while updating"));

                          _showSnackBar(context);

                          Navigator.pop(context);
                        }: (){print("not allowed");} ,
                        child: Text("Completed",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        style: ButtonStyle(
                          backgroundColor: widget.enabled ?
                              MaterialStateProperty.all(Colors.greenAccent) :
                              MaterialStateProperty.all(Colors.grey),
                          textStyle: MaterialStateProperty.all(TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              left: 50, right: 50, top: 10, bottom: 10)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          );
        },
      ),
    );
  }
}

void _showSnackBar(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.green,
    content: Text("Order marked as completed"),
    duration: Duration(seconds: 1),
  ));
  Navigator.pop(context);
}
