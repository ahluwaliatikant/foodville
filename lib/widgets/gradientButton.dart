import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {

  final String text;
  final Function onTap;

  GradientButton({this.text , this.onTap});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        primary: mainRedColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
      ),
      child: Container(
          padding: EdgeInsets.all(8.0),
          width: width*0.8,
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
              text,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
    );
  }
}
