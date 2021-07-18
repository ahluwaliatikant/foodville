import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/menuProvider.dart';
import 'package:foodville/models/itemModel.dart';

class PlaceAnOrder extends StatelessWidget {

  final String resId;
  PlaceAnOrder({this.resId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer(
          builder: (ctx, watch,child) {
            return watch(menuController(resId)).when(
                data: (List<Item> itemsList){
                  return ListView.builder(
                      itemCount: itemsList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          title: Text(itemsList[index].name),
                        );
                      }
                  );
                },
                loading: (){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (Object error , StackTrace stackTrace){
                  return Text("Error" + error.toString());
                }
            );
          },
        ),
      ),
    );
  }
}
