import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/Data.dart';
import '../view/NavigationBar.dart';
import '../view/AppBar.dart';
import '../controller/LogBookMgr.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(
          title: 'Overview',
        ),
        body: Body(),
        bottomNavigationBar: NavigationBar(),
      ),
    );
  }
}

class Body extends StatelessWidget {
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
      child: Container(
        padding: EdgeInsets.all(10),
        color: backgroundColor,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2 * margin),
              child: Graphs(
                logBooks: [
                  'Glucose',
                  'Exercise',
                  'Food',
                ],
                graphsHeight: graphsHeight,
                padding: padding,
                borderRadius: borderRadius,
                color: pink,
              ),
            ),
            Card(
              elevation: 2,
              margin: EdgeInsets.only(bottom: margin),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Container(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    Text(
                      'Log Entry',
                      style: TextStyle(
                        fontSize: normalFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    LogBookIcons(
                      iconSize: iconSize,
                      iconPaths: [
                        'images/user_icon.jpeg',
                        'images/user_icon.jpeg',
                        'images/user_icon.jpeg',
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: margin),
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                padding: EdgeInsets.all(padding),
                onPressed: () {
                  Navigator.of(context).pushNamed('/logbook');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sticky_note_2_outlined),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      'View Log Books',
                      style: TextStyle(
                        fontSize: normalFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: margin),
              padding: EdgeInsets.all(padding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Today at a glance',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: normalFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Reminders(
              margin: margin,
              padding: padding,
              borderRadius: borderRadius,
              fontSize: miniFontSize,
              green: green,
              pink: pink,
              reminders: [
                {
                  'type': 'Glucose',
                  'message': 'Check your blood sugar',
                  'time': '9:00 am',
                },
                {
                  'type': 'Medication',
                  'message': 'Take insulin medication',
                  'time': '10:00 am',
                }
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LogBookIcons extends StatelessWidget {
  LogBookIcons({this.iconSize, @required this.iconPaths});

  final double iconSize;
  final List<String> iconPaths;

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = List<Widget>(iconPaths.length);
    for (int i = 0; i < iconPaths.length; i++) {
      icons[i] = iconButton(iconPaths[i]);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons,
    );
  }

  IconButton iconButton(String iconPath) {
    return IconButton(
      icon: new Image.asset(iconPath),
      iconSize: iconSize,
      onPressed: () {},
    );
  }
}

class Graphs extends StatefulWidget {
  Graphs({
    this.logBooks,
    this.graphsHeight,
    this.padding,
    this.borderRadius,
    this.color,
  });

  final List<String> logBooks;
  final double graphsHeight;
  final double padding;
  final double borderRadius;
  final Color color;

  @override
  GraphsState createState() => GraphsState(
    logBooks: logBooks,
    graphsHeight: graphsHeight,
    padding: padding,
    borderRadius: borderRadius,
    color: color,
  );
}

class GraphsState extends State<Graphs> {
  GraphsState({
    this.logBooks,
    this.graphsHeight,
    this.padding,
    this.borderRadius,
    this.color,
  });

  final List<String> logBooks;
  final double graphsHeight;
  final double padding;
  final double borderRadius;
  final Color color;
  final Map chartDataMap = LogBookMgr.getHomePageData();
  final textMap = {
    'Glucose': 'Blood Glucose Level (7 days)',
    'Exercise': 'Exercise Level (7 days)',
    'Food': 'Calorie Intake Level (7 days)',
  };

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: graphsHeight,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.81,
      ),
      items: graphsList(logBooks),
    );
  }

  List<Widget> graphsList(List<String> logBooks) {
    List<Widget> graphs = List<Widget>(logBooks.length);
    for (int i = 0; i < logBooks.length; i++) {
      graphs[i] = graph(logBooks[i]);
    }

    return graphs;
  }

  Widget graph(String logBook) {
    List<Data> chartData = chartDataMap[logBook];

    return Card(
      elevation: 2,
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
            text: textMap[logBook],
          ),
          series: <ChartSeries>[
            LineSeries<Data, DateTime>(
              dataSource: chartData,
              xValueMapper: (Data datum, _) => datum.dateTime,
              yValueMapper: (Data datum, _) => datum.y,
              color: color,
              markerSettings: MarkerSettings(
                color: color,
                isVisible: true,
              ),
              animationDuration: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class Reminders extends StatefulWidget {
  Reminders({
    this.margin,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.green,
    this.pink,
    this.reminders,
  });

  final double margin;
  final double padding;
  final double borderRadius;
  final double fontSize;
  final Color green;
  final Color pink;
  final List<Map> reminders;

  @override
  RemindersState createState() => RemindersState(
    margin: margin,
    padding: padding,
    borderRadius: borderRadius,
    fontSize: fontSize,
    green: green,
    pink: pink,
    reminders: reminders,
  );
}

class RemindersState extends State<Reminders> {
  RemindersState({
    this.margin,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.green,
    this.pink,
    this.reminders,
  });

  final double margin;
  final double padding;
  final double borderRadius;
  final double fontSize;
  final Color green;
  final Color pink;
  List<Map> reminders;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [];
    reminders.forEach((reminder) {
      columnChildren.add(
        reminderCard(
          fontSize,
          reminder['time'],
          reminder['message'],
          reminder['type'] == 'Glucose' ? true : false,
        ),
      );
    });

    return Column(
      children: columnChildren,
    );
  }

  Card reminderCard(
      double fontSize,
      String timestamp,
      String message,
      bool logNow,
      ) {
    final GestureDetector logNowButton = GestureDetector(
      child: Text(
        'Log now',
        style: TextStyle(
          fontSize: fontSize - 1,
          color: logNow == true ? green : Colors.white,
        ),
      ),
      onTap: () {},
    );
    final GestureDetector dismissButton = GestureDetector(
      child: Text(
        'Dismiss',
        style: TextStyle(
          fontSize: fontSize - 1,
          color: pink,
        ),
      ),
      onTap: () {},
    );

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: margin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        //margin: EdgeInsets.only(bottom: margin),
        padding:
        EdgeInsets.fromLTRB(2 * padding, padding, 2 * padding, padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                timeText(
                  timestamp,
                  fontSize,
                ),
                messageText(
                  message,
                  fontSize,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logNowButton,
                dismissButton,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text timeText(String timestamp, double fontSize) {
    return Text(
      timestamp,
      style: TextStyle(
        fontSize: fontSize,
        color: green,
      ),
    );
  }

  Text messageText(String message, double fontSize) {
    return Text(
      message,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }
}