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
    print("inside init");
    state = new Cart(totalAmount: 0, items: [] , quantityMap: {} , totalNoOfItems: 0);
  }

  int getCartLength(){
    return state.items.length;
  }

  void emptyCart(){
    Cart newCart = new Cart(items: [] , totalAmount: 0 , quantityMap: {} , totalNoOfItems: 0);
    state = newCart;
  }

  void addItem(Item item){

    Cart currentCart = state;
    if(currentCart.quantityMap.containsKey(item.id)){
      currentCart.quantityMap[item.id]++;
      List<Item> itemsList= currentCart.items;
      int total = currentCart.totalAmount + item.price;
      int noOfItems = currentCart.totalNoOfItems+1;
      Cart newCart = Cart(
        items: itemsList,
        totalAmount: total,
        quantityMap: currentCart.quantityMap,
        totalNoOfItems: noOfItems
      );
      state = newCart;
    }
    else{
      List<Item> itemsList= currentCart.items;
      itemsList.add(item);
      int total = currentCart.totalAmount + item.price;
      Map<String,int> currentQuantityMap = state.quantityMap;
      currentQuantityMap[item.id] = 1;
      int noOfItems = currentCart.totalNoOfItems+1;
      Cart newCart = Cart(
        items: itemsList,
        totalAmount: total,
        quantityMap: currentQuantityMap,
        totalNoOfItems: noOfItems,
      );
      state = newCart;
    }
  }

}