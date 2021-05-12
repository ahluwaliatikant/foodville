import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/models/item.dart';
import 'package:foodville/models/order.dart';

class Restaurant {
  String id;
  String restaurantName;
  List<Item> menu;
  List<Order> pendingOrders;
  List<Order> completedOrders;
}