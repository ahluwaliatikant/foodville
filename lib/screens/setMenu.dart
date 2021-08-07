import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodville/database/restaurantsDao.dart';
import 'package:foodville/models/itemModel.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:foodville/providers/menuProvider.dart';
import 'package:foodville/screens/restaurantHome.dart';
import 'package:foodville/screens/viewMenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/widgets/customTextField.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/providers/restaurantProvider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:foodville/database/uploadImage.dart';

class SetMenu extends StatefulWidget {
  final Restaurant restaurant;
  SetMenu({@required this.restaurant});

  @override
  _SetMenuState createState() => _SetMenuState();
}

class _SetMenuState extends State<SetMenu> {
  File _image;
  bool isLoading = false;
  final menuFormKey = GlobalKey<FormState>();
  final nameController = new TextEditingController();
  final priceController = new TextEditingController();
  final descController = new TextEditingController();

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: mainRedColor,
      appBar: AppBar(
        backgroundColor: mainRedColor,
        elevation: 0,
        actions: [
          Consumer(
            builder: (ctx, watch, child) {
              return watch(menuController(widget.restaurant.id)).when(
                  data: (List<Item> itemsList) {
                return isLoading == false ? Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 16.0),
                  child: Badge(
                    badgeColor: Colors.white,
                    badgeContent: Text(itemsList.length.toString()),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewMenu(id: widget.restaurant.id)));
                      },
                      child: Icon(
                        Icons.menu_book,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ) : Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 16.0),
                  child: Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 40,
                  ).shimmer(),
                );
              }, loading: () {
                return Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 16.0),
                  child: Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 40,
                  ).shimmer(),
                );
              }, error: (Object error, StackTrace stackTrace) {
                return Text("Error" + error.toString());
              });
            },
          )
        ],
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
                        "Create A Menu",
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
                    height: height * 0.75,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: Form(
                      key: menuFormKey,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * 0.4,
                                    child: CustomTextField(
                                      myController: nameController,
                                      hint: "Name",
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: width * 0.4,
                                    child: CustomTextField(
                                      myController: priceController,
                                      hint: "Price",
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPicker();
                                  });
                                },
                                child: Container(
                                  width: width * 0.4,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: mainRedColor,
                                  ),
                                  child: _image == null
                                      ? Center(
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.white,
                                            size: 80,
                                          ),
                                        )
                                      : ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.file(
                                            _image,
                                            fit: BoxFit.cover,
                                          ),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          CustomTextField(
                            myController: descController,
                            hint: "Description",
                          ),
                          Column(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  //send details for restaurant
                                  String itemId = Uuid().v4();
                                  setState(() {
                                    isLoading = true;
                                  });

                                  String imageUrl = await UploadImage().addRestaurantLogoImage(itemId, _image);
                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (menuFormKey.currentState.validate()) {
                                    Item item = new Item(
                                      id: itemId,
                                      name: nameController.text,
                                      price: int.parse(priceController.text),
                                      description: descController.text,
                                      imageUrl: imageUrl,
                                      restaurantId: widget.restaurant.id,
                                    );

                                    await context
                                        .read(
                                            menuController(widget.restaurant.id)
                                                .notifier)
                                        .addItem(item);

                                    setState(() {
                                      nameController.text = "";
                                      priceController.text = "";
                                      descController.text = "";
                                      _image = null;
                                    });
                                  }
                                },
                                style: TextButton.styleFrom(
                                  primary: mainRedColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
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
                              TextButton(
                                onPressed: () async {
                                  final x = await context
                                      .read(restaurantDbProvider)
                                      .getRestaurantById(widget.restaurant.id);
                                  context
                                      .read(restaurantsController.notifier)
                                      .setRestaurantState(x);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RestaurantHome()),
                                      (route) => false);
                                },
                                style: TextButton.styleFrom(
                                  primary: mainRedColor,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
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
                                        "PROCEED",
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
