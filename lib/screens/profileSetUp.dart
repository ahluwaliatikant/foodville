import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodville/screens/userDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:foodville/methods/firebaseAdd.dart';

class SetUpProfile extends StatefulWidget {
  final String userID;
  final String phoneNumber;

  SetUpProfile(this.userID, this.phoneNumber);
  @override
  _SetUpProfileState createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  File _image;
  _imageFromCamera() async {
    PickedFile pickedImage = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    setState(() {
      _image = File(pickedImage.path);
    });
  }

  _imageFromGallery() async {
    PickedFile pickedImage = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    setState(() {
      _image = File(pickedImage.path);
    });
  }

  _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: "Capture An Image".text.make(),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: "Choose From Gallery".text.make(),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nameController = new TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: "Set Up Your Profile".text.white.make(),
          //backgroundColor: Color(0xFF30475e),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
        ),
        body: Container(
          //color: Colors.redAccent,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  _showPicker();
                },
                child: CircleAvatar(
                    radius: 100,
                    //backgroundColor: Color(0xFF30475e),
                    backgroundColor: Colors.redAccent,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _image,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              //color: Color(0xFF30475e),
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.camera_alt,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                          )),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                  child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFf7f3e9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: "Enter Your Name",
                      ),
                    )
                  ],
                ),
              )),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('login', true);
                  FirebaseAdd().addUser(widget.userID, _nameController.text, widget.phoneNumber, [], [] , _image);

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDashboard(
                                userId: widget.userID,
                                name: _nameController.text,
                              )),
                      (route) => false);
                },
                child: Text("Register"),
                style: ButtonStyle(
                  //backgroundColor: MaterialStateProperty.all(Color(0xFF30475e)),
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(color: Colors.white, fontSize: 20)),
                  padding: MaterialStateProperty.all(EdgeInsets.only(
                      left: 50, right: 50, top: 10, bottom: 10)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
                ),
              ),
            ],
          ),
        ));
  }
}
