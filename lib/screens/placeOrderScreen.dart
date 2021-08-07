import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/cartProvider.dart';
import 'package:foodville/screens/viewCart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/menuProvider.dart';
import 'package:foodville/models/itemModel.dart';
import 'package:foodville/widgets/placeOrderItemCard.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/models/cartModel.dart';
import 'package:badges/badges.dart';

class PlaceOrderScreen extends StatefulWidget {
  final String id;
  PlaceOrderScreen({this.id});

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content:
                new Text('If you leave this screen your order will be lost'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () {
                  context.read(cartController.notifier).emptyCart();
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read(cartController.notifier).getCartLength() > 0) {
          return _onWillPop();
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainRedColor,
          centerTitle: true,
          title: Text(
            "Place Order",
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            Consumer(
              builder: (ctx, watch, child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 16.0),
                  child: Badge(
                    badgeColor: Colors.white,
                    badgeContent:
                        Text(watch(cartController).totalNoOfItems.toString()),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewCart(
                                      resId: widget.id,
                                    )));
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: SafeArea(
          child: Consumer(
            builder: (ctx, watch, child) {
              return watch(menuController(widget.id)).when(
                  data: (List<Item> itemsList) {
                itemsList.forEach((element) {
                  print(element.name);
                });
                return ListView.builder(
                    itemCount: itemsList.length,
                    itemBuilder: (context, index) {
                      return PlaceOrderItemCard(
                        name: itemsList[index].name,
                        price: itemsList[index].price.toString(),
                        description: itemsList[index].description,
                        imageUrl: itemsList[index].imageUrl,
                        addItemToCart: () {
                          context
                              .read(cartController.notifier)
                              .addItem(itemsList[index]);
                        },
                      );
                    });
              }, loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }, error: (Object error, StackTrace stackTrace) {
                return Text("Error" + error.toString());
              });
            },
          ),
        ),
      ),
    );
  }
}
