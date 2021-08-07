import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:foodville/models/itemModel.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  final bool isUser;
  final Function onPressed;
  OrderCard({this.order , this.isUser , this.onPressed});


  int totalQuantity(List<Item> items , Map<String,int> mp){
    int ans = 0;

    for(int i=0 ; i<items.length ; i++){
      int x = mp[items[i].id];
      ans = ans + x;
    }

    return ans;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.white,
        elevation: 4,
        shadowColor: Color.fromARGB(100, 0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
//                CircleAvatar(
//                  radius: 30.0,
//                  backgroundImage: AssetImage("images/newPizza.jpg"),
//                  backgroundColor: Colors.transparent,
//                ),
                  CachedNetworkImage(
                    imageUrl: isUser ? order.placedByImageUrl : order.restaurantImageUrl,
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
                    width: 10,
                  ),
                  Text(
                    isUser ? "${order.placedBy}'s Order" : order.restaurant,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: matteBlack,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    )),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${totalQuantity(order.items, order.quantityMap)} Items",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                          color: mainRedColor,
                          fontSize: 18.0,
                        )),
                      ),
                      Text(
                        "₹${order.totalAmount}",
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: mainRedColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: matteBlack,
                    size: 30,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
