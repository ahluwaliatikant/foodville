import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodville/models/itemModel.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:foodville/providers/menuProvider.dart';
import 'package:foodville/screens/viewMenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/widgets/customTextField.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class SetMenu extends StatelessWidget {
  final Restaurant restaurant;
  SetMenu({
    @required
    this.restaurant
  });

  final menuFormKey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final priceController = new TextEditingController();
  final descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mainRedColor,
      appBar: AppBar(
        backgroundColor: mainRedColor,
        elevation: 0,
        actions: [
          Consumer(
            builder: (ctx, watch,child) {
              return watch(menuController(restaurant.id)).when(
                  data: (List<Item> itemsList){
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0 , right: 16.0),
                      child: Badge(
                        badgeColor: Colors.white,
                        badgeContent: Text(itemsList.length.toString()),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewMenu(id: restaurant.id)));
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
                  loading: (){
                    return Padding(
                      padding: const EdgeInsets.only(top:5.0 , right: 16.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                        size: 40,
                      ).shimmer(),
                    );
                  },
                  error: (Object error , StackTrace stackTrace){
                    return Text("Error" + error.toString());
                  }
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: Text(
                        "Create A Menu",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    height: height * 0.65,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Form(
                      key: menuFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Enter Details",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    color: mainRedColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CustomTextField(
                            myController: nameController,
                            hint: "Name",
                          ),
                          CustomTextField(
                            myController: priceController,
                            hint: "Price",
                          ),
                          CustomTextField(
                            myController: descController,
                            hint: "Description",
                          ),
                          TextButton(
                            onPressed: () async {
                              //send details for restaurant
                              if (menuFormKey.currentState.validate()) {
                                Item item = new Item(
                                  id: Uuid().v4(),
                                  name: nameController.text,
                                  price: int.parse(priceController.text),
                                  description: descController.text,
                                  imageUrl: "",
                                  restaurantId: restaurant.id,
                                );

                                context.read(menuController(restaurant.id).notifier).addItem(item);
                              }
                            },
                            style: TextButton.styleFrom(
                              primary: mainRedColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(12.0),
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color: mainRedColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "ADD",
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
                          TextButton(
                            onPressed: () async {
                                //TODO Navigate to the restaurant home
                            },
                            style: TextButton.styleFrom(
                              primary: mainRedColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(12.0),
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color: mainRedColor,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Center(
                                  child: Text(
                                    "PROCEED",
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
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

