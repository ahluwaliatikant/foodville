import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:http/http.dart' as http;
import 'package:foodville/constants.dart';
import 'dart:convert';

final orderDbProvider = Provider<OrderDao>((ref) =>OrderDao() );

class OrderDao {
  Future placeOrder(Order order) async{
    var url = Uri.parse(baseUrl + "api/orders");
    print("ORDER ID" + order.id);
    print("ORDER PLACED BY" + order.placedBy);
    print("ORDER ITEMS:");
    print(order.items);
    print("MERI BODY");
    print(json.encode(Order().toJson(order)));
    var response = await http.post(
        url,
        headers: {"Content-Type": "application/json" , "Accept": "application/json"},
        body: json.encode(Order().toJson(order))
    );

    print (response.body);
    return response.body;
  }

  Future getOrdersByUser(String userId , String status) async{
    var url = Uri.parse(baseUrl + "api/orders/users/$userId/$status");

    var response = await http.get(
        url,
    );

    print("RESPONSE.BODY:");
    print(response.body);
    var jsonResponse = json.decode(response.body);

    List<Order> ordersList = [];
    var jsonList = jsonResponse['orders'];

    jsonList.forEach((e) {
      ordersList.add(Order.fromJson(e));
    });

    return ordersList;
  }

  Future getOrdersByRestaurant(String resId , String status) async{
    var url = Uri.parse(baseUrl + "api/orders/restaurants/$resId/$status");

    var response = await http.get(
      url,
    );

    print("RESPONSE.BODY:");
    print(response.body);
    var jsonResponse = json.decode(response.body);

    List<Order> ordersList = [];
    var jsonList = jsonResponse['orders'];

    jsonList.forEach((e) {
      ordersList.add(Order.fromJson(e));
    });

    return ordersList;
  }

  void updateOrderStatus(String orderId , String status) async{
    var url = Uri.parse(baseUrl + "api/orders");

    var response = await http.put(
      url,
      body: {
        "id": orderId,
        "status": status,
      },
    );

    print(response.statusCode);
  }

  void deleteOrder(String orderId) async{
    print("in delete order");
    print(orderId);
    var url = Uri.parse(baseUrl + "api/orders/$orderId");
    var response  = await http.put(
        url
    );
    print(response.statusCode);
  }
}