import 'package:flutter/material.dart';
import '../MyAppIcons.dart';

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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0.5),
            blurRadius: 5.0,
            spreadRadius: 0.5,
            color: Colors.black,
            //color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      height: navigationBarHeight,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/home', (route) => false);
            },
            child: Container(
              height: navigationBarHeight,
              width: iconWidth,
              color: Theme.of(context).backgroundColor,
              child: Icon(MyAppIcons.home,
                  size: 30, color: Theme.of(context).primaryColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/glucose');
            },
            child: Container(
              height: navigationBarHeight,
              width: iconWidth,
              color: Theme.of(context).backgroundColor,
              child: Icon(MyAppIcons.glucose,
                  size: 30, color: Theme.of(context).primaryColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/medication');
            },
            child: Container(
              height: navigationBarHeight,
              width: iconWidth,
              color: Theme.of(context).backgroundColor,
              child: Icon(MyAppIcons.medicine,
                  size: 30, color: Theme.of(context).primaryColor),
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
            child: Container(
              height: navigationBarHeight,
              width: iconWidth,
              color: Theme.of(context).backgroundColor,
              child: Icon(MyAppIcons.exercise,
                  size: 30, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
