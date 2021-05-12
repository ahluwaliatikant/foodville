import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodville/screens/restaurantDashboard.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodville/screens/profileSetUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodville/screens/restaurantProfileSetUp.dart';

class OtpForRestaurant extends StatefulWidget {
  final String phoneNumber;
  final String foodCourtName;

  OtpForRestaurant(this.phoneNumber, this.foodCourtName);

  @override
  _OtpForRestaurantState createState() => _OtpForRestaurantState();
}

class _OtpForRestaurantState extends State<OtpForRestaurant> {
  String _verificationCode;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Enter The OTP"),
        centerTitle: true,
        //backgroundColor: Color(0xFF30475e),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            SvgPicture.asset(
              "images/business-and-finance.svg",
              width: 200,
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                withCursor: true,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
                eachFieldWidth: 40.0,
                eachFieldHeight: 55.0,
                //onSubmit: (String pin) => _showSnackBar(pin),
                focusNode: _pinPutFocusNode,
                controller: _pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
                onSubmit: (pin) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        String uid = value.user.uid;
                        final x = await FirebaseFirestore.instance
                            .collection('food_courts')
                            .doc(widget.foodCourtName)
                            .collection('restaurants')
                            .doc(uid)
                            .get();
                        if (x.exists) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('login', true);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestaurantDashboard(
                                        resId: value.user.uid,
                                        foodCourtName: widget.foodCourtName,
                                      )),
                              (route) => false);
                        } else {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestaurantProfileSetUp(
                                        userID: value.user.uid,
                                        foodCourtName: widget.foodCourtName,
                                      )),
                              (route) => false);
                        }
                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldkey.currentState
                        .showSnackBar(SnackBar(content: Text("Invalid OTP")));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential _credential) async {
          await FirebaseAuth.instance.signInWithCredential(_credential);
        },
        verificationFailed: (FirebaseException e) {
          print(e.message);
        },
        codeSent: (String verificationID, int resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(milliseconds: 60000));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}