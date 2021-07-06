import 'package:flutter/cupertino.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'dart:convert';

class FoodCourt {
  String id;
  String name;
  String location;
  List<Restaurant> restaurants;

  FoodCourt({
    @required this.id,
    this.name,
    this.location,
    this.restaurants,
  });

  factory FoodCourt.fromJson(Map<String,dynamic> json){
    List<Restaurant> restaurantList = [];
    var jsonList = json["restaurants"];
    jsonList.forEach((jsonRestaurant){
      restaurantList.add(Restaurant.fromJson(jsonRestaurant));
    });
    return FoodCourt(
      id: json["id"],
      name: json["name"],
      location: json["location"],
      restaurants: restaurantList,
    );
  }

  Map<String,dynamic> toJson(FoodCourt foodCourt){
    return {
      "id": foodCourt.id,
      "name": foodCourt.name,
      "location": foodCourt.location,
      //"restaurants": foodCourt.restaurants,
      "restaurants": foodCourt.restaurants.map((e) => e.toJson(e)).toList(),
    };
  }
}