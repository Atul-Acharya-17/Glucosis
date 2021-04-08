import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/constants.dart';

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
