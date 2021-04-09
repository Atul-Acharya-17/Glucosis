import 'package:flutter/material.dart';
import '../model/Recipes.dart';
import 'RecipeImage.dart';
import 'RecipeTitle.dart';
import 'RecipeDetails.dart';
class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final double titleSize;
  // final bool inFavorites;
  // final Function onFavoriteButtonPressed;

  RecipeCard(
      {@required this.recipe,
        // @required this.inFavorites,
        // @required this.onFavoriteButtonPressed
        this.titleSize = 25.0
      });

  @override
  Widget build(BuildContext context) {
    // RawMaterialButton _buildFavoriteButton() {
    //   return RawMaterialButton(
    //     constraints: const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
    //     onPressed: () => onFavoriteButtonPressed(recipe.id),
    //     child: Icon(
    //       // Conditional expression:
    //       // show "favorite" icon or "favorite border" icon depending on widget.inFavorites:
    //       inFavorites == true ? Icons.favorite : Icons.favorite_border,
    //       color: Theme.of(context).iconTheme.color,
    //     ),
    //     elevation: 2.0,
    //     fillColor: Theme.of(context).buttonColor,
    //     shape: CircleBorder(),
    //   );
    // }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new DetailScreen(recipe),
        ),
      ),
      //onTap: ()=>print('Recipe ${recipe.recipeId} was pressed'),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5.0),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // We overlap the image and the button by
              // creating a Stack object:
              Stack(
                children: <Widget>[
                  RecipeImage(recipe),
                  // Positioned(
                  //   child: _buildFavoriteButton(),
                  //   top: 2.0,
                  //   right: 2.0,
                  // ),
                ],
              ),
              RecipeTitle(recipe, 15, titleSize),
            ],
          ),
        ),
      ),
    );
  }
}