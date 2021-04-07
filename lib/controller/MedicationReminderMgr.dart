// import 'package:flutter/material.dart';
// import 'package:flutterapp/controller/ReminderMgr.dart';
// import 'package:flutterapp/controller/UserMgr.dart';
// import 'package:flutterapp/model/MedicationReminder.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// /// Controller class for user's medication reminders. Retrieves user's reminders from a medication reminder database.
// class MedicationReminderMgr extends ReminderMgr {
//   static CollectionReference medicationReminders =
//       FirebaseFirestore.instance.collection('MedicationReminders');

//   MedicationReminderMgr({String medicineName, String dosage, String type, DateTime timing}) : super(){

//   }
//   static Future<void> addMedicationReminder(
//     String medicineName, String dosage, String type, DateTime timing) {
//     String email = UserManager.getCurrentUserEmail();

//     medicationReminders
//         .doc(email)
//         .collection('reminders')
//         .add({
//           'name': medicineName,
//           'dosage': dosage,
//           'timing': timing,
//           'type': type,
//         })
//         .then((value) => print('Medication Reminder added!'))
//         .catchError((error) => print('Failed to add reminder: $error'));
//   }
// }
