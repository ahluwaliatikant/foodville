
import 'package:flutter/cupertino.dart';

class Item {
  String id;
  String name;
  String description;
  double price;
  String image;

  Item({
    @required this.id,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
      id: json["id"],
      name: json["itemName"],
      description: json["itemDescription"],
      price: json["costOfItem"],
      image: json["itemImage"],
    );
  }

  Map<String , dynamic> toJson(Item item){
    return {
      "id": item.id,
      "name": item.name,
      "description": item.description,
      "price": item.price,
      "image": item.image,
    };
  }
}