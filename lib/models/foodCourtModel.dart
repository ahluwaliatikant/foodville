import 'package:flutter/cupertino.dart';

class FoodCourt {
  String id;
  String name;
  String location;

  FoodCourt({
    @required this.id,
    this.name,
    this.location,
  });

  factory FoodCourt.fromJson(Map<String,dynamic> json){
    return FoodCourt(
      id: json["id"],
      name: json["name"],
      location: json["location"],
    );
  }

  Map<String,dynamic> toJson(FoodCourt foodCourt){
    return {
      "id": foodCourt.id,
      "name": foodCourt.name,
      "location": foodCourt.location,
    };
  }
}