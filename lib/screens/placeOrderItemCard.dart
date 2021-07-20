import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceOrderItemCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(12.0),
          children: [
            Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 20,
              shadowColor: Color.fromARGB(100, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 120,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          color: mainBeigeColor),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                          child: Image.asset(
                            "images/newPizza.jpg",
                            fit: BoxFit.cover,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Farmhouse",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 24,
                                  color: matteBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "The All Veggie Pizza",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "₹200",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  color: mainRedColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  shadowColor: Color.fromARGB(100, 0, 0, 0),
                  elevation: 10,
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                  ),
                ),
                Positioned(
                  left: 10,top: 10,
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              "images/newPizza.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Farmhouse",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 24,
                                      color: matteBlack,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "The All Veggie Pizza",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "₹200",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 20,
                                      color: mainRedColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Positioned(
                    right: 10,
                    bottom: 10,
                    child: TextButton(
                      onPressed: () {

                      },
                      style: TextButton.styleFrom(
                        primary: mainRedColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(100))),
                      ),
                      child: Container(
                          padding: EdgeInsets.all(8.0),
                          width: 120,
                          decoration: BoxDecoration(
                            color: mainRedColor,
                            borderRadius: BorderRadius.circular(100),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFFD31027),
                                Color(0xFFEA384D),
                              ],
                            )
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
