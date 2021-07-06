
import 'package:flutter/cupertino.dart';
import 'package:foodville/models/restaurantModel.dart';

class Item {
  String id;
  String name;
  String description;
  double price;
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
      name: json["itemName"],
      description: json["itemDescription"],
      price: json["costOfItem"],
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