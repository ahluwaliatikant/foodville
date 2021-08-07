import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/providers/completedOrdersProvider.dart';
import 'package:foodville/providers/currentOrdersProvider.dart';
import 'package:foodville/providers/myParameter.dart';
import 'package:foodville/providers/restaurantProvider.dart';
import 'package:foodville/screens/completedRestaurantOrders.dart';
import 'package:foodville/screens/currentRestaurantOrders.dart';
import 'package:foodville/models/restaurantModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodville/screens/selectARolePage.dart';

class RestaurantHome extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(restaurantsController);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: GestureDetector(
                onTap: () {
                  context
                      .read(currentOrdersController(MyParameter(
                              id: state.data.value.id, isUser: false))
                          .notifier)
                      .refreshState(state.data.value.id);

                  context
                      .read(completedOrdersController(MyParameter(
                              id: state.data.value.id, isUser: false))
                          .notifier)
                      .refreshState(state.data.value.id);
                },
                child: Icon(
                  Icons.refresh,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectARole()),
                          (route) => false);
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
          toolbarHeight: 150,
          centerTitle: true,
          leadingWidth: 60,
          automaticallyImplyLeading: false, // Don't show the leading button
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              state.when(data: (Restaurant restaurant) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 18.0),
                  child: CachedNetworkImage(
                    imageUrl: restaurant.logoImageUrl,
                    imageBuilder: (context, imageProvider) => Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.scaleDown),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              }, loading: () {
                return Center(child: CircularProgressIndicator());
              }, error: (Object error, StackTrace st) {
                return Center(
                  child: Text(
                    "ERROR: ${error.toString()}",
                  ),
                );
              }),
              state.when(data: (Restaurant restaurant) {
                return Text(restaurant.name,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)));
              }, loading: () {
                return Center(child: CircularProgressIndicator());
              }, error: (Object error, StackTrace st) {
                return Center(
                  child: Text(
                    "ERROR: ${error.toString()}",
                  ),
                );
              }),
            ],
          ),
          backgroundColor: mainRedColor,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Text(
                "Current\nOrders",
                textAlign: TextAlign.center,
              ),
              Text(
                "Completed\nOrders",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            state.when(data: (Restaurant restaurant) {

              context
                  .read(currentOrdersController(MyParameter(
                  id: state.data.value.id, isUser: false))
                  .notifier)
                  .refreshState(state.data.value.id);

              context
                  .read(completedOrdersController(MyParameter(
                  id: state.data.value.id, isUser: false))
                  .notifier)
                  .refreshState(state.data.value.id);

              return CurrentOrders(
                resId: restaurant.id,
                restaurant: restaurant,
              );
            }, loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            }, error: (Object error, StackTrace stackTrace) {
              return Center(
                child: Text(
                  "ERROR: ${error.toString()}",
                ),
              );
            }),
            state.when(data: (Restaurant restaurant) {

              context
                  .read(currentOrdersController(MyParameter(
                  id: state.data.value.id, isUser: false))
                  .notifier)
                  .refreshState(state.data.value.id);

              context
                  .read(completedOrdersController(MyParameter(
                  id: state.data.value.id, isUser: false))
                  .notifier)
                  .refreshState(state.data.value.id);

              return CompletedOrders(
                resId: restaurant.id,
              );
            }, loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            }, error: (Object error, StackTrace stackTrace) {
              return Center(
                child: Text(
                  "ERROR: ${error.toString()}",
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
