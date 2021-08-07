import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/completedOrdersProvider.dart';
import 'package:foodville/widgets/orderCard.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/providers/myParameter.dart';
import 'package:foodville/screens/newOrderSummary.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CompletedOrders extends StatelessWidget {
  final String resId;
  CompletedOrders({this.resId});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

//    final state = watch(orderController(
//        MyParameter(isUser: false, userId: resId, status: "completed")));
    return Container(
      child: Consumer(
        builder: (ctx, watch, child) {
          return watch(completedOrdersController(
                  MyParameter(isUser: false, id: resId)))
              .when(data: (List<Order> orders) {
            return orders.length > 0
                ? ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        order: orders[index],
                        isUser: true,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OrderSummary(
                                        isUser: false,
                                        order: orders[index],
                                      )));
                        },
                      );
                    })
                : Container(
                    width: width,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "images/noOrders.svg",
                            width: width * 0.6,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("No Orders",
                              style: TextStyle(
                                fontSize: 20,
                              ))
                        ]),
                  );
          }, loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          }, error: (Object err, StackTrace st) {
            return Center(
              child: Text(
                "ERROR  $err",
              ),
            );
          });
        },
      ),
    );
  }
}
