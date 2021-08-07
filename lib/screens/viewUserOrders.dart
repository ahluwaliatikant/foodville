import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/orderProvider.dart';
import 'package:foodville/screens/newOrderSummary.dart';
import 'package:foodville/widgets/orderCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/models/itemModel.dart';

class ViewUserOrders extends ConsumerWidget {
  final String userId;
  final String status;
  ViewUserOrders({this.userId, this.status});
  @override
  Widget build(BuildContext context, ScopedReader watch) {

    double width = MediaQuery.of(context).size.width;

    final state = watch(
      orderController(
          MyParameter(userId: userId, status: status, isUser: true)),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
          "Your Orders",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: (){
                context
                    .read(orderController(MyParameter(
                    userId: userId,
                    status: status,
                    isUser: true))
                    .notifier)
                    .refreshState(userId, status);
              },
              child: Icon(
                Icons.refresh,
                size: 30,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: state.when(data: (List<Order> orders) {
        return orders.length > 0  ? ListView.builder(
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderCard(
              order: orders[index],
              isUser: false,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderSummary(
                              isUser: true,
                              order: orders[index],
                            ))).then((value) => () {
                      context
                          .read(orderController(MyParameter(
                                  userId: userId, status: status, isUser: true))
                              .notifier)
                          .refreshState(userId, status);
                    });
              },
            );
          },
        ) : Container(
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "images/noOrders.svg",
                width: width*0.6,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "No Orders",
                style: TextStyle(
                  fontSize: 20,
                )
              )
            ]
          ),
        );
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      }, error: (Object error, StackTrace stackTrace) {
        return Center(
          child: Text("ERROR ${error.toString()}"),
        );
      })),
    );
  }
}
