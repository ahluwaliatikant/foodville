import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/widgets/orderDetailsCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/itemModel.dart';

class OrderSummary extends StatelessWidget {

  final Order order;
  final bool isUser;

  int totalQuantity(List<Item> items , Map<String,int> mp){
    int ans = 0;

    for(int i=0 ; i<items.length ; i++){
      int x = mp[items[i].id];
      ans = ans + x;
    }

    return ans;
  }

  OrderSummary({this.order, this.isUser});
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
            "Order Summary",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(width: 10,),
                  CachedNetworkImage(
                    imageUrl: isUser ? order.restaurantImageUrl : order.placedByImageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    isUser? order.restaurant : order.placedBy,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: matteBlack,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: height*0.5,
                child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: order.items.length,
                    itemBuilder: (context , index){
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              order.items[index].name,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: matteBlack,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "₹${order.items[index].price}",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: mainRedColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Text(
                                  "x ${order.quantityMap[order.items[index].id]}",
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      color: mainRedColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context , index){
                      return Divider(
                        thickness: 1,
                        color: mainRedColor,
                      );
                    },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OrderDetailsCard(
                  totalAmount: order.totalAmount,
                  buttonText: isUser ? "Picked Up" : "Order Ready",
                  noOfItems: totalQuantity(order.items, order.quantityMap),
                  isUser: isUser,
                  status: order.status,
                  onPressed: () async {
                    if(isUser && order.status == "pending"){
                      //TODO cant do anything
                    }
                    else if(isUser && order.status == "completed"){
                      //TODO delete order
                      print("HELLO");
                      await context.read(orderDbProvider).deleteOrder(order.id);
                      Navigator.pop(context);
                    }
                    else if(!isUser && order.status == "pending"){
                      //TODO Update order status to completed
                      await context.read(orderDbProvider).updateOrderStatus(order.id, "completed");
                      Navigator.pop(context);
                    }
                    else if(!isUser && order.status == "completed"){
                      //TODO can't do anything
                    }
                  },
                ),
              ),
            ],
          ),
      ),
    );
  }
}
