import 'package:foodville/models/itemModel.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/models/itemModel.dart';

class Restaurant {
  String id;
  String name;
  FoodCourt foodCourt;
  String logoImageUrl;
  List<Item> menu;
  List<Order> currentOrders;
  List<Order> completedOrders;

  Restaurant({
    this.id,
    this.name,
    this.foodCourt,
    this.menu,
    this.logoImageUrl,
    this.currentOrders,
    this.completedOrders,
  });

  factory Restaurant.fromJson(Map<String,dynamic> json){
    return Restaurant(
      id: json["id"],
      name: json["name"],
      foodCourt: json["foodCourt"],
      menu: json["menu"],
      logoImageUrl: json["logoImageUrl"],
      currentOrders: json["currentOrders"],
      completedOrders: json["completedOrders"]
    );
  }

  Map<String,dynamic> toJson(Restaurant restaurant){
    return{
      "id": restaurant.id,
      "name": restaurant.name,
      "foodCourt": restaurant.name,
      "menu": restaurant.menu,
      "logoImageUrl": restaurant.logoImageUrl,
      "currentOrders": restaurant.currentOrders,
      "completedOrders": restaurant.completedOrders,
    };
  }
}