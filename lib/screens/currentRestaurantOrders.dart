import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:foodville/providers/completedOrdersProvider.dart';
import 'package:foodville/providers/currentOrdersProvider.dart';
import 'package:foodville/providers/restaurantProvider.dart';
import 'package:foodville/screens/newOrderSummary.dart';
import 'package:foodville/widgets/orderCard.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/providers/myParameter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrentOrders extends StatefulWidget {
  final String resId;
  final Restaurant restaurant;
  CurrentOrders({this.resId, this.restaurant});

  @override
  _CurrentOrdersState createState() => _CurrentOrdersState();
}

class _CurrentOrdersState extends State<CurrentOrders> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Consumer(
        builder: (ctx, watch, child) {
          return watch(currentOrdersController(MyParameter(
            isUser: false,
            id: widget.resId,
          ))).when(data: (List<Order> orders) {
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
                                      ))).then((value) {
                            context
                                .read(currentOrdersController(MyParameter(
                                  isUser: false,
                                  id: widget.resId,
                                )).notifier)
                                .refreshState(widget.resId);

                            context
                                .read(completedOrdersController(MyParameter(
                                  isUser: false,
                                  id: widget.resId,
                                )).notifier)
                                .refreshState(widget.resId);
                          });
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
