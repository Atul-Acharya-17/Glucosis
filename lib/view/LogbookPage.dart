import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart' as gauge;
import 'package:intl/intl.dart';
import '../model/Data.dart';
import '../view/NavigationBar.dart';
import '../view/AppBar.dart';
import '../controller/LogBookMgr.dart';
import 'Drawer.dart';

class LogBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
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
  final Map popUpDataMap = LogBookMgr.getPopUpData();

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
          popUpData: popUpDataMap['Glucose'],
        ),
        BooksView(
          book: 'Exercise',
          chartData: chartDataMap['Exercise'],
          popUpData: popUpDataMap['Exercise'],
        ),
        BooksView(
          book: 'Food',
          chartData: chartDataMap['Food'],
          popUpData: popUpDataMap['Food'],
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
    this.popUpData,
  });

  final String book;
  final List<Data> chartData;
  final List<List<String>> popUpData;
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
    final double fontSize = width * 0.06;

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.5,
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
            Container(height: 300, width: 300, child: getRadialGraph(book)),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                0,
                margin,
                0,
                2 * margin,
              ),
              child: ViewLogBookButton(
                pink: lightPink,
                fontSize: fontSize,
                width: width,
                borderRadius: borderRadius,
                padding: padding,
                popUpData: popUpData,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                0,
                margin,
                0,
                2 * margin,
              ),
              child: DownloadHistoryButton(
                width: width,
                borderRadius: borderRadius,
                padding: padding,
                iconSize: iconSize,
                fontSize: fontSize,
                lightPink: lightPink,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getRadialGraph(String logBook) {
    int min = 0;
    int max;

    var profileDetails = UserManager.getProfileDetails();

    switch (logBook) {
      case 'Glucose':
        min = profileDetails['minGlucose'].toInt();
        max = profileDetails['maxGlucose'].toInt();
        break;
      case 'Exercise':
      // Need to change
        min = 0;
        max = 60;
        break;
      case 'Food':
        min = 0;
        max = profileDetails['targetCalories'];
    }

    Widget radialGraph = gauge.SfRadialGauge(
      axes: <gauge.RadialAxis>[
        gauge.RadialAxis(
          minimum: double.parse(min.toString()),
          maximum: double.parse(max.toString()),
          showLabels: false,
          showTicks: false,
          startAngle: 270,
          endAngle: 270,
          axisLineStyle: gauge.AxisLineStyle(
            thickness: 0.2,
            cornerStyle: gauge.CornerStyle.bothFlat,
            color: Colors.pink.shade100,
            thicknessUnit: gauge.GaugeSizeUnit.factor,
          ),
          pointers: <gauge.GaugePointer>[
            gauge.RangePointer(
              value:
              chartData.length > 0 ? chartData[chartData.length - 1].y : 0,
              cornerStyle: gauge.CornerStyle.bothFlat,
              width: 0.2,
              sizeUnit: gauge.GaugeSizeUnit.factor,
              color: Colors.pink.shade500,
            )
          ],
          annotations: <gauge.GaugeAnnotation>[
            gauge.GaugeAnnotation(
              positionFactor: 0.1,
              angle: 90,
              widget: Text(
                chartData.length > 0
                    ? ((chartData[chartData.length - 1].y)).toStringAsFixed(0) +
                    '/${max.toString()}\n'
                    : 0.toString() +
                    '/${UserManager.getProfileDetails()['maxGlucose'].toInt()}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );

    return radialGraph;
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
  SfRangeValues values;
  RangeController rangeController;
  SfCartesianChart splineChart;

  @override
  initState() {
    super.initState();

    if (chartData.isNotEmpty) {
      minDate = getMinDate(chartData).subtract(const Duration(days: 1));
      maxDate = getMaxDate(chartData).add(const Duration(days: 1));
      values = SfRangeValues(
        minDate,
        maxDate,
      );
      rangeController = RangeController(
        start: values.start,
        end: values.end,
      );
    } else {
      minDate = DateTime.now().subtract(const Duration(days: 1));
      maxDate = DateTime.now().add(const Duration(days: 1));
      values = SfRangeValues(
        minDate,
        maxDate,
      );
      rangeController = RangeController(
        start: values.start,
        end: values.end,
      );
    }
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
          xValueMapper: (Data levels, _) => levels.dateTime,
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
              xValueMapper: (Data levels, _) => levels.dateTime,
              yValueMapper: (Data levels, _) => levels.y,
              color: darkPink,
            )
          ],
        ),
      ),
    );
  }
}

class ViewLogBookButton extends StatefulWidget {
  ViewLogBookButton({
    this.pink,
    this.fontSize,
    this.width,
    this.borderRadius,
    this.padding,
    this.popUpData,
  });

  final Color pink;
  final double fontSize;
  final double width;
  final double borderRadius;
  final double padding;
  final List<List<String>> popUpData;

  @override
  ViewLogBookButtonState createState() => ViewLogBookButtonState(
    pink: pink,
    fontSize: fontSize,
    width: width,
    borderRadius: borderRadius,
    padding: padding,
    popUpData: popUpData,
  );
}

class ViewLogBookButtonState extends State<ViewLogBookButton> {
  ViewLogBookButtonState({
    this.pink,
    this.fontSize,
    this.width,
    this.borderRadius,
    this.padding,
    this.popUpData,
  });

  final Color pink;
  final double fontSize;
  final double width;
  final double borderRadius;
  final double padding;
  final List<List<String>> popUpData;
  DateTime selectedDate = DateTime.now();

  Future<void> popUp() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.teal.shade100,
          scrollable: true,
          title: Text(
            '${DateFormat.yMMMMEEEEd().format(selectedDate)}',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: logBookTable(),
              ),
              Center(
                child: FlatButton(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Table logBookTable() {
    List<TableRow> tableRows = [];
    for (int i = 0; i < popUpData.length; i++) {
      List<String> record = popUpData[i];
      if (i != 0 && record[0] != DateFormat.yMMMMEEEEd().format(selectedDate)) {
        continue;
      }
      List<TableCell> tableRow = [];
      for (int j = 1; j < record.length; j++) {
        String entry = record[j];
        tableRow.add(
          TableCell(
            child: Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Text(
                  entry,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: i == 0 ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      tableRows.add(
        TableRow(
          children: tableRow,
        ),
      );
    }

    return Table(
      border: TableBorder.all(
          color: Colors.teal.shade800, style: BorderStyle.solid),
      defaultColumnWidth: IntrinsicColumnWidth(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: tableRows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.7 * width,
      child: RaisedButton(
        color: pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(padding),
        onPressed: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: DateTime(2000),
            maxTime: DateTime.now(),
            currentTime: selectedDate,
            onConfirm: (date) {
              selectedDate = date;
              popUp();
            },
            locale: LocaleType.en,
          );
        },
        child: Text(
          'View Log Book',
          style: TextStyle(
            fontSize: fontSize,
          ),
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
  final double fontSize;
  final Color lightPink;

  DownloadHistoryButton({
    this.width,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.fontSize,
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
        onPressed: () {
          LogBookMgr.downloadGlucoseLogBook();
        },
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
              'Download History',
              style: TextStyle(
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
gauge.SfRadialGauge(axes: <gauge.RadialAxis>[
                gauge.RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    showLabels: false,
                    showTicks: false,
                    startAngle: 270,
                    endAngle: 270,
                    axisLineStyle: gauge.AxisLineStyle(
                      thickness: 0.2,
                      cornerStyle: gauge.CornerStyle.bothFlat,
                      color: Colors.pink.shade100,
                      thicknessUnit: gauge.GaugeSizeUnit.factor,
                    ),
                    pointers: <gauge.GaugePointer>[
                      gauge.RangePointer(
                          value: 10,
                          cornerStyle: gauge.CornerStyle.bothFlat,
                          width: 0.2,
                          sizeUnit: gauge.GaugeSizeUnit.factor,
                          color: Colors.pink.shade500)
                    ],
                    annotations: <gauge.GaugeAnnotation>[
                      gauge.GaugeAnnotation(
                          positionFactor: 0.1,
                          angle: 90,
                          widget: Text(
                            ((1 * 60) / 100).toStringAsFixed(0) +
                                '/60\n   Min',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ))
                    ])
              ]),
 */