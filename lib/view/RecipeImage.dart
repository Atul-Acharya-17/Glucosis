import 'package:flutter/material.dart';
import '../model/Recipes.dart';
class RecipeImage extends StatelessWidget {
  final Recipe recipe;

  RecipeImage(this.recipe);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Image.network(
        recipe.imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}