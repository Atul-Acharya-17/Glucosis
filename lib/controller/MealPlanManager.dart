import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Recipes.dart';

class MealPlanMgr{
  String url = 'api.spoonacular.com';
  List<Recipe> recipes = List();


  Future<List<Recipe>> fetchRecipes(Map<String, dynamic> request) async {
    request['apiKey'] = '9449825925d342f0a9418ca8f44c9d3c';
    print(request);
    final response =
    await http.get(Uri.https(url, 'recipes/complexSearch', request),);
    print("Status code"+response.statusCode.toString());
    if (response.statusCode == 200) {

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