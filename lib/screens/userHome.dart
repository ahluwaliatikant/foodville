import 'package:flutter/material.dart';
import 'package:foodville/constants.dart';
import 'package:foodville/providers/userProvider.dart';
import 'package:foodville/screens/selectFoodCourt.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodville/models/userModel.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(12.0),
                    child: Consumer(
                      builder: (ctx, watch,child) {
                        return watch(userController).when(
                            data: (User user){
                              return Text(
                                "Hi, ${user.name}",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: matteBlack,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
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
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectFoodCourt()));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    color: mainBeigeColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Place An\nOrder",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: matteBlack,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Image.asset(
                            "images/cheeseburger.png",
                            height: 150,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 200,
                    width: width*0.4,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      color: mainRedColor,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 20,
                            top: 20,
                            child: Icon(
                              Icons.kitchen,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: Text(
                              "In The\nKitchen",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  color: mainBeigeColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  Container(
                    height: 200,
                    width: width*0.4,
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        color: mainRedColor,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 20,
                              top: 20,
                              child: Icon(
                                Icons.fastfood,
                                color: Colors.white,
                                size: 60,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: Text(
                                "Ready To\nCollect",
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: mainBeigeColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        )
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
