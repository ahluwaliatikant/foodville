import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';

class OrderDetailsCard extends StatelessWidget {
  final int noOfItems;
  final int totalAmount;
  final Function onPressed;
  final String buttonText;
  final bool isUser;
  final String status;
  OrderDetailsCard(
      {this.totalAmount,
      this.onPressed,
      this.noOfItems,
      this.buttonText,
      this.isUser,
      this.status});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: 18.0, right: 18.0, left: 18.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: mainRedColor,
            width: 3,
          )),
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
                )),
              ),
              Text(
                noOfItems.toString(),
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  fontSize: 18,
                  color: mainRedColor,
                  fontWeight: FontWeight.bold,
                )),
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
                )),
              ),
              Text(
                "₹${totalAmount}",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                  fontSize: 18,
                  color: mainRedColor,
                  fontWeight: FontWeight.bold,
                )),
              )
            ],
          ),
          ((isUser && status=="completed")|| (!isUser && status=="pending")) ? Divider(
            thickness: 2,
            color: mainRedColor,
          ): Container(height: 10, color: Colors.transparent,),
          ((isUser && status=="completed")|| (!isUser && status=="pending"))? TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              primary: mainRedColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
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
                    buttonText,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          ): Container(),
        ],
      ),
    );
  }
}
