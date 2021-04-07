// import 'package:flutter/material.dart';
// import 'package:flutterapp/controller/ReminderMgr.dart';
// import 'package:flutterapp/model/GlucoseReminders.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutterapp/controller/'

// import 'UserMgr.dart';

// /// Controller class for user's blood glucose reading reminders. Retrieves user's reminders from a glucose reminder database.
// class GlucoseReminderMgr extends ReminderMgr {
//   static CollectionReference glucoseReminders =
//       FirebaseFirestore.instance.collection('GlucoseReminders');
// // fetch all reeminders and set to userMgr in a list
//   GlucoseReminderMgr() : super();

//   Future<void> addGlucoseReminder(DateTime timing) {
//     String email = UserManager.getCurrentUserEmail();

//     glucoseReminders
//         .doc(email)
//         .collection('reminders')
//         .add({'timings': timing})
//         .then(set)
//         .then((value) => print('Glucose record added!'))
//         .catchError((error) => print('Failed to add record: $error'));
//   }
// }
