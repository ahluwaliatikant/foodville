import 'package:foodville/models/itemModel.dart';
import 'package:foodville/models/restaurantModel.dart';

class Menu {
  List<Item> items;
  Restaurant restaurant;

  Menu({
    this.items,
    this.restaurant
  });

  factory Menu.fromJson(Map<String,dynamic> json){
    List<Item> itemsList = [];
    var jsonList = json["items"];
    jsonList.forEach((jsonRestaurant){
      itemsList.add(Item.fromJson(jsonRestaurant));
    });

    return Menu(
      items: itemsList,
      restaurant: Restaurant.fromJson(json["restaurant"]),
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