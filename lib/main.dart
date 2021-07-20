import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/screens/placeOrderItemCard.dart';
import 'package:foodville/screens/placeOrderScreen.dart';
import 'package:foodville/screens/restaurantDetails.dart';
import 'package:foodville/screens/selectRolePage.dart';
import 'package:foodville/screens/customerLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodville/screens/setMenu.dart';
import 'package:foodville/screens/signUpRestaurant.dart';
import 'package:foodville/screens/userHome.dart';
import 'package:foodville/screens/viewMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodville/screens/userDashboard.dart';
import 'package:foodville/screens/otpScreen.dart';
import 'package:foodville/screens/profileSetUp.dart';
import 'package:foodville/screens/addItemCard.dart';
import 'package:foodville/screens/createMenu.dart';
import 'package:foodville/screens/itemCard.dart';
import 'package:foodville/screens/addAnItemCard.dart';
import 'package:foodville/screens/restaurantLogin.dart';
import 'package:foodville/screens/restaurantProfileSetUp.dart';
import 'package:foodville/screens/restaurantDashboard.dart';
import 'package:foodville/screens/menuItem.dart';
import 'package:foodville/screens/orderCard.dart';
import 'package:foodville/screens/addFoodCourt.dart';
import 'package:foodville/screens/selectFoodCourt.dart';
import 'package:foodville/screens/userDetails.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/screens/signUpUser.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool login=prefs.getBool('login');
  //runApp(login==null?MyApp():login?MyApp1():MyApp());
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Foodville',
            theme: ThemeData(
              accentColor: mainRedColor,
            ),
            //home: SignUpRestaurantScreen(),
            home: PlaceOrderScreen(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return PlaceOrderScreen();
      },
    );
//    return
  }
}

class MyApp1 extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          //return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              //primarySwatch: Colors.blue,
            ),
            home: UserDashboard(userId: getCurrentUid(),),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return CustomerLogin();
      },
    );
//    return
  }
}

String getCurrentUid() {
  FirebaseAuth _auth =FirebaseAuth.instance;
  final User _user =  _auth.currentUser;
  return _user.uid;
}