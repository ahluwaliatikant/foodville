import 'package:foodville/models/userModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/database/userDao.dart';

final userController = StateNotifierProvider<UserNotifier , AsyncValue<User>>((ref) => UserNotifier(ref.read));

class UserNotifier extends StateNotifier<AsyncValue<User>>{

  UserNotifier(this.read) : super(AsyncLoading());

  final Reader read;
  
  void addNewUser(User user) async{
    state = AsyncLoading();
    Map<String, dynamic> jsonUser = await read(userDbProvider).addNewUser(user);
    User newUser = User.fromJson(jsonUser);
    state = AsyncData(newUser);
  }

  void getUserById(String userId) async{
    state = AsyncLoading();
    User user = await read(userDbProvider).getUserById(userId);
    if(user == null){
      return null;
    }
    state = AsyncData(user);
  }

}