import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/controller/MealPlanManager.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import 'package:flutterapp/model/Data.dart';
import 'package:flutterapp/model/Recipes.dart';
import 'package:flutterapp/view/AppBar.dart';
import 'package:flutterapp/view/NavigationBar.dart';
import 'package:flutterapp/view/RecipeCard.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

import 'Drawer.dart';

void main() => runApp(
      MaterialApp(
        title: 'Diabetes App',
        home: FoodMainPage(),
        theme: ThemeData(
          // Define the default brightness and colors.
          primaryColor: Colors.teal.shade800,
          backgroundColor: Colors.pink.shade100,

          // Define the default font family.
          fontFamily: 'Roboto',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
              headline3: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline4: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800),
              headline5: TextStyle(fontSize: 40, color: Colors.teal.shade800),
              headline6: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ),
      ),
    );

/// UI for main food page.
class FoodMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MealLogPageState();
  }
}

class MealLogPageState extends StatefulWidget {
  @override
  MealLogForm createState() => MealLogForm();
}

class MealLogForm extends State<MealLogPageState> {
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  MealPlanMgr mgr = new MealPlanMgr();

  String _foodPreference = "";

  Widget _buildButton(String text, String page, Icon icon, double width) {
    return Container(
        width: width,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () async {
            await Navigator.of(context).pushNamed(page);
            setState(() {
              _foodPreference =
                  "${UserManager.getProfileDetails()['foodPreference']}";
            });
          },
          icon: icon,
          label: Text(text, style: Theme.of(context).textTheme.button),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Theme.of(context).primaryColor))),
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).primaryColor)),
        ));
  }

  Future<List<Widget>> _buildRecipeCards(context) async {
    setState(() {
      _foodPreference = "${UserManager.getProfileDetails()['foodPreference']}";
    });
    Map<String, dynamic> request = {
      "diet": _foodPreference,
      "sort": "popularity",
      "number": "3",
      "addRecipeInformation": "true",
      "addRecipeNutrition": "true",
      "minCarbs": "0",
      //"minCalories": [int.parse(cal)-200,0].reduce((curr, next) => curr > next? curr: next).toString(),
      "minCalories": "0",
      "minSugar": "0",
    };
    List<Recipe> _popularRecipe = await mgr.fetchRecipes(request);
    print(_popularRecipe);
    print(UserManager.getProfileDetails()['foodPreference']);
    List<RecipeCard> recipes = _popularRecipe.map((data) {
      return RecipeCard(recipe: data, titleSize: 17);
    }).toList();

    return recipes;
  }

  // Widget _buildMeal(Recipe) {
  //   return Card(
  //       elevation: 5,
  //       child: Container(
  //           margin: EdgeInsets.all(10),
  //           child:
  //               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //             Text(time, style: Theme.of(context).textTheme.headline4),
  //             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
  //               Text(food),
  //             ]),
  //           ])));
  // }

  @override
  Widget build(BuildContext context) {
    //double progressValue = 153;
    return FutureBuilder<List<Widget>>(
        future: _buildRecipeCards(context),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          Widget child;

          if (snapshot.hasData) {
            child = Scaffold(
                endDrawer: CustomDrawer(),
                appBar: CommonAppBar(title: "Food Main Page"),
                bottomNavigationBar: NavigationBar(),
                body: SingleChildScrollView(
                    child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(padding),
                                child: SfCartesianChart(
                                  backgroundColor: Colors.white,
                                  primaryXAxis: DateTimeAxis(
                                    intervalType: DateTimeIntervalType.days,
                                    interval: 2,
                                    edgeLabelPlacement:
                                        EdgeLabelPlacement.shift,
                                  ), // dk what
                                  title: ChartTitle(
                                    text: 'Calorie Intake (kcal)',
                                  ),
                                  series: <ChartSeries>[
                                    LineSeries<Data, DateTime>(
                                      dataSource:
                                          LogBookMgr.getHomePageData()['Food'],
                                      xValueMapper: (Data datum, _) =>
                                          datum.dateTime,
                                      yValueMapper: (Data datum, _) => datum.y,
                                      color: Theme.of(context).backgroundColor,
                                      markerSettings: MarkerSettings(
                                        color:
                                            Theme.of(context).backgroundColor,
                                        isVisible: true,
                                      ),
                                      animationDuration: 0,
                                    ),
                                  ],
                                ),
                              ),
                              // Graphs(
                              //   borderRadius: borderRadius,
                              //   padding: padding,
                              //   graphsHeight: graphsHeight,
                              //   //imagesPathList: [
                              //   //  'images/random.png',
                              //   //],
                              // ),
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildButton(
                              "Log Meal Entry",
                              '/mealLog',
                              Icon(
                                Icons.sticky_note_2_outlined,
                                size: 18,
                                color: Colors.white,
                              ),
                              230),
                          SizedBox(height: 20),
                          // Container(
                          //     child: Column(children: [
                          //   Row(
                          //     children: [
                          //       Text("Current Meal Plan",
                          //           style: Theme.of(context).textTheme.headline3)
                          //     ],
                          //   ),
                          //   _buildMeal("9:00 AM", "Vegetable omelette + fruits side"),
                          //   _buildMeal("2:00 PM", "Basil fried brown rice"),
                          //   _buildMeal("7:00 PM", "Chicken White Bean soup"),
                          // ])),
                          Row(
                            children: [
                              Text("Recipes for you",
                                  style: Theme.of(context).textTheme.headline1)
                            ],
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 340,
                              aspectRatio: 16 / 16,
                              viewportFraction: 0.8,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                            ),
                            items: snapshot.data,
                          ),
                          SizedBox(height: 15),
                          _buildButton(
                            "Update Food Preference",
                            "/updateFoodPref",
                            Icon(
                              Icons.edit_outlined,
                              size: 18,
                            ),
                            300,
                          ),
                        ]))));
          } else if (snapshot.hasError) {
            child = Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            child = Column(children: [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              //Padding(
              //padding: EdgeInsets.only(top: 16),
              //child: Text('Awaiting result...'),
              //)
            ]);
          }
          return child;
        });
  }
}
