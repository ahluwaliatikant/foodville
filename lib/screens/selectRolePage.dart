import 'package:flutter/material.dart';
import 'package:foodville/screens/addFoodCourtPage.dart';
import 'package:foodville/screens/customerLogin.dart';
import 'package:foodville/screens/restaurantLogin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/screens/searchFoodCourt.dart';

class SelectRole extends StatefulWidget {
  @override
  _SelectRoleState createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Foodville",
                style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.1,
                    fontWeight: FontWeight.bold,
                )),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddFoodCourt()));
              },
              child: "Add A Food Court"
                  .text
                  .white
                  .textStyle(GoogleFonts.robotoSlab())
                  .size(25)
                  .make()
                  .box
                  .p16
                  .roundedLg
                  .neumorphic(color: Colors.redAccent, curve: VxCurve.flat)
                  .make(),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchFoodCourt()));
              },
              child: "Restaurant Login"
                  .text
                  .white
                  .textStyle(GoogleFonts.robotoSlab())
                  .size(25)
                  .make()
                  .box
                  .p16
                  .roundedLg
                  .neumorphic(color: Colors.redAccent, curve: VxCurve.flat)
                  .make(),
            ),
            SizedBox(
              height: 25,
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerLogin()));
              },
              child: "Customer Login"
                  .text
                  .white
                  .textStyle(GoogleFonts.robotoSlab())
                  .size(25)
                  .make()
                  .box
                  .p16
                  .roundedLg
                  .neumorphic(color: Colors.redAccent, curve: VxCurve.flat)
                  .make(),
            ),
            //VxBox().roundedLg.neumorphic(color: Colors.red, curve: VxCurve.flat).make(),
          ],
        ),
      ),
    );
  }
}
