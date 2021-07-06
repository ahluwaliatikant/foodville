import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/database/restaurantsDao.dart';
import 'package:foodville/models/restaurantModel.dart';

//final singleDetailDealProvider = StateNotifierProvider<MapNotifier>((ref) {
//  final location = ref.watch(locationProvider);
//  return MapNotifier(location.data?.value);
//});

final restaurantsProviderFamily = FutureProvider.family<List<Restaurant> , String>((ref , id) async{
    print(id);
    print(ref.read(restaurantDbProvider).getAllRestaurantsOfAFoodCourt(id).toString());
    return await ref.read(restaurantDbProvider).getAllRestaurantsOfAFoodCourt(id);
});