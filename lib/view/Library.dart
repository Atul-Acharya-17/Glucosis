import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Food.dart';

/// UI screen for accessing food library API.
class FoodLibraryPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: MainFetchData(),
    );
  }
}

class MainFetchData extends StatefulWidget {
  @override
  _MainFetchDataState createState() => _MainFetchDataState();

}
class _MainFetchDataState extends State<MainFetchData> {

  List<Food> list = List();
  var isLoading = false;
  String url = 'api.nal.usda.gov';
  String query = "";
  final searchController = TextEditingController();

  _setQuery(){

    setState(() {
      this.query = searchController.text;
      print("ATUL" + searchController.text);
    });
    /*
    if (searchController.text.isEmpty) {
      setState(() {
        this.query = "";
      });
    } else {
      setState(() {
        this.query = searchController.text;
      });
    }*/  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });
    final response =
    await http.get(Uri.https(url, 'fdc/v1/foods/search', {"query": query, "pageNumber": "1", "pageSize": "3", "api_key": "KxLLUebmB2WRgjShtzDTjpIAAP113tqzyDqO1MMD"}),);
    print(response.statusCode);
    if (response.statusCode == 200) {

      list = (json.decode(response.body)['foods'] as List)
          .map((data)=> new Food.fromJSON(data))
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
          title:  new TextField(
            controller: searchController,
            decoration: new InputDecoration(
                suffixIcon: new IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: (){ searchController.addListener(_setQuery);
                    _fetchData();}
                ),
                hintText: 'Search...'
            ),
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: RaisedButton(
        //     child: new Text("Enter"),
        //     onPressed:(){ searchController.addListener(_setQuery);
        //     _fetchData();},
        //   ),
        // ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: new Text(list[index].name),
                trailing: new Text("calories: " + list[index].cal.toString()),
                /*
                trailing: new Image.network(
                  list[index].thumbnailUrl,
                  fit: BoxFit.cover,
                  height: 40.0,
                  width: 40.0,
                ),
                 */
              );
            }));
  }
}
