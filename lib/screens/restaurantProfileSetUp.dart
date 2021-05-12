import 'package:flutter/material.dart';
import 'package:foodville/methods/firebaseAdd.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/screens/createMenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantProfileSetUp extends StatefulWidget {
  final String userID;
  final String foodCourtName;
  RestaurantProfileSetUp({this.userID , this.foodCourtName});
  @override
  _RestaurantProfileSetUpState createState() => _RestaurantProfileSetUpState();
}

class _RestaurantProfileSetUpState extends State<RestaurantProfileSetUp> {
  File _image;
  final TextEditingController _nameController = new TextEditingController();

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
              )
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Restaurant Login",
          ),
          //backgroundColor: Color(0xFF30475e),
          backgroundColor: Colors.redAccent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
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
                              :Container(
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
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFf7f3e9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "Restaurant Name",
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed:() async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('login', true);
                  FirebaseAdd().addRestaurant(widget.foodCourtName, widget.userID, _nameController.text, [], [] , _image);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateMenu(
                        userID: widget.userID,
                        foodCourtName: widget.foodCourtName,
                      )),
                    );
                },
                child: Text("Create Menu"),
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
        )
    );
  }
}
