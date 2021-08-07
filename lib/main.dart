import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/screens/selectARolePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  bool login=prefs.getBool('login');
//  //runApp(login==null?MyApp():login?MyApp1():MyApp());
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
            home: SelectARole(),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return SelectARole();
      },
    );
//    return
  }
}

//class MyApp1 extends StatelessWidget {
//  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder(
//      // Initialize FlutterFire:
//      future: _initialization,
//      builder: (context, snapshot) {
//        // Check for errors
//        if (snapshot.hasError) {
//          //return SomethingWentWrong();
//        }
//
//        // Once complete, show your application
//        if (snapshot.connectionState == ConnectionState.done) {
//          return MaterialApp(
//            debugShowCheckedModeBanner: false,
//            title: 'Flutter Demo',
//            theme: ThemeData(
//              //primarySwatch: Colors.blue,
//            ),
//            home: SelectARole(),
//          );
//        }
//        // Otherwise, show something whilst waiting for initialization to complete
//        return SelectARole();
//      },
//    );
////    return
//  }
//}
//
//String getCurrentUid() {
//  FirebaseAuth _auth =FirebaseAuth.instance;
//  final User _user =  _auth.currentUser;
//  return _user.uid;
//}