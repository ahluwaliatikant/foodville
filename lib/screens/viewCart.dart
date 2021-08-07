import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:foodville/providers/cartProvider.dart';
import 'package:foodville/providers/userProvider.dart';
import 'package:foodville/widgets/newItemCard.dart';
import 'package:foodville/widgets/orderDetailsCard.dart';
import 'package:foodville/widgets/placeOrderDetailsCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:uuid/uuid.dart';
import 'package:foodville/models/userModel.dart';
import 'package:foodville/screens/userHome.dart';

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
          child: state.items.length > 0 ? Column(
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
                        qty: state.quantityMap[state.items[index].id].toString(),
                        displayQty: true,
                      );
                    }
                ),
              ),
              PlaceOrderDetailsCard(
                noOfItems: state.totalNoOfItems,
                totalAmount: state.totalAmount,
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
                    quantityMap: state.quantityMap,
                  );
                  await context.read(orderDbProvider).placeOrder(order);
                  context.read(cartController.notifier).emptyCart();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserHome()),
                          (route) => false);
                },
              ),
            ],
          ) : Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "images/emptyCart.svg",
                  width: width*0.7,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Cart is empty",
                  style: TextStyle(
                    fontSize: 20
                  ),
                )
              ]
            )
          ),
        ),
      ),
    );
  }
}
