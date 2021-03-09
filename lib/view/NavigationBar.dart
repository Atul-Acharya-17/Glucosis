import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double navigationBarHeight = 0.07 * height;
    final double iconWidth = 0.195 * width;
    return Container(
      height: navigationBarHeight,
      width: width,
      color: pink,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'images/home.jpeg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fitHeight,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'images/glucose.jpeg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fitHeight,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'images/medicine.jpeg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fitHeight,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'images/diet.jpeg',
              height: navigationBarHeight,
              width: iconWidth,
              fit: BoxFit.fitHeight,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'images/exercise.jpeg',
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
