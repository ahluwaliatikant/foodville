import 'package:cached_network_image/cached_network_image.dart';
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
  SelectRestaurant({@required this.foodCourt});

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
            builder: (ctx, watch, child) {
              return watch(restaurantsProviderFamily(foodCourt.id)).when(
                  data: (List<Restaurant> list) {
                return ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlaceOrderScreen(
                                      id: list[index].id,
                                    )));
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(
                          list[index].name,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: mainRedColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        leading: CachedNetworkImage(
                          imageUrl: list[index].logoImageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.scaleDown),
                            ),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: mainRedColor,
                      thickness: 2,
                    );
                  },
                );
              }, loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }, error: (Object error, StackTrace stackTrace) {
                return Center(
                  child: Text("Error" + error.toString()),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
