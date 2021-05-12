import 'package:flutter/material.dart';

class OrderCard extends StatefulWidget {
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  List<String> names = ["Atikant" , "Sachin" , "Hello" , "Jacky"];
  List<String> prices = ["200" , "300" , "400" , ""];
  List<Widget> listToBeDisplayed =[
    ListTile(
      title: Text("Pizza"),
      subtitle: Text("200"),
    ),
    ListTile(
      title: Text("Pizza"),
      subtitle: Text("200"),
    ),
    ListTile(
      title: Text("Pizza"),
      subtitle: Text("200"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:ExpansionTile(
            title: Text(
              "Dominos",
            ),
            leading: Text(
              "200",
            ),
            backgroundColor: Colors.redAccent,
            children: listToBeDisplayed
          )
      ),
    );
  }
}
