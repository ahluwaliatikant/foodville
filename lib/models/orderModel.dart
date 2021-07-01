import 'package:flutter/cupertino.dart';
import 'package:foodville/models/userModel.dart';
import 'package:foodville/models/itemModel.dart';

class Order {
  String id;
  List<Item> items;
  User placedBy;
  DateTime placedAt;
  String status;
  String restaurant;
  double totalAmount;

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
    return Order(
      id: json["id"],
      items: json["items"],
      placedAt: json["placedAt"],
      placedBy: json["placedBy"],
      restaurant: json["restaurant"],
      status: json["status"],
      totalAmount: json["totalAmount"]
    );
  }

  Map<String,dynamic> toJson(Order order){
    return{
      "id": order.id,
      "items": order.items,
      "placedAt": order.placedAt,
      "placedBy": order.placedBy,
      "restaurant": order.restaurant,
      "status": order.status,
    };
  }
}