import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.myController,
    @required this.hint,
  }) : super(key: key);

  final TextEditingController myController;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$hint cannot be blank.';
        }
        return null;
      },
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: matteBlack,
          decoration: TextDecoration.none,
        ),
      ),
      cursorColor: matteBlack,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: mainRedColor,),
          borderRadius: BorderRadius.circular(100.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          BorderSide(color: mainRedColor, width: 2.0),
          borderRadius: BorderRadius.circular(100.0),
        ),
      ),
    );
  }
}