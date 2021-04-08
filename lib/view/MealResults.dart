import 'package:flutter/material.dart';
import 'package:flutterapp/model/Recipes.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'RecipeCard.dart';

class mealResultsPage extends StatefulWidget {
  List <Recipe> recipes;
  static const routeName = '/recipe';
  mealResultsPage(this.recipes);
  @override
  _mealResultsPageState createState() => _mealResultsPageState();
}

class _mealResultsPageState extends State<mealResultsPage> {

  @override
  Widget build(BuildContext context) {
    // Recipe recipe1 = new Recipe(
    //   title: "Pasta with tuna",
    //   time: 45,
    //   imageUrl: "https://spoonacular.com/recipeImages/654959-312x231.jpg",
    //   steps: [" Boil Pasta"],
    //     carbs: 148,
    //   sugar: 20,
    //   cal: 20,
    //   url: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=9449825925d342f0a9418ca8f44c9d3c",
    //   recipeId: 654959
    // );
    // Recipe recipe2 = new Recipe(
    //     title: "Pasta Margherita",
    //     time: 30,
    //     imageUrl: "https://spoonacular.com/recipeImages/511728-312x231.jpg",
    //     steps: [" Boil Pasta"],
    //     carbs: 148,
    //     sugar: 20,
    //     cal: 20,
    //     url: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=9449825925d342f0a9418ca8f44c9d3c",
    //     recipeId: 511728
    // );
    List<RecipeCard> recipeCards = widget.recipes.map((data)=> new RecipeCard(recipe: data))
        .toList();
    return Scaffold(
        appBar: AppBar(
            title:
            Text('Recipes Page', style: TextStyle(color: Colors.pink.shade100)),
            centerTitle: true,
            // add back button functionality
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.pink.shade100,
                ),
                onPressed: (){
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }}),
            backgroundColor: Colors.teal.shade800),
        body: SingleChildScrollView(
            child: Column(
              children: recipeCards,
            )
        )
    );
  }
}
