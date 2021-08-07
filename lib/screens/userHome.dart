import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/orderProvider.dart';
import 'package:foodville/providers/userProvider.dart';
import 'package:foodville/screens/selectARolePage.dart';
import 'package:foodville/screens/selectFoodCourt.dart';
import 'package:foodville/screens/viewUserOrders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/userModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double width = MediaQuery.of(context).size.width;
    final state = watch(userController);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "FoodVille",
          style: GoogleFonts.righteous(
              textStyle: TextStyle(
                  color: mainRedColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectARole()),
                        (route) => false);
              },
              child: Icon(
                Icons.logout,
                color: mainRedColor,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: state.when(data: (User user) {
          return Container(
            child: ListView(
              padding: EdgeInsets.only(left: 12.0, bottom: 12.0, right: 12.0),
              physics: BouncingScrollPhysics(),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 18.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            user.profilePicUrl,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: Column(
                      children: [
                        FutureBuilder(
                            future: context
                                .read(orderController(MyParameter(
                                        userId: user.id,
                                        status: "pending",
                                        isUser: true))
                                    .notifier)
                                .getNumberOfCurrentOrders(user.id),
                            builder: (context, snapshot) {
                              if(snapshot.hasError) {
                                return Text("ERROR");
                              }
                              if(snapshot.connectionState == ConnectionState.done)
                              return Text(
                                "Orders in The Kitchen: ${snapshot.data}",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: mainRedColor, fontSize: 20)),
                              );

                              return Center(
                                child: CircularProgressIndicator(),
                              );

                            }),
                        FutureBuilder(
                            future: context
                                .read(orderController(MyParameter(
                                        userId: user.id,
                                        status: "completed",
                                        isUser: true))
                                    .notifier)
                                .getNumberOfCompleted(user.id),
                            builder: (context, snapshot) {

                              if(snapshot.hasError) {
                                return Text("ERROR");
                              }
                              if(snapshot.connectionState == ConnectionState.done)
                                return Text(
                                  "Orders Ready To Collect: ${snapshot.data}",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: mainRedColor, fontSize: 20)),
                                );

                              return Center(
                                child: CircularProgressIndicator(),
                              );


                            }),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Divider(
                            thickness: 2,
                            color: mainRedColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("TAPPEEEDDD");
                        context
                            .read(orderController(MyParameter(
                                    userId: user.id,
                                    status: "pending",
                                    isUser: true))
                                .notifier)
                            .refreshState(user.id, "pending");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewUserOrders(
                                      userId: user.id,
                                      status: "pending",
                                    )));
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
                    GestureDetector(
                      onTap: () {
                        print("TAPPEEEDDD");

                        context
                            .read(orderController(MyParameter(
                                    userId: user.id,
                                    status: "completed",
                                    isUser: true))
                                .notifier)
                            .refreshState(user.id, "completed");

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewUserOrders(
                                      userId: user.id,
                                      status: "completed",
                                    )));
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
                      ),
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
