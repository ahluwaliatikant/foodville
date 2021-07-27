import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/database/menuDao.dart';
import 'package:foodville/models/itemModel.dart';
import 'package:foodville/models/menuModel.dart';

final menuController = StateNotifierProvider.family<MenuNotifier , AsyncValue<List<Item>> , String>((ref , id) => MenuNotifier(ref.read , id));

class MenuNotifier extends StateNotifier<AsyncValue<List<Item>>>{
  final String id;
  MenuNotifier(this.read , this.id) : super(AsyncLoading()){
    _init(id);
  }

  final Reader read;

  void _init(String resId) async {
    print("INSIDE INIT");
    print("RES ID: $resId");
    List<Item> newMenu = await read(menuDbProvider).getAllItems(resId);
    state = AsyncData(newMenu);
  }

  int getMenuLength(){
    return state.data.value.length;
  }

//  void setInitialState(String id) async{
//    List<Item> menu = await read(menuDbProvider).getAllItems(id);
//    state = AsyncData(menu);
//  }

  void addItem(Item item) async{
    state = AsyncLoading();
    await read(menuDbProvider).addItem(item);
    List<Item> newMenu = await read(menuDbProvider).getAllItems(item.restaurantId);
    state = AsyncData(newMenu);
  }

}