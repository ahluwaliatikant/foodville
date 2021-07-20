import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/cartModel.dart';
import 'package:foodville/models/itemModel.dart';

final cartController = StateNotifierProvider<CartNotifier , Cart>((ref) => CartNotifier(ref.read));


class CartNotifier extends StateNotifier<Cart>{
  CartNotifier(this.read) : super(Cart()){
    _init();
  }

  final Reader read;

  void _init() async {
    state = Cart(totalAmount: 0, items: []);
  }

  void addItem(Item item){
    List<Item> itemsList= state.items;
    itemsList.add(item);
    int total = state.totalAmount + item.price;
    Cart newCart = Cart(
      items: itemsList,
      totalAmount: total
    );
    state = newCart;
  }

}