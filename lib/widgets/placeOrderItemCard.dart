import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceOrderItemCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final Function addItemToCart;

  PlaceOrderItemCard(
      {this.name,
      this.price,
      this.description,
      this.imageUrl,
      this.addItemToCart});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          shadowColor: Color.fromARGB(100, 0, 0, 0),
          elevation: 10,
          child: Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
        ),
        Positioned(
            left: 10,
            top: 10,
            child: Row(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 24,
                              color: matteBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        description,
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
                        "₹$price",
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
            )),
        Positioned(
          right: 10,
          bottom: 10,
          child: TextButton(
            onPressed: () {
              addItemToCart();
            },
            style: TextButton.styleFrom(
              primary: mainRedColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
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
                    )),
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
    );
  }
}
