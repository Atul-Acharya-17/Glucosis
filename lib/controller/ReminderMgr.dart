import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/controller/UserMgr.dart';

import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:flutterapp/model/MedicationReminder.dart';

class ReminderMgr {
  final databaseReference = FirebaseFirestore.instance;
  final userEmail = FirebaseAuth.instance.currentUser.email;
  bool isLoading = true;
  List reminderList = new List();

  Future<List<Map>> getReminders() async {
    await FirebaseFirestore.instance
        .collection('GlucoseReminders')
        .doc(UserManager.getCurrentUserEmail())
        .collection('reminders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) async {
        var now = DateTime.now();
        if (doc['timings'] == now.add(const Duration(minutes: 15))) {
          reminderList.add(GlucoseReminder().toMap());
          print("added to list");
        }
      })
    })
        .catchError((error) => print('Failed to get logbook: $error'));

    await FirebaseFirestore.instance
        .collection('MedicationReminders')
        .doc(userEmail)
        .collection('reminders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) async {
        var now = DateTime.now();
        if (doc['timings'] == now.add(const Duration(minutes: 15))) {
          reminderList.add(MedicationReminder().toMap());
          print("added to list");
        }
      })
    })
        .catchError((error) => print('Failed to get logbook: $error'));

    return reminderList;
  }
}