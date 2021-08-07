import 'package:flutter/material.dart';
import 'package:foodville/models/itemModel.dart';

class Cart {
  List<Item> items;
  int totalAmount;
  Map<String,int> quantityMap;
  int totalNoOfItems;

  Cart({
    this.items,
    this.totalAmount,
    this.quantityMap,
    this.totalNoOfItems,
  });

  factory Cart.fromJson(Map<String,dynamic> json){
    return Cart(
      items: json["items"],
      totalAmount: json["totalItems"],
      quantityMap: json["quantityMap"],
      totalNoOfItems: json["totalNoOfItems"]
    );
  }

  Map<String,dynamic> toJson(Cart cart){
    return {
      "items": cart.items,
      "totalAmount": cart.totalAmount,
      "quantityMap": cart.quantityMap,
      "totalNoOfItems": cart.totalNoOfItems,
    };
  }
}