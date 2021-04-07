import 'package:flutter/material.dart';
import 'package:flutterapp/view/HomePage.dart';
//import './ExercisePage.dart';

/// Navigation bar UI component for use on all screens.
class NavigationBar extends StatelessWidget {
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double navigationBarHeight = 0.062 * height;
    final double iconWidth = 0.195 * width;

    return Container(
      height: navigationBarHeight,
      width: width,
      color: Colors.white10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
            child: Image.asset(
              'images/home.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/glucose');
            },
            child: Image.asset(
              'images/glucose.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/medication');
            },
            child: Image.asset(
              'images/medicine.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/food');
            },
            child: Image.asset(
              'images/diet.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fill,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/exercise');
            },
            child: Image.asset(
              'images/exercise.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
