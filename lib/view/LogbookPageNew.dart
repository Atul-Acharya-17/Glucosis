import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'NavigationBar.dart';
import 'AppBar.dart';

class LogBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Log Books',
      ),
      body: Body(),
      bottomNavigationBar: NavigationBar(),
    );
  }
}

class Body extends StatelessWidget {
  final double tabsHeight = 45;
  final Color lightPink = Color.fromRGBO(255, 224, 228, 1);
  final Color darkPink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    GlobalKey<ContainedTabBarViewState> _key = GlobalKey();
    ContainedTabBarView containedTabBarView = ContainedTabBarView(
      key: _key,
      tabBarProperties: TabBarProperties(
        height: tabsHeight,
        innerPadding: EdgeInsets.all(1),
        background: Container(color: lightPink),
        indicatorWeight: 0,
        indicator: BoxDecoration(
          color: darkPink,
        ),
      ),
      tabs: [
        booksTabBar('Glucose'),
        booksTabBar('Exercise'),
        booksTabBar('Food'),
      ],
      views: [
        BooksView(book: 'Glucose'),
        BooksView(book: 'Exercise'),
        BooksView(book: 'Food'),
      ],
    );

    return SingleChildScrollView(
      child: Container(
        width: width,
        height: height,
        child: containedTabBarView,
      ),
    );
  }

  Text booksTabBar(String book) {
    return Text(
      book,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

class BooksView extends StatelessWidget {
  BooksView({this.book});
  final String book;
  final Color lightPink = Color.fromRGBO(254, 179, 189, 1);
  final Color darkPink = Color.fromRGBO(255, 42, 103, 1);
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final double margin = 5;
  final double padding = 5;
  final map = {
    'Glucose': 'Blood Glucose Levels Analysis',
    'Exercise': 'Exercise Levels Analysis',
    'Food': 'Calorie Intake Analysis'
  };
  final double borderRadius = 25;
  final double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double normalFontSize = width * 0.06;

    return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child: Column(
        children: [
          Graph(
            logBook: book,
            graphsHeight: height * 0.3,
            padding: padding,
            borderRadius: 10,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              0,
              margin,
              0,
              2 * margin,
            ),
            child: Text(
              map[book],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: darkPink,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: lightPink,
                width: 3,
              ),
            ),
            margin: EdgeInsets.only(
              bottom: 2 * margin,
            ),
            padding: EdgeInsets.all(
              2 * padding,
            ),
            width: double.infinity,
            child: Center(
              child: Text(
                'Placeholder',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            width: 0.7 * width,
            child: RaisedButton(
              color: lightPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: EdgeInsets.all(padding),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_downward,
                    size: iconSize,
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                  Text(
                    'Donwload History',
                    style: TextStyle(
                      fontSize: normalFontSize,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Graph extends StatefulWidget {
  Graph({
    this.logBook,
    this.graphsHeight,
    this.padding,
    this.borderRadius,
  });

  final String logBook;
  final double graphsHeight;
  final double padding;
  final double borderRadius;

  @override
  GraphState createState() => GraphState(
        logBook: logBook,
        graphsHeight: graphsHeight,
        padding: padding,
        borderRadius: borderRadius,
      );
}

class GraphState extends State<Graph> {
  GraphState({
    this.logBook,
    this.graphsHeight,
    this.padding,
    this.borderRadius,
  });

  final String logBook;
  final double graphsHeight;
  final double padding;
  final double borderRadius;
  final map = {
    'Glucose': 'Blood Glucose Levels',
    'Exercise': 'Exercise Levels',
    'Food': 'Calorie Intake Levels',
  };
  final double min = 2.0;
  final double max = 19.0;
  final Color lightPink = Color.fromRGBO(255, 224, 228, 1);
  final Color darkPink = Color.fromRGBO(254, 179, 189, 1);

  SfRangeValues values = SfRangeValues(8.0, 16.0);
  RangeController rangeController;
  SfCartesianChart splineChart;

  @override
  initState() {
    super.initState();
    rangeController = RangeController(
      start: values.start,
      end: values.end,
    );
  }

  @override
  void dispose() {
    rangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Data> chartData = getData();

    return Container(
      child: Column(
        children: [
          chart(
            chartData,
          ),
          rangeSelector(
            chartData,
          ),
        ],
      ),
    );
  }

  List<Data> getData() {
    return <Data>[
      Data(x: 2.0, y: 2.2),
      Data(x: 3.0, y: 3.4),
      Data(x: 4.0, y: 2.8),
      Data(x: 5.0, y: 1.6),
      Data(x: 6.0, y: 2.3),
      Data(x: 7.0, y: 2.5),
      Data(x: 8.0, y: 2.9),
      Data(x: 9.0, y: 3.8),
      Data(x: 10.0, y: 3.7),
      Data(x: 11.0, y: 2.2),
      Data(x: 12.0, y: 3.4),
      Data(x: 13.0, y: 2.8),
      Data(x: 14.0, y: 1.6),
      Data(x: 15.0, y: 2.3),
      Data(x: 16.0, y: 2.5),
      Data(x: 17.0, y: 2.9),
      Data(x: 18.0, y: 3.8),
      Data(x: 19.0, y: 3.7),
    ];
  }

  SfCartesianChart chart(List<Data> chartData) {
    return SfCartesianChart(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
      ),
      title: ChartTitle(
        text: map[logBook],
      ),
      primaryXAxis: NumericAxis(
        minimum: min,
        maximum: max,
        isVisible: true,
        rangeController: rangeController,
      ),
      primaryYAxis: NumericAxis(
        isVisible: true,
      ),
      series: <SplineSeries<Data, double>>[
        SplineSeries<Data, double>(
          dataSource: chartData,
          animationDuration: 0,
          xValueMapper: (Data sales, _) => sales.x,
          yValueMapper: (Data sales, _) => sales.y,
          color: darkPink,
          markerSettings: MarkerSettings(
            color: darkPink,
            isVisible: true,
          ),
        ),
      ],
    );
  }

  SfRangeSelector rangeSelector(List<Data> chartData) {
    return SfRangeSelector(
      activeColor: darkPink,
      inactiveColor: lightPink,
      min: min,
      max: max,
      interval: 2,
      showTicks: true,
      showLabels: true,
      controller: rangeController,
      child: Container(
        height: 70,
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(
            minimum: min,
            maximum: max,
            isVisible: false,
          ),
          primaryYAxis: NumericAxis(
            isVisible: false,
          ),
          plotAreaBorderWidth: 0,
          series: <SplineSeries<Data, double>>[
            SplineSeries<Data, double>(
              dataSource: chartData,
              xValueMapper: (Data sales, _) => sales.x,
              yValueMapper: (Data sales, _) => sales.y,
              color: darkPink,
            )
          ],
        ),
      ),
    );
  }
}

class Data {
  Data({this.x, this.y});
  final double x;
  final double y;
}
