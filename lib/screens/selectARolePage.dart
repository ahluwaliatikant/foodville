import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodville/widgets/gradientButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/screens/addFoodCourt.dart';
import 'package:foodville/screens/signUpUser.dart';
import 'package:foodville/screens/signUpRestaurant.dart';

class SelectARole extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "FoodVille",
                  style: GoogleFonts.righteous(
                    textStyle: TextStyle(
                      color: mainRedColor,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SvgPicture.asset(
                  "images/mainScreenImage.svg",
                  width: width*0.8,
                ),
                SizedBox(
                  height: 20,
                ),
                GradientButton(
                  text: "Add A Food Court",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFoodCourtScreen()));
                  },
                ),
                GradientButton(
                  text: "Restaurant Login",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpRestaurantScreen()));
                  },
                ),
                GradientButton(
                  text: "Customer Login",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpUserScreen()));
                  },
                ),
              ],
      ),
          )),
    );
  }
}
