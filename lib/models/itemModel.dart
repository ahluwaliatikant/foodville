
import 'package:flutter/cupertino.dart';
import 'package:foodville/models/restaurantModel.dart';

class Item {
  String id;
  String name;
  String description;
  int price;
  String imageUrl;
  String restaurantId;

  Item({
    @required this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.restaurantId,
  });

  factory Item.fromJson(Map<String,dynamic> json){
    return Item(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageUrl: json["imageUrl"],
      restaurantId: json["restaurantId"]
    );
  }

  Map<String , dynamic> toJson(Item item){
    print(item.id);
    return {
      "id": item.id,
      "name": item.name,
      "description": item.description,
      "price": item.price,
      "imageUrl": item.imageUrl,
      "restaurantId": item.restaurantId,
    };
  }
}