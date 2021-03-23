import 'package:flutter/material.dart';
import 'package:flutterapp/view/LoginPage.dart';
import 'LoginPage.dart';
import 'HomePage.dart';
import 'CreateAccountPage.dart';
import 'AccountDetailsPage.dart';
import 'ExercisePage.dart';
import 'GlucosePage.dart';
import 'Medication.dart';
import 'ProfilePage.dart';
import 'LogGlucose.dart';
import 'LogExercise.dart';
import 'DailySchedule.dart';
import 'LogbookPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginPage());
      case '/home':
        return MaterialPageRoute(builder: (context) => HomePage());
      case '/signup':
        return MaterialPageRoute(builder: (context) => CreateAccountScreen());
      case '/accdetails':
        return MaterialPageRoute(builder: (context) => AccountDetailsPage());
      case '/exercise':
        return MaterialPageRoute(builder: (context) => ExercisePage());
      case '/glucose':
        return MaterialPageRoute(builder: (context) => GlucosePage());
      case '/medication':
        return MaterialPageRoute(builder: (context) => MedicationPage());
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case '/logbloodglucose':
        return MaterialPageRoute(builder: (context) => LogGlucosePage());
      case '/logexercise':
        return MaterialPageRoute(builder: (context) => LogExercisePage());
      case '/dailyschedule':
        return MaterialPageRoute(builder: (context) => DailySchedule());
      case '/logbook':
        return MaterialPageRoute(builder: (context) => LogBookPage());
    }
  }
}

