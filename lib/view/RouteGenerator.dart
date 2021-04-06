import 'package:flutter/material.dart';
import 'package:flutterapp/view/LoginPage.dart';
import 'ChooseMealPlanScreen.dart';
import 'FoodMainPage.dart';
import 'Library.dart';
import 'LoginPage.dart';
import 'HomePage.dart';
import 'CreateAccountPage.dart';
import 'AccountDetailsPage.dart';
import 'ExercisePage.dart';
import 'GlucosePage.dart';
import 'MealLog.dart';
import 'Medication.dart';
import 'ProfilePage.dart';
import 'LogGlucose.dart';
import 'LogExercise.dart';
import 'DailySchedule.dart';
import 'LogbookPage.dart';
import 'UpdateFoodPreference.dart';

/// A class for linking UI pages in the application.
class RouteGenerator {

  /// Function for calling various pages in the UI which allows passing of data through argument [settings].
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
      case '/food':
        return MaterialPageRoute(builder: (context) => FoodMainPage());
      case '/mealLog':
        return MaterialPageRoute(builder: (context) => MealLogPage());
      case '/mealPlanChange':
        return MaterialPageRoute(builder: (context) => ChooseMealPlan());
      case '/library':
        return MaterialPageRoute(builder: (context) => FoodLibraryPage());
      case '/updateFoodPref':
        return MaterialPageRoute(builder: (context) => UpdateFoodPreference());
      case '/password':
        return MaterialPageRoute(builder: (context) => PasswordPage());

    }
  }
}

