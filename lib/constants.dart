import 'package:flutter/material.dart';
import 'package:flutterapp/controller/UserMgr.dart';

import 'view/RouteGenerator.dart';

Widget materialApp = MaterialApp(
  initialRoute: '/login',
  theme: ThemeData(
    // Define the default brightness and colors.
    backgroundColor: Colors.teal.shade800,
    accentColor: Color.fromRGBO(248, 139, 160, 1),
    primaryColor: Color.fromRGBO(248, 181, 188, 1),
    primaryColorLight: Color.fromRGBO(253, 225, 228, 1),
    shadowColor: Color.fromRGBO(186, 186, 186, 1),
    canvasColor: Color.fromRGBO(236, 236, 236, 1),

    // Define the default font family.
    fontFamily: 'Inter',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
        button: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        bodyText2: TextStyle(fontSize: 16, color: Colors.black),
        display1: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal.shade800),
        headline5: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.teal.shade800),
        headline3: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        headline4: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.teal.shade800),
        headline6: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)).apply(
      bodyColor: Colors.black,
      displayColor: Colors.teal.shade800,
    ),
  ),
  onGenerateRoute: RouteGenerator.generateRoute,
);
