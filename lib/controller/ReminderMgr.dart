import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/model/MedicationReminder.dart';
//import 'package:firebase_core/firebase_core.dart';
//import '../model/User.dart';

/// Abstract class for reminder controllers.
abstract class ReminderMgr {
  CollectionReference medicationReminders;

  ReminderMgr(String email) {
    Future<void> addReminder() {}
  }
}
