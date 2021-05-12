import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodville/screens/listOfRestaurants.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:foodville/services/searchService.dart';
import 'package:foodville/screens/restaurantLogin.dart';

class ChooseFoodCourt extends StatefulWidget {
  final String userID;
  final String userName;

  ChooseFoodCourt({this.userID, this.userName});
  @override
  _ChooseFoodCourtState createState() => _ChooseFoodCourtState();
}

class _ChooseFoodCourtState extends State<ChooseFoodCourt> {
  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      //when user types something and backspaces everything
      print("Query: ");
      print(queryResultSet);
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    var capitalizedValue = value.substring(0, 1).toString().toUpperCase() +
        value.substring(1).toString();
    print(capitalizedValue);

    if (queryResultSet.length == 0 && value.length == 1) {
      //the user has typed in only single character
      SearchService()
          .searchByName(capitalizedValue)
          .then((QuerySnapshot snapshot) {
//        for (int i = 0; i < snapshot.docs.length; i++) {
//          queryResultSet.add(snapshot.docs[i].data);
//          setState(() {
//            tempSearchStore.add(queryResultSet[i]);
//          });
//        }
        snapshot.docs.forEach((doc) {
          print(doc["name"]);
          queryResultSet.add({
            'name': doc["name"],
            'location': doc["location"],
          });
        });
      });
      print("Query: ");
      print(queryResultSet);
      print("Temp: ");
      print(tempSearchStore);
    } else {
      print("Query: ");
      print(queryResultSet);
      print("Temp: ");
      print(tempSearchStore);
      setState(() {
        tempSearchStore = [];
      });
//      queryResultSet.forEach((element) {
//        if (element['name'].startsWith(capitalizedValue)) {
//          tempSearchStore.add(element);
//        }
//      });
      queryResultSet.forEach((element) {
        if (element['name'].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element['name'].toLowerCase().indexOf(value.toLowerCase()) == 0) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
    }
    if (tempSearchStore.length == 0 && value.length > 1) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          TextField(
            onChanged: (val) {
              initiateSearch(val);
            },
            decoration: InputDecoration(
              icon: Icon(Icons.search),
              filled: true,
              fillColor: Color(0xFFf7f3e9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              hintText: "Search a Food Court",
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: tempSearchStore.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListOfRestaurants(
                            foodCourtName: tempSearchStore[index]['name'],
                            userId: widget.userID,
                            userName: widget.userName,
                          )));
                },
                child: ListTile(
                  title: Text(tempSearchStore[index]['name']),
                  subtitle: Text(tempSearchStore[index]['location']),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
