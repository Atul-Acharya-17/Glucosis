import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutterapp/view/LogbookPage.dart';
import 'NavigationBar.dart';
import 'AppBar.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Overview',
      ),
      body: Body(),
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
            Graphs(
              borderRadius: borderRadius,
              margin: margin,
              padding: padding,
              graphsHeight: graphsHeight,
              imagesPathList: [
                'images/random.png',
                'images/random.png',
                'images/random.png',
              ],
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogBookPage()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sticky_note_2_outlined),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      'View Log Book',
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
            reminder(
              miniFontSize,
              '9:00 am',
              'Check your blood sugar',
              true,
            ),
            reminder(
              miniFontSize,
              '9:00 am',
              'Take insulin medication',
              false,
            ),
            reminder(
              miniFontSize,
              '9:00 am',
              'Breakfast: vegetable omelette',
              true,
            ),
            reminder(
              miniFontSize,
              '10:00 am',
              'Exercise: 20 sit-ups',
              true,
            ),
          ],
        ),
      ),
    );
  }

  Text time(String timestamp, double fontSize) {
    return Text(
      timestamp,
      style: TextStyle(
        fontSize: fontSize,
        color: green,
      ),
    );
  }

  Text message(String messageString, double fontSize) {
    return Text(
      messageString,
      style: TextStyle(
        fontSize: fontSize,
      ),
    );
  }

  Card reminder(
      double fontSize, String timestamp, String messageString, bool logNow) {
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
        padding: EdgeInsets.fromLTRB(
          2 * padding,
          padding,
          2 * padding,
          padding,
        ),
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
                time(
                  timestamp,
                  fontSize,
                ),
                message(
                  messageString,
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
}

class Graphs extends StatelessWidget {
  Graphs(
      {this.borderRadius,
      this.margin,
      this.padding,
      this.graphsHeight,
      this.imagesPathList});
  final double borderRadius;
  final double margin;
  final double padding;
  final double graphsHeight;
  final List<String> imagesPathList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: graphsHeight,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      items: graphsList(imagesPathList),
    );
  }

  List<Widget> graphsList(List<String> imagesPathList) {
    List<Widget> graphs = List<Widget>(imagesPathList.length);
    for (int i = 0; i < imagesPathList.length; i++) {
      graphs[i] = graph(imagesPathList[i]);
    }

    return graphs;
  }

  Widget graph(String imagePath) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 2 * margin),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
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
