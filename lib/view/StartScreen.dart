import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/constants.dart';
// import './LoginPage.dart';
// import './CreateAccountPage.dart';
// import './HomePage.dart';
// import './AccountDetailsPage.dart';
// import './ExercisePage.dart';
// import './GlucosePage.dart';
// import './Medication.dart';
// import './ProfilePage.dart';
// import './LogGlucose.dart';
// import './LogExercise.dart';
// import './DailySchedule.dart';
// import './LogbookPage.dart';
import 'RouteGenerator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// Start up class with styling and system navigation
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}
