import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/model/Data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'AppBar.dart';
import 'Drawer.dart';
import 'HomePage.dart';
import 'NavigationBar.dart';

void run() => MaterialApp(
  title: 'Diabetes App',
  home: GlucosePage(),
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
  ),);

/// UI for main glucose page.
class GlucosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      appBar: CommonAppBar(
        title: 'Blood Glucose',
      ),
      body: GlucosePageBody(),
      bottomNavigationBar: NavigationBar(),
    );
  }
}

class GlucosePageBody extends StatelessWidget {
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  final double iconSize = 56;
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double graphsHeight = height * 0.3;
    final double normalFontSize = width * 0.06;
    final double miniFontSize = normalFontSize - 5;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.05),
      child: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.9,
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
                      dataSource: LogBookMgr.getHomePageData()['Glucose'],
                      xValueMapper: (Data datum, _) => datum.dateTime,
                      yValueMapper: (Data datum, _) => datum.y,
                      color: Colors.pink.shade200,
                      markerSettings: MarkerSettings(
                        color: Colors.pink.shade800,
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
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.125,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/logbloodglucose');
                },
                disabledColor: Colors.pink[100],
                color: Colors.pink[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.pink[100])),
                child: Text(
                  'Log Blood Glucose Level',
                  style: TextStyle(color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.125,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/dailyschedule');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Colors.pink[100])),
                disabledColor: Colors.pink[100],
                color: Colors.pink[100],
                child: Text(
                  'Create Daily Schedule',
                  style: TextStyle(color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),

                ),
              ),
          ],
        ),
      ),
    );
  }

}
