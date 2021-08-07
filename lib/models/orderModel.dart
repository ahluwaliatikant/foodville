import 'package:flutter/cupertino.dart';
import 'package:foodville/models/userModel.dart';
import 'package:foodville/models/itemModel.dart';
import 'dart:convert';

class Order {
  String id;
  List<Item> items;
  String placedBy;
  DateTime placedAt;
  String status;
  String restaurant;
  int totalAmount;
  String restaurantImageUrl;
  String placedByImageUrl;
  Map<String,int> quantityMap;

  Order({
    @required this.id,
    this.items,
    this.restaurant,
    this.status,
    this.placedAt,
    this.placedBy,
    this.totalAmount,
    this.restaurantImageUrl,
    this.placedByImageUrl,
    this.quantityMap,
  });

  factory Order.fromJson(Map<String,dynamic> myJson){
    List<Item> itemsList = [];
    var jsonList = myJson["items"];
    if(jsonList != null) {
      jsonList.forEach((jsonItem) {
        itemsList.add(Item.fromJson(jsonItem));
      });
    }

    print("order ke andar ka done");

    print(myJson);

    return Order(
      id: myJson["id"],
      items: itemsList,
      placedAt: DateTime.parse(myJson["placedAt"]),
      placedBy: myJson["placedBy"]["name"],
      restaurant: myJson["restaurant"]["name"],
      restaurantImageUrl: myJson['restaurant']['logoImageUrl'],
      placedByImageUrl: myJson['placedBy']['profilePicUrl'],
      status: myJson["status"],
      totalAmount: myJson["totalAmount"],
      quantityMap: Map<String,int>.from(json.decode(myJson["quantityMap"])),
    );
  }

  Map<String,dynamic> toJson(Order order){

    return{
      "id": order.id,
      "items": order.items.map((e) => e.toJson(e)).toList(),
      "placedAt": order.placedAt.toIso8601String(),
      "placedBy": order.placedBy,
      "restaurant": order.restaurant,
      "status": order.status,
      "totalAmount": order.totalAmount,
      "quantityMap": order.quantityMap
    };
  }
}