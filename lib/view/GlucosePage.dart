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
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
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
    );

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

    Widget _buildButton(String text, String page) {
      return ElevatedButton(
          child: Text(text, style: Theme.of(context).textTheme.button),
          style: ElevatedButton.styleFrom(
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            primary: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(page);
          });
    }

    List<Data> chartData = LogBookMgr.getHomePageData()['Glucose'];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Column(
          children: [
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
                    primaryXAxis: DateTimeAxis(
                      intervalType: DateTimeIntervalType.days,
                      interval: 2,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      minimum: chartData.length == 0
                          ? DateTime.now().subtract(new Duration(days: 1))
                          : getMinDate(chartData)
                              .subtract(const Duration(days: 1)),
                      maximum: chartData.length == 0
                          ? DateTime.now().add(new Duration(days: 2))
                          : getMaxDate(chartData).add(const Duration(days: 1)),
                    ), // dk what
                    title: ChartTitle(
                      text: 'Glucose Log Book (mg/dL)',
                    ),
                    series: <ChartSeries>[
                      LineSeries<Data, DateTime>(
                        dataSource: chartData,
                        xValueMapper: (Data datum, _) => datum.dateTime,
                        yValueMapper: (Data datum, _) => datum.y,
                        color: Colors.teal.shade800,
                        markerSettings: MarkerSettings(
                          color: Colors.teal.shade800,
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
            _buildButton('Log Blood Glucose Level', '/logbloodglucose'),
            SizedBox(height: 30),
            _buildButton('Create Daily Schedule', '/dailyschedule'),
          ],
        ),
      ),
    );
  }
}
