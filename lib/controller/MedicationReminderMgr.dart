import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/model/MedicationReminder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Controller class for user's medication reminders. Retrieves user's reminders from a medication reminder database.
class MedicationReminderMgr extends ReminderMgr {
  CollectionReference medicationReminders;
  MedicationReminderMgr(String email) : super(email) {
    this.medicationReminders = FirebaseFirestore.instance
        .collection('MedicationReminders')
        .doc(email)
        .collection('reminders');
  }

  Future<void> addReminder(MedicationReminder reminder) {
    return medicationReminders
        .add({
          'Medication Name': reminder.medicineName,
          'Dosage': reminder.dosage,
          'Timing': reminder.timing,
          'Type': reminder.type,
        })
        .then((value) => print('Medication Reminder added!'))
        .catchError((error) => print('Failed to add reminder: $error'));
  }
}
