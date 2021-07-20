import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NewItemCard extends StatelessWidget {

  final String dishName;
  final String dishDesc;
  final String dishPrice;
  final String imageUrl;

  NewItemCard({
    this.imageUrl,
    this.dishName,
    this.dishPrice,
    this.dishDesc
  });
  @override
  Widget build(BuildContext context) {
    return Card(
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
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dishName,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 24,
                          color: matteBlack,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    dishDesc,
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
                    "₹$dishPrice",
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
    );
  }
}
