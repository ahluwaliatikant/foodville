import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:equatable/equatable.dart';
import 'package:foodville/providers/myParameter.dart';


final currentOrdersController = StateNotifierProvider.family<CurrentOrderNotifier , AsyncValue<List<Order>> ,  MyParameter>((ref , myParameter) => CurrentOrderNotifier(ref.read , myParameter));


class CurrentOrderNotifier extends StateNotifier<AsyncValue<List<Order>>>{
  final MyParameter myParameter;

  CurrentOrderNotifier(this.read , this.myParameter) : super(AsyncLoading()){
    _init(myParameter.id);
  }

  final Reader read;

  void _init(String id) async {
    print("INSIDE INIT");
    print("ID: $id");
    if(myParameter.isUser){
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByUser(id , "pending");
      state = AsyncData(newList);
    }else{
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByRestaurant(id, "pending");
      state = AsyncData(newList);
    }
  }

  void refreshState(String id) async {
    if(myParameter.isUser){
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByUser(id , "pending");
      state = AsyncData(newList);
    }else{
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByRestaurant(id, "pending");
      state = AsyncData(newList);
    }
  }
}