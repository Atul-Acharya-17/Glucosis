import 'package:flutter/material.dart';

import '../model/Recipes.dart';
import 'RecipeImage.dart';
import 'RecipeTitle.dart';


class DetailScreen extends StatefulWidget {
  static final routeName = '/recipe/details';
  final Recipe recipe;
  //final bool inFavorites;

  DetailScreen(this.recipe);//this.inFavorites);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  // bool _inFavorites;
  // StateModel appState;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    // _inFavorites = widget.inFavorites;
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleInFavorites() {
    // setState(() {
    //   _inFavorites = !_inFavorites;
    // });
  }

  @override
  Widget build(BuildContext context) {
    //appState = StateWidget.of(context).state;

    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(
                color: Theme.of(context).accentColor, //change your color here
              ),
              backgroundColor: Colors.white30,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RecipeImage(widget.recipe),
                    RecipeTitle(widget.recipe, 25.0, 25.0),
                  ],
                ),
              ),
              expandedHeight: 400.0,
              pinned: true,
              floating: true,
              elevation: 2.0,
              forceElevated: innerViewIsScrolled,
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(child: Text("Home", style: TextStyle(color: Colors.black),),),
                  Tab(child: Text("Preparation", style: TextStyle(color: Colors.black),),),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[
            IngredientsView({"Calories": widget.recipe.cal, "Carbs": widget.recipe.carbs, "Sugar": widget.recipe.sugar}),
            PreparationView(widget.recipe.steps),
          ],
          controller: _tabController,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     updateFavorites(appState.user.uid, widget.recipe.id).then((result) {
      //       // Toggle "in favorites" if the result was successful.
      //       if (result) _toggleInFavorites();
      //     });
      //   },
      //   child: Icon(
      //     _inFavorites ? Icons.favorite : Icons.favorite_border,
      //     color: Theme.of(context).iconTheme.color,
      //   ),
      //   elevation: 2.0,
      //   backgroundColor: Colors.white,
      // ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final Map<String, dynamic> nutrients;

  IngredientsView(this.nutrients);

  @override
  Widget build(BuildContext context) {
    // List<Widget> children = new List<Widget>();
    // ingredients.forEach((item, row) {
    //   children.add(
    //     new Row(
    //       children: <Widget>[
    //         //new Icon(Icons.done),
    //         new SizedBox(width: 5.0),
    //         new Text(item),
    //       ],
    //     ),
    //   );
    //   // Add spacing between the lines:
    //   children.add(
    //     new SizedBox(
    //       height: 5.0,
    //     ),
    //   );
    // });
    return ListView(
        padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
        children: [
          Row(
            children: <Widget>[
              Icon(Icons.done,color: Colors.green),
              SizedBox(width: 5.0),
              Text("Calories: ${nutrients['Calories']} kcal"),
            ],
          ),
          Row(
              children: <Widget>[
                Icon(Icons.done,color: Colors.green),
                SizedBox(width: 5.0),
                Text("Carbohydrates: ${nutrients['Carbs']} g"),
              ]),
          Row(
              children: <Widget>[
                Icon(Icons.done,color: Colors.green),
                SizedBox(width: 5.0),
                Text("Sugar: ${nutrients['Sugar']} mg"),
              ]),
        ]
    );
  }
}

class PreparationView extends StatelessWidget {
  final List<dynamic> preparationSteps;

  PreparationView(this.preparationSteps);

  @override
  Widget build(BuildContext context) {
    List<Widget> textElements = List<Widget>();
    preparationSteps.forEach((item) {
      print(item);
      textElements.add(
        Text(item),
      );
      // Add spacing between the lines:
      textElements.add(
        SizedBox(
          height: 10.0,
        ),
      );
    });
    return ListView(
      padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 75.0),
      children: textElements,
    );
  }
}