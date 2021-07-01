import 'package:flutter/cupertino.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/models/orderModel.dart';

class User{
  String id;
  String name;
  String phoneNumber;
  String profilePicUrl;
  List<Order> currentOrders;
  List<Order> completedOrders;

  User({
    @required this.id,
    this.name,
    this.phoneNumber,
    this.currentOrders,
    this.completedOrders,
    this.profilePicUrl,
  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json["id"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
      currentOrders: json["currentOrders"],
      completedOrders: json["completedOrders"],
      profilePicUrl: json["profilePicUrl"]
    );
  }

  Map<String,dynamic> toJson(User user){
    return {
      "id": user.id,
      "name": user.name,
      "phoneNumber": user.phoneNumber,
      "currentOrders": user.currentOrders,
      "completedOrders": user.completedOrders,
      "profilePicUrl": user.profilePicUrl,
    };
  }
}