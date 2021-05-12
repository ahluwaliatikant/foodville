import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String itemName;
  String itemDescription;
  double costOfItem;
  String itemImage;

  Map<String , dynamic> toJson(){
    return {
      'itemName': itemName,
      'itemPrice': costOfItem,
    };
  }
}