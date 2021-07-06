import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/widgets/customTextField.dart';

class SignUpUserScreen extends StatelessWidget {

  final signUpDetailsFormKey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mainRedColor,
      appBar: AppBar(
        backgroundColor: mainRedColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    height: height * 0.65,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Form(
                      key: signUpDetailsFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Enter Details",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 30,
                                    color: mainRedColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                          CustomTextField(
                            myController: nameController,
                            hint: "Name",
                          ),
                          TextButton(
                            onPressed: () {
                              //TODO send details for user
                            },
                            style: TextButton.styleFrom(
                              primary: mainRedColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(12.0),
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color: mainRedColor,
                                  borderRadius: BorderRadius.circular(100),
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
