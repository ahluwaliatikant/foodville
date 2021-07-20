import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/screens/itemCard.dart';
import 'package:foodville/widgets/newItemCard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/menuProvider.dart';
import 'package:foodville/models/itemModel.dart';
class ViewMenu extends StatelessWidget {

  final String id;
  ViewMenu({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
          "Menu",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
            )
          ),
        ),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (ctx, watch,child) {
            return watch(menuController(id)).when(
                data: (List<Item> itemsList){
                  itemsList.forEach((element) {
                    print(element.name);
                  });
                  return ListView.builder(
                      itemCount: itemsList.length,
                      itemBuilder: (context , index){
//                        return ItemCard(
//                          dishName: itemsList[index].name,
//                          dishDesc: itemsList[index].description,
//                          dishPrice: itemsList[index].price.toString(),
//                          imageUrl: itemsList[index].imageUrl,
//                        );
                          return NewItemCard(
                            dishPrice: itemsList[index].price.toString(),
                            dishName: itemsList[index].name,
                            dishDesc: itemsList[index].description,
                            imageUrl: itemsList[index].imageUrl,
                          );
                      }
                  );
            },
            loading: (){
              return Center(child: CircularProgressIndicator(),);
            },
            error: (Object error , StackTrace stackTrace){
              return Text("Error" + error.toString());
            });
          },
        ),
      ),
    );
  }
}
