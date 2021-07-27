import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:equatable/equatable.dart';

class MyParameter extends Equatable {


  final String userId;
  final String status;

  MyParameter({
    this.userId,
    this.status,
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
    List<Order> newList = await read(orderDbProvider).getOrdersByUser(userId , status);
    state = AsyncData(newList);
  }

}
