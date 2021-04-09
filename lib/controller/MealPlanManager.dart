import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/Recipes.dart';
import 'package:http/http.dart' as http;

/// Controller that returns recipes from the Government API
class MealPlanMgr {
  String url = 'api.spoonacular.com';
  List<Recipe> recipes = List();

  /// Retrieves recipes that match the user's request
  Future<List<Recipe>> fetchRecipes(Map<String, dynamic> request) async {
    request['apiKey'] = '4b22e31031d146d7b59b14b654f39d57';
    print(request);
    final response = await http.get(
      Uri.https(url, 'recipes/complexSearch', request),
    );
    print("Status code" + response.statusCode.toString());
    if (response.statusCode == 200) {
      //print(json.decode(response.body)['results']);
      recipes = (json.decode(response.body)['results'] as List).map((data) {
        return new Recipe.fromJSON(data);
      }).toList();
      print(recipes);
      return recipes;
    } else {
      throw Exception('Failed to load recipe info');
    }
  }
}
