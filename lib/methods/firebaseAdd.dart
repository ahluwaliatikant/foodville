import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodville/models/order.dart';
import 'package:foodville/models/restaurant.dart';
import 'package:foodville/models/item.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseAdd {
  addUser(String uid , String name , String phone , List<Order> currentOrders , List<Order> previousOrders , File file) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/users/$uid").putFile(file);
    if(snapshot.state == TaskState.success){
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await users.doc(uid).set({
        'uid' : uid,
        'name' : name,
        'phoneNumber' : phone,
        'currentOrders' : currentOrders,
        'previousOrders' : previousOrders,
        'profilePicUrl' : downloadUrl,
      });
    }
    else{
      throw(
          "Unsuccessful"
      );
    }

  }

  addCourt(String name , String location , List<Restaurant> restaurants){
    CollectionReference foodCourts = FirebaseFirestore.instance.collection('food_courts');

    foodCourts.doc(name).set({
      'name': name,
      'location': location,
      'restaurants': restaurants,
      'searchKey': name[0].toUpperCase(),
    });
  }


  addRestaurant(String foodCourtName ,String id , String name , List<Order> pendingOrders , List<Order> completedOrders , File file) async{
    CollectionReference foodCourts = FirebaseFirestore.instance.collection('food_courts');
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/restaurants/$id").putFile(file);
    if(snapshot.state == TaskState.success){
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await foodCourts.doc(foodCourtName).collection('restaurants').doc(id).set({
        'id': id,
        'name': name,
        'imageUrl': downloadUrl,
        'pendingOrders': pendingOrders,
        'completedOrders': completedOrders,
      });
    }
    else{
      throw(
        "Unsuccessful"
      );
    }
  }


  addMenuItem(String foodCourtName , String resID , String dishName , String dishDesc , String dishPrice , File image) async {
    var priceOfDish = double.parse(dishPrice);
    CollectionReference restaurants = FirebaseFirestore.instance.collection('food_courts').doc(foodCourtName).collection('restaurants');
    var storage = FirebaseStorage.instance;
    TaskSnapshot snapshot = await storage.ref().child("images/restaurants/$resID/$dishName").putFile(image);

    if(snapshot.state == TaskState.success){
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      await restaurants.doc(resID).collection('menu').add({
        'dishName': dishName,
        'dishPrice':dishPrice,
        'dishDescription':dishDesc,
        'dishImageUrl': downloadUrl,
      });
    }
    else{
      throw(
          "Unsuccessful"
      );
    }


  }


  addOrderToRestaurantPlacedOrders(String foodCourtName , String resId , Order order){
      CollectionReference restaurants = FirebaseFirestore.instance.collection('food_courts').doc(foodCourtName).collection('restaurants');
      restaurants.doc(resId).collection('placedOrders').doc(order.placedByUserId).set(order.toJson());
  }

  addOrderToUserPlacedOrders(String uid , Order order){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(order.placedByUserId).collection('placedOrders').doc(order.restaurantId).set(order.toJson());
  }


//  addToRestaurantCompletedOrders(String foodCourtName , String resId , Map<String , dynamic> order){
//    CollectionReference restaurants = FirebaseFirestore.instance.collection('food_courts').doc(foodCourtName).collection('restaurants');
//
//    restaurants.doc(resId).collection('completedOrders').doc(order['placedByUserId']).set(order);
//  }
}