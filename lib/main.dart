import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/DailySchedule.dart';
import 'view/LogGlucose.dart';
import 'view/LogExercise.dart';
// import 'view/GlucosePage.dart';
// import 'view/HomePage.dart';
import 'controller/LogBookMgr.dart';
import 'controller/UserMgr.dart';
import 'model/GlucoseRecord.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    LogBookMgr x = new LogBookMgr(
      'glucose',
      'nishasnr@gmail.com',
    );
    x.getGlucoseRecords();
    /*print('hello');
  print(x.glucoseLogBook);
  print('hi again');
  List<GlucoseRecord> y = await x.getGlucoseRecords();
  print('and again');
  print(y.length);
  for (int i = 0; i < y.length; i++) {
    print(y[i].glucoseLevel);
  }
  print('final one, haha');*/
    runApp(MyAppLogExercisePage());
  }

/*class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MyAppLogExercisePage();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyAppLogExercisePage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MyAppLogExercisePage();
      },
    );
  }
}
*/
