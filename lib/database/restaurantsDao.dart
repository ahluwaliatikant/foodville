import 'package:foodville/database/foodCourtDao.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:http/http.dart' as http;
import 'package:foodville/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

final restaurantDbProvider = Provider<RestaurantDao>((ref) => RestaurantDao());

class RestaurantDao{
  Future addRestaurant(Restaurant restaurant) async{
    var url = Uri.parse(baseUrl + "api/restaurants");
    print(json.encode(Restaurant().toJson(restaurant)));
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json" , "Accept": "application/json"},
      body: json.encode(Restaurant().toJson(restaurant)),
    );

    return response.body;
  }

  Future getAllRestaurantsOfAFoodCourt(String foodCourtId) async{
    FoodCourt foodCourt = await FoodCourtDao().getFoodCourtById(foodCourtId);
    return foodCourt.restaurants;
  }

  Future getRestaurantById(String id) async {
    print("IN GET RESTAURANT BY ID");
    print(id);

    var url = Uri.parse(baseUrl + "api/restaurants/$id");
    var response = await http.get(url);

    print(response.statusCode);
    if(response.statusCode == 422){
      return null;
    }

    var jsonResponse  = json.decode(response.body)['foodCourt'];
    Restaurant restaurant = Restaurant.fromJson(jsonResponse);

    return restaurant;
  }

}