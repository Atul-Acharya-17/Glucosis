import "package:collection/collection.dart";


class Recipe{
  final String title;
  final num time;
  final List<dynamic> steps;
  final num cal;
  final num carbs;
  final num sugar;
  final String url;
  final num recipeId;
  final String imageUrl;
  final num serving;

  Recipe({this.title, this.time, this.steps,this.cal, this.carbs, this.sugar,this.url, this.imageUrl, this.recipeId,this.serving});

  factory Recipe.fromJSON(Map <String, dynamic> recipe){
    var title = recipe['title'];
    var url = recipe['sourceUrl'];
    var time = recipe['readyInMinutes'];
    var imageUrl = recipe['image'];
    var id = recipe['id'];
    var servings = recipe['servings'];
    Map <String, dynamic> newMap = groupBy(recipe["nutrition"]['nutrients'] as List, (obj) => obj['title']);
    print(newMap);
    List<dynamic> steps = [];
    //print(recipe ['analyzedInstructions']);
    if (recipe['analyzedInstructions'].length != 0 ) {
      var instructions = recipe ['analyzedInstructions'][0]['steps'];

      steps = instructions.map((object) =>
          object['step'].toString()).toList();
      //print(steps);
    }
    print(steps);
    var cal = newMap["Calories"][0]["amount"];
    var sugar = newMap["Sugar"][0]["amount"];
    var carbs  = newMap["Carbohydrates"][0]["amount"];

    return Recipe(
        title: title,
        time: time,
        steps: steps,
        carbs: carbs,
        sugar: sugar,
        cal: cal,
        url: url,
        recipeId: id,
        imageUrl: imageUrl,
        serving: servings
    );

  }

}