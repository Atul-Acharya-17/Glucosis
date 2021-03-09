import 'package:flutter/material.dart';
import 'NavigationBar.dart';
import 'AppBar.dart';

void main() {
  runApp(LogbookPage());
}

class LogbookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: CommonAppBar(
            title: 'Log Book',
          ),
          body: LogBookPageBody(),
          bottomNavigationBar: NavigationBar(),
        ),
      ),
    );
  }
}

class LogBookPageBody extends StatelessWidget {
  final double tabsHeight = 50;
  final Color lightPink = Color.fromRGBO(255, 224, 228, 1);
  final Color darkPink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            tabLogbook(),
            Expanded(
              child: logBookView(),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox tabLogbook() {
    return SizedBox(
      height: tabsHeight,
      child: AppBar(
        backgroundColor: lightPink,
        bottom: TabBar(
          indicator: BoxDecoration(
            color: darkPink,
          ),
          tabs: [
            tabLabel('Glucose'),
            tabLabel('Exercise'),
            tabLabel('Food'),
          ],
        ),
      ),
    );
  }

  Tab tabLabel(String label) {
    return Tab(
      icon: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }

  TabBarView logBookView() {
    return TabBarView(
      children: [
        TabLogBookView(type: 'Glucose'),
        TabLogBookView(type: 'Exercise'),
        TabLogBookView(type: 'Food'),
      ],
    );
  }
}

class TabLogBookView extends StatelessWidget {
  TabLogBookView({this.type});
  final String type;
  final double tabsHeight = 48;
  final Color lightPink = Color.fromRGBO(255, 224, 228, 1);
  final Color darkPink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              tabInterval(),
              //intervalView(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox tabInterval() {
    return SizedBox(
      height: tabsHeight,
      child: AppBar(
        backgroundColor: Colors.white,
        bottom: TabBar(
          indicatorColor: darkPink,
          tabs: [
            tabLabel('7 days'),
            tabLabel('1 month'),
            tabLabel('3 months'),
            tabLabel('6 months'),
          ],
        ),
      ),
    );
  }

  Tab tabLabel(String label) {
    return Tab(
      icon: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }
}
