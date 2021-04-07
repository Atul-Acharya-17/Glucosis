import 'package:flutter/material.dart';
import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'UserMgr.dart';

/// Controller class for user's blood glucose reading reminders. Retrieves user's reminders from a glucose reminder database.
class GlucoseReminderMgr extends ReminderMgr {
  static CollectionReference glucoseReminders =
      FirebaseFirestore.instance.collection('GlucoseReminders');

  GlucoseReminderMgr(String email) : super();

  static Future<void> addReminder(DateTime timing) {
    String email = UserManager.getCurrentUserEmail();

    glucoseReminders
        .doc(email)
        .collection('reminders')
        .add({'timings': timing})
        .then((value) => print('Glucose record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }
}
