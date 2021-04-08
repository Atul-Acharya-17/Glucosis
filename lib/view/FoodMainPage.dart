import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/model/Data.dart';
import 'package:flutterapp/view/AppBar.dart';
import 'package:flutterapp/view/NavigationBar.dart';
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

  Widget _buildButton(String text, String page, Icon icon, double width) {
    return Container(
        width: width,
        height: 40,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(page);
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

  Widget _buildMeal(String time, String food) {
    return Card(
        elevation: 5,
        child: Container(
            margin: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(time, style: Theme.of(context).textTheme.headline4),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(food),
              ]),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = 153;
    return Scaffold(
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
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(padding),
                        child: SfCartesianChart(
                          backgroundColor: Colors.white,
                          primaryXAxis: CategoryAxis(), // dk what
                          title: ChartTitle(
                            text: 'Glucose Log Book',
                          ),
                          series: <ChartSeries>[
                            LineSeries<Data, DateTime>(
                              dataSource: LogBookMgr.getHomePageData()['Food'],
                              xValueMapper: (Data datum, _) => datum.dateTime,
                              yValueMapper: (Data datum, _) => datum.y,
                              color: Theme.of(context).accentColor,
                              markerSettings: MarkerSettings(
                                color: Theme.of(context).accentColor,
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
                  Container(
                      child: Column(children: [
                    Row(
                      children: [
                        Text("Current Meal Plan",
                            style: Theme.of(context).textTheme.headline3)
                      ],
                    ),
                    _buildMeal("9:00 AM", "Vegetable omelette + fruits side"),
                    _buildMeal("2:00 PM", "Basil fried brown rice"),
                    _buildMeal("7:00 PM", "Chicken White Bean soup"),
                  ])),

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
  }
}
