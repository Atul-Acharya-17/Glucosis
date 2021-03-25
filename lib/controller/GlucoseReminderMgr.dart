import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Controller class for user's blood glucose reading reminders. Retrieves user's reminders from a glucose reminder database.
class GlucoseReminderMgr extends ReminderMgr {
  CollectionReference glucoseReminders;
  GlucoseReminderMgr(String email) : super(email) {
    this.glucoseReminders = FirebaseFirestore.instance
        .collection('GlucoseReminders')
        .doc(email)
        .collection('reminders');
    print('polpol ${this.glucoseReminders}');
  }

  Future<void> addReminder(GlucoseReminder reminder) {
    return glucoseReminders
        .add({
          'timings': reminder.timings,
        })
        .then((value) => print('Glucose record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }
}
