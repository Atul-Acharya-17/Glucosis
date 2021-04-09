import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'RecipeImage.dart';
import '../model/Recipes.dart';

class MainFetchData extends StatefulWidget {
  static final routeName = "/Library";
  @override
  _MainFetchDataState createState() => _MainFetchDataState();

}
class _MainFetchDataState extends State<MainFetchData> {

  List<Recipe> list = List();
  var isLoading = false;
  String url = 'api.spoonacular.com';
  String query = "";
  final searchController = TextEditingController();
  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get(Uri.https(url, 'recipes/complexSearch', {"query": query,
      "number":"5",
      "addRecipeInformation": "true",
      "addRecipeNutrition": "true",
      "apiKey": "c7ee4c84f6b1404dbaacbd158aa5e559"}),);
    print(response.statusCode);
    if (response.statusCode == 200) {

      list = (json.decode(response.body)['results'] as List)
          .map((data){
        return new Recipe.fromJSON(data);})
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load nutrient info');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  new TextFormField(
            controller: searchController,
            onChanged: (val){
              setState(() {
                query = searchController.text.toString();
              });
            },
            decoration: new InputDecoration(
                suffixIcon: new IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: (){ //searchController.addListener(_setQuery);
                      _fetchData();}
                ),
                hintText: 'Search...'
            ),
          ),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            :
        ListView.builder(
            padding: EdgeInsets.only(
              bottom: 20,
            ),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: (){
                    Navigator.pop(context, list[index]);
                  },
                  child: Card(
                      child:
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            RecipeImage(list[index]),
                            Text(
                              list[index].title,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black),
                            ),
                            // Empty space:
                            SizedBox(height: 10.0),
                            Row(
                                children: [
                                  Icon(Icons.timer, size: 20.0),
                                  SizedBox(width: 5.0),
                                  Text(
                                    list[index].time.toString() + " minutes",
                                    style: TextStyle(
                                        fontSize: 20,
                                        //fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black),
                                  ),

                                ]
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "Calories: ${list[index].cal.toString()} kcal" ,
                              style: TextStyle(
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black),
                            ),
                            SizedBox(width: 5.0),
                            Text(
                              "Carbs: ${list[index].carbs.toString()} mg",
                              style: TextStyle(
                                  fontSize: 20,
                                  //fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black),
                            ),
                          ]
                      )
                  )
              );
            }
        )
    );
  }
}