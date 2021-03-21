import "package:collection/collection.dart";


class Food{
  final String name;
  final num carbs;
  final num sugar;
  final num cal;

  Food._({this.name, this.carbs, this.sugar, this.cal});

  factory Food.fromJSON(Map <String, dynamic> json){

    var name = json["lowercaseDescription"];
    Map <String, dynamic> newMap = groupBy(json["foodNutrients"] as List, (obj) => obj['nutrientName']);

    var carbs = newMap["Carbohydrate, by difference"][0]["value"];
    var sugar = newMap["Sugars, total including NLEA"][0]["value"];
    var cal = newMap["Energy"][0]["value"];

    return Food._(
        name: name,
        carbs: carbs,
        sugar: sugar,
        cal: cal
    );

  }

}