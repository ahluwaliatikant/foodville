
import 'package:flutter/cupertino.dart';

class Item {
  String id;
  String name;
  String description;
  double price;
  String imageUrl;

  Item({
    @required this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
  });

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
      id: json["id"],
      name: json["itemName"],
      description: json["itemDescription"],
      price: json["costOfItem"],
      imageUrl: json["imageUrl"],
    );
  }

  Map<String , dynamic> toJson(Item item){
    return {
      "id": item.id,
      "name": item.name,
      "description": item.description,
      "price": item.price,
      "imageUrl": item.imageUrl,
    };
  }
}