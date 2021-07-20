import 'package:flutter/material.dart';
import 'package:foodville/models/itemModel.dart';

class Cart {
  List<Item> items;
  int totalAmount;


  Cart({
    this.items,
    this.totalAmount
  });

  factory Cart.fromJson(Map<String,dynamic> json){
    return Cart(
      items: json["items"],
      totalAmount: json["totalItems"],
    );
  }

  Map<String,dynamic> toJson(Cart cart){
    return {
      "items": cart.items,
      "totalAmount": cart.totalAmount
    };
  }
}