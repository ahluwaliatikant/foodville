import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/database/foodCourtDao.dart';

final foodCourtsController = StateNotifierProvider<FoodCourtNotifier , AsyncValue<List<FoodCourt>>>((ref) => FoodCourtNotifier(ref.read));

class FoodCourtNotifier extends StateNotifier<AsyncValue<List<FoodCourt>>>{
  FoodCourtNotifier(this.read) : super(AsyncLoading()){
    _init();
  }

  final Reader read;

  void _init() async {
    //await read(databaseProvider).initDatabase();
    List<FoodCourt> listOfItems = await read(foodCourtDbProvider).getAllFoodCourts();
    state = AsyncData(listOfItems);
  }

  void addFoodCourt(FoodCourt foodCourt) async{
    state = AsyncLoading();
    await read(foodCourtDbProvider).addFoodCourt(foodCourt);
    List<FoodCourt> foodCourts = await read(foodCourtDbProvider).getAllFoodCourts();
    state = AsyncData(foodCourts);
  }
  
}