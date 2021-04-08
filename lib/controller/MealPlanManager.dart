import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/Recipes.dart';
import 'package:http/http.dart' as http;

class MealPlanMgr{
  String url = 'api.spoonacular.com';
  List<Recipe> recipes = List();


  Future<List<Recipe>> fetchRecipes(Map<String, dynamic> request) async {
    request['apiKey'] = 'bd7750a983d1494d8a8698d08faac976';
    print(request);
    final response =
    await http.get(Uri.https(url, 'recipes/complexSearch', request),);
    print("Status code"+response.statusCode.toString());
    if (response.statusCode == 200) {
      //print(json.decode(response.body)['results']);
      recipes = (json.decode(response.body)['results'] as List)
          .map((data){
        return new Recipe.fromJSON(data);})
          .toList();
      print (recipes);
      return recipes;
    } else {
      throw Exception('Failed to load recipe info');
    }
  }


}