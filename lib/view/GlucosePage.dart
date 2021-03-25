import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'HomePage.dart';
import 'NavigationBar.dart';

void run() => MaterialApp(
      home: GlucosePage(),
    );

/// UI for main glucose page.
class GlucosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      child: Column(
        children: [
          Card(
            elevation: 5,
            child: Text('Placeholder Graph'),
            // Graphs(
            //   borderRadius: borderRadius,
            //   padding: padding,
            //   graphsHeight: graphsHeight,
            //   //imagesPathList: [
            //   //  'images/random.png',
            //   //],
            // ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/logbloodglucose');
            },
            disabledColor: Colors.pink[100],
            color: Colors.pink[100],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.pink[100])),
            child: Text(
              'Log blood glucose level',
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 30),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/dailyschedule');
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.pink[100])),
            disabledColor: Colors.pink[100],
            color: Colors.pink[100],
            child: Text(
              'Create daily schedule',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
