import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/orderProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/orderModel.dart';

class ViewUserOrders extends ConsumerWidget {
  final String userId;
  ViewUserOrders({this.userId});
  @override
  Widget build(BuildContext context , ScopedReader watch) {

    final state = watch(orderController(MyParameter(userId: userId, status: "pending")),);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
          "Your Orders",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: state.when(
            data: (List<Order> orders){
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text(
                      orders[index].restaurant,
                    ),
                  );
                },
              );
            },
            loading: (){
              return Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (Object error , StackTrace stackTrace){
              return Center(
                child: Text(
                  "ERROR ${error.toString()}"
                ),
              );
            }
        )
      ),
    );
  }
}
