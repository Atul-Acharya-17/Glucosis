import 'package:flutter/material.dart';
import './LoginPage.dart';
import './CreateAccountPage.dart';
import './HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      theme: ThemeData(
        // Define the default brightness and colors.
        backgroundColor: Colors.teal.shade800,
        accentColor: Color.fromRGBO(248, 139, 160, 1),
        primaryColor: Color.fromRGBO(248, 181, 188, 1),
        primaryColorLight: Color.fromRGBO(253, 225, 228, 1),

        // Define the default font family.
        fontFamily: 'Roboto',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
            headline3: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            headline4: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800),
            headline5: TextStyle(fontSize: 40, color: Colors.teal.shade800),
            headline6: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/signup': (context) => CreateAccountScreen(),
      },
    );
  }
}
