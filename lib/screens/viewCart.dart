import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:foodville/providers/cartProvider.dart';
import 'package:foodville/providers/userProvider.dart';
import 'package:foodville/widgets/newItemCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:uuid/uuid.dart';
import 'package:foodville/models/userModel.dart';

class ViewCart extends ConsumerWidget {
  final String resId;
  final String userId;
  ViewCart({this.resId , this.userId});

  @override
  Widget build(BuildContext context, ScopedReader watch) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final state = watch(cartController);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
          "Your Order",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: height*0.63,
                child: ListView.builder(
                    itemCount: state.items.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder:(context , index){
                      return NewItemCard(
                        dishName: state.items[index].name,
                        dishPrice: state.items[index].price.toString(),
                        dishDesc: state.items[index].description,
                        imageUrl: state.items[index].imageUrl,
                      );
                    }
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 18.0 , right: 18.0 , left: 18.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: mainRedColor,
                    width: 3,
                  )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total No. of Items:",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: matteBlack,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ),
                        Text(
                          state.items.length.toString(),
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: mainRedColor,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Amount:",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: matteBlack,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ),
                        Text(
                          "₹${state.totalAmount}",
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: mainRedColor,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      color: mainRedColor,
                    ),
                    TextButton(
                      onPressed: () async{
                        //TODO place order function call
                        User user = context.read(userController.notifier).getUserState();
                        print(user.name);
                        Order order  = new Order(
                          id: Uuid().v1(),
                          placedBy: user.id,
                          placedAt: DateTime.now(),
                          restaurant: resId,
                          totalAmount: state.totalAmount,
                          items: state.items,
                          status: "pending",
                        );

                        await context.read(orderDbProvider).placeOrder(order);
                      },
                      style: TextButton.styleFrom(
                        primary: mainRedColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100))),
                      ),
                      child: Container(
                          padding: EdgeInsets.all(12.0),
                          width: width * 0.7,
                          decoration: BoxDecoration(
                            color: mainRedColor,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              "Place Order",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
