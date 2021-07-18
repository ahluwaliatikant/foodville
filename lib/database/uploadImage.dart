import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class UploadImage{
  Future<String> addRestaurantLogoImage(String id , File file) async{
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/restaurants/$id").putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  Future<String> addProfilePic(String id , File file) async{
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/users/$id").putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

  Future<String> addItemImage (String id , File file) async{
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/items/$id").putFile(file);
    return await snapshot.ref.getDownloadURL();
  }

}