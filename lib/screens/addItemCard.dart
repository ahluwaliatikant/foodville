import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddItemCard extends StatefulWidget {
  AddItemCard({this.returnData});

  @override
  final Function(String name, String desc, String price) returnData;
  _AddItemCardState createState() => _AddItemCardState();
}

class _AddItemCardState extends State<AddItemCard> {
  @override
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
//      color: Colors.redAccent,
      height: height * 0.55,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 10,
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              height: height * 0.2,
              child: Center(
                child: Icon(Icons.camera_alt),
              ),
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.5,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
//                            border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(50),
//                            ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Price",
//                          border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(50),
//                          ),
                      ),
                    ),
                    TextFormField(
                      controller: _descController,
                      decoration: InputDecoration(
                        hintText: "Description",
//                          border: OutlineInputBorder(
//                            borderRadius: BorderRadius.circular(50),
//                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => widget.returnData(
                  _nameController.text.toString(),
                  _descController.text.toString(),
                  _priceController.text.toString()),
              child: Text("Add"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xFF30475e)),
                textStyle: MaterialStateProperty.all(
                    TextStyle(color: Colors.white, fontSize: 20)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
