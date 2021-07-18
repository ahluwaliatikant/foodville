import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:velocity_x/velocity_x.dart';


class PickImage{
  Future<File> _imageFromCamera() async {
    PickedFile pickedImage = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    return File(pickedImage.path);
  }

  Future<File> _imageFromGallery() async {
    PickedFile pickedImage = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    return File(pickedImage.path);

  }

  Future<File> showPicker(BuildContext context) async{
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
                      onTap: () async {
                        return _imageFromCamera();
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_library),
                      title: "Choose From Gallery".text.make(),
                      onTap: () async{
                        return _imageFromGallery();
                      },
                    )
                  ],
                ),
              )
          );
        }
    );
  }
}