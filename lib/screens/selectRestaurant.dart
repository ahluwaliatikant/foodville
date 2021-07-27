import 'package:flutter/material.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:foodville/providers/restaurantsProvider.dart';
import 'package:foodville/screens/placeOrderScreen.dart';
import 'package:foodville/screens/setMenu.dart';
import 'package:foodville/screens/viewMenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectRestaurant extends StatelessWidget {

  final FoodCourt foodCourt;
  SelectRestaurant({
    @required
    this.foodCourt
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
          "Select a Restaurant",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Consumer(
            builder: (ctx, watch,child) {
              return watch(restaurantsProviderFamily(foodCourt.id)).when(
                  data: (List<Restaurant> list){
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context , index){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PlaceOrderScreen(id: list[index].id,)));
                            },
                            child: ListTile(
                              title: Text(list[index].name),
                            ),
                          );
                        }
                    );
                  },
                  loading: (){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  error: (Object error, StackTrace stackTrace){
                    return Center(
                      child: Text("Error" + error.toString()),
                    );
                  }
              );
            },
          ),
        ),
      ),
    );
  }
}
