import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRemove {
  removeFromRestaurantPlacedOrders(String foodCourtName, String resId, String uid) {
    CollectionReference placedOrders = FirebaseFirestore.instance
        .collection('food_courts')
        .doc(resId)
        .collection('placedOrders');

    return placedOrders
        .doc(uid)
        .delete()
        .then((value) => print("Deleted the Order From restaurant placed orders"))
        .catchError((error) => print("Failed to delete"));
  }

  removeFromUserPlacedOrders(String uid, String resId) {
    CollectionReference placedOrders = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('placedOrders');

    return placedOrders
        .doc(resId)
        .delete()
        .then((value) => print("Deleted the Order From user placed orders"))
        .catchError((error) => print("Failed to delete"));
  }
}
