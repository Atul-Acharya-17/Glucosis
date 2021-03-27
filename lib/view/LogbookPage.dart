import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../model/Data.dart';
import '../view/NavigationBar.dart';
import '../view/AppBar.dart';
import '../controller/LogBookMgr.dart';

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
  final Map chartDataMap = LogBookMgr.getLogBookPageData();

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
        BooksView(
          book: 'Glucose',
          chartData: chartDataMap['Glucose'],
        ),
        BooksView(
          book: 'Exercise',
          chartData: chartDataMap['Exercise'],
        ),
        BooksView(
          book: 'Food',
          chartData: chartDataMap['Food'],
        ),
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
  BooksView({
    this.book,
    this.chartData,
  });

  final String book;
  final List<Data> chartData;
  final Color lightPink = Color.fromRGBO(254, 179, 189, 1);
  final Color darkPink = Color.fromRGBO(255, 42, 103, 1);
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final double margin = 5;
  final double padding = 5;
  final Map textMap = {
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
            chartData: chartData,
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
              textMap[book],
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
          DownloadHistoryButton(
            width: width,
            borderRadius: borderRadius,
            padding: padding,
            iconSize: iconSize,
            normalFontSize: normalFontSize,
            lightPink: lightPink,
          )
        ],
      ),
    );
  }
}

class Graph extends StatefulWidget {
  Graph({
    this.logBook,
    this.chartData,
    this.graphsHeight,
    this.padding,
    this.borderRadius,
  });

  final String logBook;
  final List<Data> chartData;
  final double graphsHeight;
  final double padding;
  final double borderRadius;

  @override
  GraphState createState() => GraphState(
        logBook: logBook,
        chartData: chartData,
        graphsHeight: graphsHeight,
        padding: padding,
        borderRadius: borderRadius,
      );
}

class GraphState extends State<Graph> {
  GraphState({
    this.logBook,
    this.chartData,
    this.graphsHeight,
    this.padding,
    this.borderRadius,
  });

  final String logBook;
  final List<Data> chartData;
  final double graphsHeight;
  final double padding;
  final double borderRadius;

  final Map textMap = {
    'Glucose': 'Blood Glucose Levels',
    'Exercise': 'Exercise Levels',
    'Food': 'Calorie Intake Levels',
  };
  final Color lightPink = Color.fromRGBO(255, 224, 228, 1);
  final Color darkPink = Color.fromRGBO(254, 179, 189, 1);

  DateTime minDate;
  DateTime maxDate;
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
    minDate = getMinDate(chartData);
    maxDate = getMaxDate(chartData);
  }

  @override
  void dispose() {
    rangeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          chart(),
          rangeSelector(),
        ],
      ),
    );
  }

  SfCartesianChart chart() {
    return SfCartesianChart(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
      ),
      title: ChartTitle(
        text: textMap[logBook],
      ),
      primaryXAxis: DateTimeAxis(
        minimum: minDate,
        maximum: maxDate,
        isVisible: true,
        rangeController: rangeController,
      ),
      primaryYAxis: NumericAxis(
        isVisible: true,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
      ),
      series: <SplineSeries<Data, DateTime>>[
        SplineSeries<Data, DateTime>(
          dataSource: chartData,
          animationDuration: 0,
          xValueMapper: (Data levels, _) => levels.x,
          yValueMapper: (Data levels, _) => levels.y,
          color: darkPink,
          enableTooltip: true,
          markerSettings: MarkerSettings(
            color: darkPink,
            isVisible: true,
          ),
        ),
      ],
    );
  }

  SfRangeSelector rangeSelector() {
    return SfRangeSelector(
      activeColor: darkPink,
      inactiveColor: lightPink,
      min: minDate,
      max: maxDate,
      interval: 2,
      showTicks: true,
      showLabels: true,
      controller: rangeController,
      child: Container(
        height: 70,
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(
            minimum: minDate,
            maximum: maxDate,
            isVisible: false,
          ),
          primaryYAxis: NumericAxis(
            isVisible: false,
          ),
          plotAreaBorderWidth: 0,
          series: <SplineSeries<Data, DateTime>>[
            SplineSeries<Data, DateTime>(
              dataSource: chartData,
              xValueMapper: (Data levels, _) => levels.x,
              yValueMapper: (Data levels, _) => levels.y,
              color: darkPink,
            )
          ],
        ),
      ),
    );
  }
}

class DownloadHistoryButton extends StatelessWidget {
  final double width;
  final double borderRadius;
  final double padding;
  final double iconSize;
  final double normalFontSize;
  final Color lightPink;

  DownloadHistoryButton({
    this.width,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.normalFontSize,
    this.lightPink,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
