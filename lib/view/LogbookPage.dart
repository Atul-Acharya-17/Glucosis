import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'NavigationBar.dart';
import 'AppBar.dart';

void main() {
  runApp(LogBookPage());
}

class LogBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(
          title: 'Log Books',
        ),
        body: Body(),
        bottomNavigationBar: NavigationBar(),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final double tabsHeight = 55;
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
        BooksView(label: 'Glucose'),
        BooksView(label: 'Exercise'),
        BooksView(label: 'Food'),
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

  Text booksTabBar(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

class BooksView extends StatelessWidget {
  BooksView({this.label});
  final String label;
  final double tabsHeight = 45;
  final Color lightPink = Color.fromRGBO(255, 224, 228, 1);
  final Color darkPink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ContainedTabBarViewState> _key = GlobalKey();
    ContainedTabBarView containedTabBarView = ContainedTabBarView(
      key: _key,
      tabBarProperties: TabBarProperties(
        height: tabsHeight,
        indicatorColor: darkPink,
        indicatorWeight: 3,
        background: Container(
          color: Colors.white,
        ),
      ),
      tabs: [
        intervalTabBar('7 days'),
        intervalTabBar('1 month'),
        intervalTabBar('3 months'),
        intervalTabBar('6 months'),
      ],
      views: [
        IntervalBookView(
          book: label,
          interval: '7 days',
        ),
        IntervalBookView(
          book: label,
          interval: '1 month',
        ),
        IntervalBookView(
          book: label,
          interval: '3 months',
        ),
        IntervalBookView(
          book: label,
          interval: '6 months',
        ),
      ],
    );

    return Container(
      child: containedTabBarView,
    );
  }

  Text intervalTabBar(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}

class IntervalBookView extends StatelessWidget {
  IntervalBookView({this.book, this.interval});
  final String book;
  final String interval;
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
    final double width = MediaQuery.of(context).size.width;
    final double normalFontSize = width * 0.06;

    return Container(
      padding: EdgeInsets.all(10),
      color: backgroundColor,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: lightPink,
                width: 3,
              ),
            ),
            margin: EdgeInsets.only(bottom: margin),
            padding: EdgeInsets.all(2 * padding),
            width: double.infinity,
            child: Center(
              child: Text(
                'Placeholder for Graphs\n$book\n$interval',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, margin, 0, 2 * margin),
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
            margin: EdgeInsets.only(bottom: 2 * margin),
            padding: EdgeInsets.all(2 * padding),
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
