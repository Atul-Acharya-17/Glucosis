import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/Data.dart';
import '../view/NavigationBar.dart';
import '../view/AppBar.dart';
import '../view/Drawer.dart';
import '../controller/LogBookMgr.dart';
import '../controller/ReminderMgr.dart';
import 'Drawer.dart';
import '../MyAppIcons.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Overview',
      ),
      body: Body(),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: NavigationBar(),
    );
  }
}

class Body extends StatelessWidget {
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  final double iconSize = 56;
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double graphsHeight = height * 0.3;
    final double normalFontSize = width * 0.06;
    final double miniFontSize = normalFontSize - 5;

    Widget _buildLogBookIcons(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.5, 1.5),
                  blurRadius: 1.0,
                  spreadRadius: 0.2,
                  color: Theme.of(context).shadowColor,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: IconButton(
                icon: Icon(MyAppIcons.glucose),
                iconSize: 30,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pushNamed('/logbloodglucose');
                }),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.5, 1.5),
                  blurRadius: 1.0,
                  spreadRadius: 0.2,
                  color: Theme.of(context).shadowColor,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: IconButton(
                icon: Icon(MyAppIcons.food),
                iconSize: 30,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context).pushNamed('/mealLog');
                }),
          ),
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1.5, 1.5),
                  blurRadius: 1.0,
                  spreadRadius: 0.2,
                  color: Theme.of(context).shadowColor,
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: IconButton(
              icon: Icon(MyAppIcons.exercise),
              iconSize: 30,
              color: Theme.of(context).accentColor,
              onPressed: () {
                Navigator.of(context).pushNamed('/logexercise');
              },
            ),
          ),
        ],
      );
    }

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Theme.of(context).canvasColor,
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
                color: Theme.of(context).backgroundColor,
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
                    SizedBox(
                      height: 10,
                    ),
                    _buildLogBookIcons(context),
                    SizedBox(
                      height: 5,
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
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Reminders(
              margin: margin,
              padding: padding,
              borderRadius: borderRadius,
              fontSize: miniFontSize,
              reminders: ReminderMgr.getRemindersHomePage(),
            ),
          ],
        ),
      ),
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
          primaryXAxis: DateTimeAxis(
            minimum: chartData.length == 0
                ? DateTime.now().subtract(new Duration(days: 1))
                : getMinDate(chartData).subtract(const Duration(days: 1)),
            maximum: chartData.length == 0
                ? DateTime.now().add(new Duration(days: 2))
                : getMaxDate(chartData).add(const Duration(days: 1)),
            intervalType: DateTimeIntervalType.days,
            interval: 2,
            edgeLabelPlacement: EdgeLabelPlacement.shift,
          ),
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
    this.reminders,
  });

  final double margin;
  final double padding;
  final double borderRadius;
  final double fontSize;
  final List<Map> reminders;

  @override
  RemindersState createState() => RemindersState(
        margin: margin,
        padding: padding,
        borderRadius: borderRadius,
        fontSize: fontSize,
        reminders: reminders,
      );
}

class RemindersState extends State<Reminders> {
  RemindersState({
    this.margin,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.reminders,
  });

  final double margin;
  final double padding;
  final double borderRadius;
  final double fontSize;
  List<Map> reminders;

  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [];
    reminders.forEach((reminder) {
      columnChildren.add(
        reminderSlidable(
          fontSize,
          reminder['timings'].toString(),
          reminder['message'],
          reminder['index'],
          reminder['type'] == 'Glucose' ? true : false,
        ),
      );
      columnChildren.add(
        SizedBox(
          height: 5,
        ),
      );
    });

    return Column(
      children: columnChildren,
    );
  }

  Slidable reminderSlidable(
    double fontSize,
    String timestamp,
    String message,
    int index,
    bool logNow,
  ) {
    IconSlideAction deleteButton = IconSlideAction(
      caption: 'Delete',
      color: Theme.of(context).backgroundColor,
      icon: Icons.delete,
      onTap: () {
        setState(() {
          reminders.removeWhere((reminder) =>
              reminder['index'] == index &&
              reminder['type'] == (logNow ? 'Glucose' : 'Medication'));
        });
        print(reminders);
        ReminderMgr.setDismissed(
          logNow ? 'Glucose' : 'Medication',
          index,
        );
      },
    );
    IconSlideAction logNowButton = IconSlideAction(
      caption: 'Log Now',
      color: Theme.of(context).primaryColor,
      icon: Icons.edit,
      onTap: () {
        Navigator.of(context).pushNamed('/logbloodglucose');
      },
    );

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          child: ListTile(
            visualDensity: VisualDensity(
              horizontal: 0,
              vertical: -3.5,
            ),
            title: Text(
              '$timestamp',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            subtitle: Text(
              '$message',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      actions: logNow
          ? <Widget>[
              deleteButton,
              logNowButton,
            ]
          : <Widget>[
              deleteButton,
            ],
    );
  }
}
