import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodville/screens/otpScreen.dart';

class CustomerLogin extends StatefulWidget {
  @override
  _CustomerLoginState createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneNumberController = TextEditingController();
  String _verificationId;

  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Customer Login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        //backgroundColor: Color(0xFF30475e),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        //color: Colors.redAccent,
        child:SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                    "images/undraw_mobile_login_ikmv.svg",
                    width: width*0.8,
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _phoneNumberController,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFf7f3e9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            hintText: "Enter Phone Number",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed:() {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(_phoneNumberController.text)));
                    },
                    child: Text("Get OTP"),
                    style: ButtonStyle(
                      //backgroundColor: MaterialStateProperty.all(Color(0xFF30475e)),
                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                      textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white, fontSize: 20)),
                      padding: MaterialStateProperty.all(EdgeInsets.only(left: 50 , right: 50 , top: 10 , bottom: 10)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                    ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
