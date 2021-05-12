import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/models/restaurant.dart';
import 'package:foodville/models/item.dart';
import 'package:foodville/models/user.dart';

class Order {
  String restaurantId = "";
  String restaurantName = "";
//  List<String> items;
//  List<String> itemPrices;
  List<Item> items = [];
  double totalAmount = 0;
  bool isCompleted = false;
  String placedByUserId = "";
  String placedByUserName = "";
  List<Map<String,dynamic>> myItems = [];
  String foodCourtName = "";

  Map<String , dynamic> toJson(){

    if(myItems.length == 0){
      items.forEach((item) {
        myItems.add(item.toJson());
      });
    }

    return {
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'totalAmount': totalAmount,
      'placedByUserId': placedByUserId,
      'placedByUserName': placedByUserName,
      'items': myItems,
      'isCompleted': isCompleted,
      'foodCourtName': foodCourtName,
    };
  }
}