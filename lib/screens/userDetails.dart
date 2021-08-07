import 'package:flutter/material.dart';
import 'package:foodville/database/uploadImage.dart';
import 'package:foodville/models/userModel.dart';
import 'package:foodville/providers/userProvider.dart';
import 'package:foodville/screens/userHome.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/widgets/customTextField.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/database/userDao.dart';

class UserDetails extends StatefulWidget {
  final userId;
  final phoneNumber;
  UserDetails({this.userId , this.phoneNumber});

  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final userDetailsFormKey = GlobalKey<FormState>();

  final nameController = new TextEditingController();

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
                        "Set Up Your Profile",
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
                      key: userDetailsFormKey,
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
                            onPressed: () async{
                              if(userDetailsFormKey.currentState.validate()){

                                String profilePicUrl = await UploadImage().addProfilePic(widget.userId, _image);

                                User user = new User(
                                  id: widget.userId,
                                  name: nameController.text,
                                  phoneNumber: widget.phoneNumber,
                                  completedOrders: [],
                                  currentOrders: [],
                                  profilePicUrl: profilePicUrl,
                                );
                                await context.read(userController.notifier).addNewUser(user);
                                final x = await context
                                    .read(userDbProvider)
                                    .getUserById(widget.userId);

                                context.read(userController.notifier).setUserState(x);

                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserHome()),
                                        (route) => false);
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
