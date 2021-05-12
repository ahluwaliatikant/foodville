import 'package:flutter/material.dart';
import 'package:foodville/methods/firebaseRemove.dart';

class UserOrderSummary extends StatefulWidget {
  final String restaurantName;
  final List<dynamic> items;
  final double totalAmount;
  final bool isCompleted;
  final String resId;
  final String uid;
  final String foodCourtName;

  UserOrderSummary(
      {this.restaurantName,
      this.items,
      this.totalAmount,
      this.isCompleted,
      this.resId,
      this.uid,
      this.foodCourtName});
  @override
  _UserOrderSummaryState createState() => _UserOrderSummaryState();
}

class _UserOrderSummaryState extends State<UserOrderSummary> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      //backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(
          "Order Summary",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        //backgroundColor: Color(0xFF30475e),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "${widget.restaurantName}",
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
                        onPressed: widget.isCompleted
                            ? () async {
                                await FirebaseRemove()
                                    .removeFromUserPlacedOrders(
                                        widget.uid, widget.resId);
                                await FirebaseRemove()
                                    .removeFromRestaurantPlacedOrders(
                                        widget.foodCourtName,
                                        widget.resId,
                                        widget.uid);

                                //show a snack bar
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      "Order collected and removed from list"),
                                  backgroundColor: Colors.green,
                                ));

                                //navigate to previous screen
                                Navigator.of(context).pop();
                              }
                            : () {
                                print("not allowed");
                              },
                        child: widget.isCompleted
                            ? Text("Collected",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                "Not Ready",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                        style: ButtonStyle(
                          backgroundColor: widget.isCompleted
                              ? MaterialStateProperty.all(Colors.greenAccent)
                              : MaterialStateProperty.all(Colors.red),
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
              )
            ],
          );
        },
      ),
    );
  }
}
