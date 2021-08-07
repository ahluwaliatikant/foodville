import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';
import 'package:foodville/database/orderDao.dart';
import 'package:foodville/providers/myParameter.dart';

final completedOrdersController = StateNotifierProvider.family<CompletedOrderNotifier , AsyncValue<List<Order>> ,  MyParameter>((ref , myParameter) => CompletedOrderNotifier(ref.read , myParameter));


class CompletedOrderNotifier extends StateNotifier<AsyncValue<List<Order>>>{
  final MyParameter myParameter;

  CompletedOrderNotifier(this.read , this.myParameter) : super(AsyncLoading()){
    _init(myParameter.id);
  }

  final Reader read;

  void _init(String id) async {
    print("INSIDE INIT");
    print("ID: $id");
    if(myParameter.isUser){
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByUser(id , "completed");
      state = AsyncData(newList);
    }else{
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByRestaurant(id, "completed");
      state = AsyncData(newList);
    }
  }

  void refreshState(String id) async {
    if(myParameter.isUser){
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByUser(id , "completed");
      state = AsyncData(newList);
    }else{
      state = AsyncLoading();
      List<Order> newList = await read(orderDbProvider).getOrdersByRestaurant(id, "completed");
      state = AsyncData(newList);
    }
  }
}