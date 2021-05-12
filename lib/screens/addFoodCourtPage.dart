import 'package:flutter/material.dart';
import 'package:foodville/screens/selectRolePage.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/methods/firebaseAdd.dart';

class AddFoodCourt extends StatefulWidget {
  @override
  _AddFoodCourtState createState() => _AddFoodCourtState();
}

class _AddFoodCourtState extends State<AddFoodCourt> {
  TextEditingController _courtNameController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Add A Food Court".text.white.make(),
        centerTitle: true,
        //backgroundColor: Color(0xFF30475e),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: _courtNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFf7f3e9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    labelText: "Enter Your Name",
                  ),
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFf7f3e9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: "Enter Location",
                  ),
                ),
              ],
            )),
            ElevatedButton(
              onPressed:() async{
                //add court to firebase
                await FirebaseAdd().addCourt(_courtNameController.text, _locationController.text, []);

                //show snackBar
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Food Court Added"),
                  duration: Duration(seconds: 2),
                ));

                //go back to select role screen
                Navigator.pop(context);
              },
              child: Text("Register"),
              style: ButtonStyle(
                //backgroundColor: MaterialStateProperty.all(Color(0xFF30475e)),
                backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white, fontSize: 20)),
                padding: MaterialStateProperty.all(EdgeInsets.only(left: 50 , right: 50 , top: 10 , bottom: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
              ),
            ),
//            ElevatedButton(
//              onPressed:() async{
//                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectRole()));
//              },
//              child: Text("Go to Role Page"),
//              style: ButtonStyle(
//                backgroundColor: MaterialStateProperty.all(Color(0xFF30475e)),
//                textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white, fontSize: 20)),
//                padding: MaterialStateProperty.all(EdgeInsets.only(left: 50 , right: 50 , top: 10 , bottom: 10)),
//                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
