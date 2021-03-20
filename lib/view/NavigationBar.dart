import 'package:flutter/material.dart';
import 'package:flutterapp/view/HomePage.dart';
//import './ExercisePage.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Image.asset(
              'images/home.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fitHeight,
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
              fit: BoxFit.fitHeight,
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
              fit: BoxFit.fitHeight,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'images/diet.jpg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fitHeight,
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
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
