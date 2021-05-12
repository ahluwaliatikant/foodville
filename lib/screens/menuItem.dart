//import 'package:flutter/material.dart';
//
//class MenuItem extends StatefulWidget {
//  final String dishName;
//  final String dishDesc;
//  final String dishPrice;
//  final Function returnData;
//
//  MenuItem({this.dishName, this.dishDesc, this.dishPrice , this.returnData});
//
//  @override
//  _MenuItemState createState() => _MenuItemState();
//}
//
//class _MenuItemState extends State<MenuItem> {
//  @override
//  Widget build(BuildContext context) {
//    double height = MediaQuery.of(context).size.height;
//    double width = MediaQuery.of(context).size.width;
//
//    return Stack(
//      children: [
//        Container(
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(30),
//          ),
//          height: height * 0.20,
//          child: Flexible(
//            child: Card(
//              color: Colors.redAccent,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(30),
//              ),
//              elevation: 15,
//              child: Row(
//                children: [
//                  SizedBox(
//                    width: width * 0.28,
//                  ),
//                  Container(
//                    width: width * 0.7,
//                    decoration: BoxDecoration(
//                        color: Colors.redAccent,
//                        borderRadius: BorderRadius.only(
//                          topRight: Radius.circular(30),
//                          bottomRight: Radius.circular(30),
//                        )),
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Container(
//                          padding: EdgeInsets.only(
//                              left: 5, right: 15, top: 10, bottom: 10),
//                          width: width * 0.78,
//                          child: Row(
//                            mainAxisSize: MainAxisSize.max,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: [
////                              SizedBox(
////                                width: 10,
////                              ),
//                              Text(
//                                widget.dishName,
//                                style: TextStyle(
//                                  fontSize: 20,
//                                  color: Colors.white,
//                                ),
//                              ),
////                              SizedBox(
////                                width: 100,
////                              ),
//                              Text("₹${widget.dishPrice}",
//                                  style: TextStyle(
//                                    fontSize: 30,
//                                    fontWeight: FontWeight.bold,
//                                    color: Colors.white,
//                                  )),
//                            ],
//                          ),
//                        ),
//                        Container(
//                          padding:
//                              EdgeInsets.only(left: 5, right: 15, bottom: 10),
//                          child: Text(
//                            widget.dishDesc,
//                            style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 12,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ),
//        ),
//        Positioned(
//          left: 15,
//          top: 15,
//          child: Container(
//            height: 100,
//            width: 100,
//            decoration: BoxDecoration(
//                color: Colors.blue, borderRadius: BorderRadius.circular(20)),
//            child: Center(
//              child: Icon(
//                Icons.camera_alt,
//                size: 30,
//              ),
//            ),
//          ),
//        ),
//        Positioned(
//          bottom: 10,
//          right: 10,
//          child: ElevatedButton(
//            child: Text("Add",
//                style: TextStyle(
//                    color: Colors.black,
//                    fontSize: 20,
//                    fontWeight: FontWeight.bold)),
//            style: ButtonStyle(
//              backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
//              textStyle: MaterialStateProperty.all(TextStyle(
//                  color: Colors.black,
//                  fontSize: 20,
//                  fontWeight: FontWeight.bold)),
//              padding: MaterialStateProperty.all(
//                  EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10)),
//              shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(50))),
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//}
