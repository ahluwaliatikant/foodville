import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/cartProvider.dart';
import 'package:foodville/widgets/newItemCard.dart';

class ViewCart extends ConsumerWidget {
  final String id;
  ViewCart({this.id});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(cartController);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Your Order",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: state.items.length,
              itemBuilder:(context , index){
                return NewItemCard(
                  dishName: state.items[index].name,
                  dishPrice: state.items[index].price.toString(),
                  dishDesc: state.items[index].description,
                  imageUrl: state.items[index].imageUrl,
                );
              }
          )
        ),
      ),
    );
  }
}
