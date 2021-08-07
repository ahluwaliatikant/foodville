import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/database/restaurantsDao.dart';
import 'package:foodville/models/restaurantModel.dart';

final restaurantsController = StateNotifierProvider<RestaurantNotifier , AsyncValue<Restaurant>>((ref) => RestaurantNotifier(ref.read) );

class RestaurantNotifier extends StateNotifier<AsyncValue<Restaurant>>{
  RestaurantNotifier(this.read) : super(AsyncLoading()){
    _init();
  }

  final Reader read;

  void _init() async {
//    //await read(databaseProvider).initDatabase();
//    List<Restaurant> listOfItems = await read(foodCourtDbProvider).getAllFoodCourts();
//    state = AsyncData(listOfItems);
  }
  void setRestaurantState(Restaurant restaurant) async {
    state = AsyncData(restaurant);
  }

  void refreshRestaurantState(Restaurant restaurant) async {
    state = AsyncData(restaurant);
  }

  void addRestaurant(Restaurant restaurant) async{
    print(restaurant);
    state = AsyncLoading();
    await read(restaurantDbProvider).addRestaurant(restaurant);
    state = AsyncData(restaurant);
  }

}