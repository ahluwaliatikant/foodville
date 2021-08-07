import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:equatable/equatable.dart';

class MyParameter extends Equatable {
  final String userId;
  final String status;
  final bool isUser;

  MyParameter({
    this.userId,
    this.status,
    this.isUser
  });

  @override
  List<Object> get props => [userId, status];
}

final orderController = StateNotifierProvider.family<OrderNotifier , AsyncValue<List<Order>> ,  MyParameter>((ref , myParameter) => OrderNotifier(ref.read , myParameter));

class OrderNotifier extends StateNotifier<AsyncValue<List<Order>>>{
  final MyParameter myParameter;

  OrderNotifier(this.read , this.myParameter) : super(AsyncLoading()){
    _init(myParameter.userId , myParameter.status);
  }

  final Reader read;

  void _init(String userId , String status) async {
    print("INSIDE INIT");
    print("USER ID: $userId");
    if(myParameter.isUser){
      List<Order> newList = await read(orderDbProvider).getOrdersByUser(userId , status);
      state = AsyncData(newList);
    }else{
      List<Order> newList = await read(orderDbProvider).getOrdersByRestaurant(userId, status);
      state = AsyncData(newList);
    }
  }

  void refreshState(String id , String status) async {
    if(myParameter.isUser){
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByUser(id , status);
      state = AsyncData(newList);
    }else{
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByRestaurant(id, status);
      state = AsyncData(newList);
    }
  }

  Future<int> getNumberOfCurrentOrders(String userId) async{
    List<Order> newList = await read(orderDbProvider).getOrdersByUser(userId, "pending");
    int x = newList.length;
    return x;
  }

  Future<int> getNumberOfCompleted(String userId) async{
    List<Order> newList = await read(orderDbProvider).getOrdersByUser(userId, "completed");
    int x = newList.length;
    return x;
  }

}
