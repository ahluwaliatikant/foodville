import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/userModel.dart';
import 'package:foodville/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final userDbProvider = Provider<UserDao>((ref) =>UserDao());

class UserDao {

  Future addNewUser(User user) async{
    var url = Uri.parse(baseUrl + "api/users");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json" , "Accept": "application/json"},
      body: json.encode(User().toJson(user)),
    );

    //TODO return an object of user using fromJson
    var jsonResponse = json.decode(response.body);
    return jsonResponse;
  }

  Future getUserById(String id) async {
    print("IN GET USER BY ID");
    print(id);

    var url = Uri.parse(baseUrl + "api/users/$id");
    var response = await http.get(url);

    print(response.statusCode);
    if(response.statusCode == 422){
      return null;
    }

    var jsonResponse  = json.decode(response.body)['user'];
    User user = User.fromJson(jsonResponse);

    return user;
  }


}