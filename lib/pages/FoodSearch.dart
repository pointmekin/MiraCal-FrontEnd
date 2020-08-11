import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';





////////////////////////////////////////
//This is the original code that works by getting the whole
// list of food first and then filter them with the query.
// The problem is that the GET action is done from the previous page
// so it will not do GET again when changing the search query
////////////////////////////////////////




class FoodSearch extends SearchDelegate {

  //final List countryList;
  final List foodList;

  FoodSearch(this.foodList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);

  }


  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

    return Container(
      color: Colors.grey.shade200,
    );
  }

  List foodData;
  fetchFoodData(query) async{
    String searchQuery = query.toString().toLowerCase();
    http.Response response =
    await http.get('https://us-central1-miracalapp-e1718.cloudfunctions.net/app/GET/search/foods/$searchQuery');
    foodData = json.decode(response.body);



  }

  List getSearchedList(query) {
    fetchFoodData(query);
    List searchedFoodData = foodData;
    return searchedFoodData;


  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions

    final suggestionList = query.isEmpty && foodList == null
        ? foodList
        : foodList
            .where((element) =>
                element[0].toString().toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return suggestionList == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(

            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.white,
                child: Container(
                  height: 30,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              suggestionList[index][0].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Energy: " +
                                    suggestionList[index][1].toString() + " Cal",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFE39090)),
                              ),
                              /*
                              Text(
                                "ACTIVE: " +
                                    suggestionList[index]['active'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                              Text(
                                "RECOVERED: " +
                                    suggestionList[index]['recovered']
                                        .toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              Text(
                                "DEATHS: " +
                                    suggestionList[index]['deaths'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                              ),

                               */
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
  }
}


