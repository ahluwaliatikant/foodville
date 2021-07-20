import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/cartProvider.dart';
import 'package:foodville/screens/viewCart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/menuProvider.dart';
import 'package:foodville/models/itemModel.dart';
import 'package:foodville/widgets/placeOrderItemCard.dart';

class PlaceOrderScreen extends StatefulWidget {

  final String id;
  PlaceOrderScreen({this.id});

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCart(id: widget.id,)));
            },
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Consumer(
          builder: (ctx, watch,child) {
            return watch(menuController("test_rest_id")).when(
                data: (List<Item> itemsList){
                  itemsList.forEach((element) {
                    print(element.name);
                  });
                  return ListView.builder(
                      itemCount: itemsList.length,
                      itemBuilder: (context , index){
                        return PlaceOrderItemCard(
                          name: itemsList[index].name,
                          price: itemsList[index].price.toString(),
                          description: itemsList[index].description,
                          imageUrl: itemsList[index].imageUrl,
                          addItemToCart: (){
                            context.read(cartController.notifier).addItem(itemsList[index]);
                          },
                        );
                      }
                  );
                },
                loading: (){
                  return Center(child: CircularProgressIndicator(),);
                },
                error: (Object error , StackTrace stackTrace){
                  return Text("Error" + error.toString());
                });
          },
        ),
      ),
    );
  }
}
