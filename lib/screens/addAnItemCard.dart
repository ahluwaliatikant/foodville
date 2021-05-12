import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddAnItemCard extends StatefulWidget {
  AddAnItemCard({this.returnData});

  @override
  final Function(String name, String desc, String price, File image) returnData;
  _AddAnItemCardState createState() => _AddAnItemCardState();
}

class _AddAnItemCardState extends State<AddAnItemCard> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Colors.redAccent,
          child: Container(
            padding: EdgeInsets.only(left: 5, right: 15, top: 10, bottom: 10),
            height: 300,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: width * 0.5,
                    child: TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.5,
                    child: TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Price",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _descController,
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: "Description",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: ()  {
                        widget.returnData(
                          _nameController.text.toString(),
                          _descController.text.toString(),
                          _priceController.text.toString(),
                          _image);

                          setState(() {
                            _nameController.text = "";
                            _priceController.text = "";
                            _descController.text = "";
                            _image = null;
                          });
                      },
                      child: Text("Add"),
                      style: ButtonStyle(
//                        backgroundColor: MaterialStateProperty.all(Color(0xFF30475e)),
                        backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.black, fontSize: 20)),
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            left: 50, right: 50, top: 10, bottom: 10)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: 15,
          child: GestureDetector(
            onTap: () {
              _showPicker();
            },
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
//                  color: Color(0xFF30475e),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)),
              child: _image != null
                  ? ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.file(
                        _image,
                        fit: BoxFit.fill,
                      ),
                  )
                  : Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
