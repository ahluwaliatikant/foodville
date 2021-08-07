import 'package:flutter/material.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:foodville/providers/restaurantProvider.dart';
import 'package:foodville/screens/setMenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/widgets/customTextField.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/database/uploadImage.dart';

class RestaurantDetails extends StatefulWidget {
  final FoodCourt foodCourt;
  final String uid;
  RestaurantDetails({
    @required
    this.foodCourt,
    this.uid
  });

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  File _image;
  final restaurantDetailsFormKey = GlobalKey<FormState>();
  final nameController = new TextEditingController();


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
                        "Set Up Your Restaurant",
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
                      key: restaurantDetailsFormKey,
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPicker();
                              });
                            },
                            child: CircleAvatar(
                                radius: 80,
                                //backgroundColor: Color(0xFF30475e),
                                backgroundColor: mainRedColor,
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
                                    color: mainRedColor,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ),
                          ),
                          CustomTextField(
                            myController: nameController,
                            hint: "Name",
                          ),
                          TextButton(
                            onPressed: () async {
                              //send details for restaurant

                              String imageUrl = await UploadImage().addRestaurantLogoImage(widget.uid , _image);
                              print("PASSED ID :" + widget.foodCourt.id);
                              print(widget.foodCourt.name);
                              print(widget.foodCourt.location);
                              if (restaurantDetailsFormKey.currentState.validate()) {
                                Restaurant restaurant = new Restaurant(
                                  id: widget.uid,
                                  name: nameController.text,
                                  foodCourt: widget.foodCourt.id,
                                  logoImageUrl: imageUrl,
                                  menu: [],
                                  orders: [],
                                );
                                await context
                                    .read(restaurantsController.notifier)
                                    .addRestaurant(restaurant);

                                //TODO navigate to set menu screen
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SetMenu(restaurant: restaurant)));
                              }
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

