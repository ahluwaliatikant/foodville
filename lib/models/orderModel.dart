import 'package:flutter/cupertino.dart';
import 'package:foodville/models/userModel.dart';
import 'package:foodville/models/itemModel.dart';

class Order {
  String id;
  List<Item> items;
  String placedBy;
  DateTime placedAt;
  String status;
  String restaurant;
  int totalAmount;

  Order({
    @required this.id,
    this.items,
    this.restaurant,
    this.status,
    this.placedAt,
    this.placedBy,
    this.totalAmount,
  });

  factory Order.fromJson(Map<String,dynamic> json){
    List<Item> itemsList = [];
    var jsonList = json["items"];
    jsonList.forEach((jsonRestaurant){
      itemsList.add(Item.fromJson(jsonRestaurant));
    });

    return Order(
      id: json["id"],
      items: itemsList,
      placedAt: DateTime.parse(json["placedAt"]),
      placedBy: json["placedBy"]["name"],
      restaurant: json["restaurant"]["name"],
      status: json["status"],
      totalAmount: json["totalAmount"]
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
      "totalAmount": order.totalAmount
    };
  }
}