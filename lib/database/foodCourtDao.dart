import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:http/http.dart' as http;
import 'package:foodville/constants.dart';
import 'dart:convert';

final foodCourtDbProvider = Provider<FoodCourtDao>((ref) => FoodCourtDao());

class FoodCourtDao {

  Future addFoodCourt(FoodCourt foodCourt) async{
    var url = Uri.parse(baseUrl + "api/foodcourts");
    print(foodCourt);
    print(json.encode(FoodCourt().toJson(foodCourt)));
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json" , "Accept": "application/json"},
      body: json.encode(FoodCourt().toJson(foodCourt)),
    );

    print(response.body);
    return response.body;
  }

  Future getAllFoodCourts() async {
    var client = http.Client();
    var url = Uri.parse(baseUrl + "api/foodCourts");
    var response = await client.get(url);

    print("YE HAI MERA CODE:" + response.statusCode.toString());
    print("YE HAI MERI BODY:" + response.body);

    var jsonResponse = json.decode(response.body);

    var jsonList = jsonResponse['foodCourts'];

    List<FoodCourt> foodCourtList = [];
    jsonList.forEach((jsonFoodCourt) {
      foodCourtList.add(FoodCourt.fromJson(jsonFoodCourt));
    });

    return foodCourtList;
  }

  Future getFoodCourtById(String id) async {
    var url = Uri.parse(baseUrl + "api/foodCourts/$id");
    var response = await http.get(url);
    var jsonResponse  = json.decode(response.body)['foodCourt'];

    FoodCourt foodCourt = FoodCourt.fromJson(jsonResponse);

    return foodCourt;
  }
}