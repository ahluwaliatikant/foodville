import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/userProvider.dart';
import 'package:foodville/screens/selectFoodCourt.dart';
import 'package:foodville/screens/viewUserOrders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/userModel.dart';

class UserHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double width = MediaQuery.of(context).size.width;
    final state = watch(userController);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: state.when(data: (User user) {
          return Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12.0),
                      child: Text(
                        "Hi, ${user.name}",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: matteBlack,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectFoodCourt(
                                    uid: user.id,
                                    isRestaurantLogin: false,
                                  )));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: mainBeigeColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Place An\nOrder",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: matteBlack,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset(
                              "images/cheeseburger.png",
                              height: 150,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print("TAPPEEEDDD");
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUserOrders(userId: user.id,)));
                      },
                      child: Container(
                        height: 200,
                        width: width * 0.4,
                        child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: mainRedColor,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 20,
                                  top: 20,
                                  child: Icon(
                                    Icons.kitchen,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  right: 20,
                                  child: Text(
                                    "In The\nKitchen",
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: mainBeigeColor,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: width * 0.4,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: mainRedColor,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 20,
                                top: 20,
                                child: Icon(
                                  Icons.fastfood,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: Text(
                                  "Ready To\nCollect",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: mainBeigeColor,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          )),
                    )
                  ],
                )
              ],
            ),
          );
        }, loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        }, error: (Object error, StackTrace stackTrace) {
          return Center(
            child: Text("ERROR"),
          );
        }),
      ),
    );
  }
}
