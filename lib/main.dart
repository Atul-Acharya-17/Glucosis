import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/DailySchedule.dart';
import 'view/LogGlucose.dart';
import 'view/LogExercise.dart';
import 'view/GlucosePage.dart';
import 'controller/UserMgr.dart';



/*void main() {
  runApp(DailySchedule());
  
}*/


void main() async{
  //runApp(DailySchedule());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
