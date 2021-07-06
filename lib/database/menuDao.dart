import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/itemModel.dart';
import 'package:foodville/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final menuDbProvider = Provider<MenuDao>((ref) =>MenuDao());

class MenuDao {
    Future addItem(Item item) async{
        var url = Uri.parse(baseUrl + "api/menu");
        print("ITEM ID:" + item.id);
        print("ITEM NAME: " + item.name);
        print(json.encode(Item().toJson(item)));
        var response = await http.post(
          url,
          headers: {"Content-Type": "application/json" , "Accept": "application/json"},
          body: json.encode(Item().toJson(item)),
        );

        print(response.body);
        return response.body;
    }

    Future deleteItem() async{
      //TODO
    }

    Future getAllItems(String id) async{
      var url = Uri.parse(baseUrl + "api/menu/$id");
      var client = http.Client();
      var response = await client.get(url);
      print(response.body);
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      var jsonList = jsonResponse['menu'];
      List<Item> itemsList = [];

      jsonList.forEach((jsonItem) {
          itemsList.add(Item.fromJson(jsonItem));
      });

      return itemsList;
    }
}