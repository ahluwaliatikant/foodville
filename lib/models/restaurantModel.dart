import 'package:foodville/models/itemModel.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/models/itemModel.dart';

class Restaurant {
  String id;
  String name;
  String foodCourt;
  String logoImageUrl;
  List<Item> menu;
  List<Order> orders;

  Restaurant({
    this.id,
    this.name,
    this.foodCourt,
    this.menu,
    this.logoImageUrl,
    this.orders,
  });

  factory Restaurant.fromJson(Map<String,dynamic> json){

    print("in restaurant from json");
    print(json['id']);

    List<Item> menu = [];
    var jsonList = json["menu"];
    if(jsonList != null){
      jsonList.forEach((jsonItem){
        menu.add(Item.fromJson(jsonItem));
      });
    }
    print("menu done");

//    List<Order> ordersList = [];
//    var jsonOrdersList = json['orders'];
//    if(jsonOrdersList != null){
//      jsonOrdersList.forEach((jsonOrder) {
//        ordersList.add(Order.fromJson(jsonOrder));
//      });
//    }

    print("orders done");


    return Restaurant(
      id: json["id"],
      name: json["name"],
      foodCourt: json["foodCourt"],
      menu: menu,
      logoImageUrl: json["logoImageUrl"],
      //orders: ordersList,
    );
  }

  Map<String,dynamic> toJson(Restaurant restaurant){

    print("YE HAI RESTAURANT ID:" + restaurant.id);
    print("RESTAURANT TO JSON MEIN ID: " + restaurant.foodCourt);

    return{
      "id": restaurant.id,
      "name": restaurant.name,
      "foodCourt": restaurant.foodCourt,
      "menu": restaurant.menu,
      "logoImageUrl": restaurant.logoImageUrl,
      "orders": restaurant.orders,
    };
  }
}