import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/models/foodCourtModel.dart';
import 'package:foodville/providers/foodCourtProvider.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectFoodCourt extends ConsumerWidget {
  @override
  Widget build(BuildContext context , ScopedReader watch) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final state = watch(foodCourtsController);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainRedColor,
        centerTitle: true,
        title: Text(
          "Select a Food Court",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: state.when(
              data: (List<FoodCourt> list){
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 12 , right: 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: matteBlack,
                          ),
                          hintText: "Search",
                        ),
                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context , index){
                          return ListTile(
                            title: Text(
                              list[index].name,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: mainRedColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            subtitle: Text(
                              list[index].location,
                            ),
                          );
                        },
                        separatorBuilder: (context , index){
                          return Divider(
                            color: mainRedColor,
                            thickness: 2,
                          );
                        },
                        itemCount: list.length
                    ),
                  ],
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
                    "Error",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 30,
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
