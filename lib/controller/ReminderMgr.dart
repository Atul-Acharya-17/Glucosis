import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/controller/UserMgr.dart';

import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:flutterapp/model/MedicationReminder.dart';

import 'package:flutterapp/controller/UserMgr.dart';

class ReminderMgr {
  static CollectionReference glucoseReminders =
      FirebaseFirestore.instance.collection('GlucoseReminders');
  static CollectionReference medicationReminders =
      FirebaseFirestore.instance.collection('MedicationReminders');
  final databaseReference = FirebaseFirestore.instance;
  final userEmail = FirebaseAuth.instance.currentUser.email;
  bool isLoading = true; //can be used in future development

  //This function to be called in userMgr
  void addGlucoseReminder(DateTime timing) async {
    String email = UserManager.getCurrentUserEmail();
    //setting new object in user
    GlucoseReminder G = new GlucoseReminder(timings: timing);
    UserManager.addGlucoseReminder(G);
    //updating database with new object
    await glucoseReminders
        .doc(email)
        .collection('reminders')
        .add({'timings': timing})
        .then((value) => print('Glucose record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  //This function to be called in userMgr
  Future<void> addMedicationReminder(
      String medicineName, String dosage, String type, DateTime timing) async {
    String email = UserManager.getCurrentUserEmail();
    //setting new object in user
    MedicationReminder M = new MedicationReminder(
        medicineName: medicineName, dosage: dosage, type: type, timing: timing);
    UserManager.addMedicationReminder(M);
    //setting object in database
    await medicationReminders
        .doc(email)
        .collection('reminders')
        .add({
          'name': medicineName,
          'dosage': dosage,
          'timing': timing,
          'type': type,
        })
        .then((value) => print('Medication Reminder added!'))
        .catchError((error) => print('Failed to add reminder: $error'));
  }

  //This function returns a list of reminders which need to be displayed in the next 15 mins.
  //HomePage calls this function
  Future<List<Map>> getReminders() async {
    List reminderList = new List();
    //retrieving glucose
    List allGlucose = UserManager.getGlucoseReminders();
    for (int i = 0; i <= allGlucose.length; i++) {
      if (allGlucose[i].timings <= 15) {
        reminderList.add(allGlucose[i].toMap());
      }
    }

    List allMedication = UserManager.getMedicationReminders();
    for (int i = 0; i <= allMedication.length; i++) {
      if (allMedication[i].timing <= 15) {
        reminderList.add(allMedication[i].toMap());
      }
    }

    // await FirebaseFirestore.instance
    //     .collection('GlucoseReminders')
    //     .doc(userEmail)
    //     .collection('reminders')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) => {
    //           querySnapshot.docs.forEach((doc) async {
    //             var now = DateTime.now();
    //             if (doc['timings'] <= now.add(const Duration(minutes: 15))) {
    //               reminderList.add(GlucoseReminder().toMap());
    //               print("added to list");
    //             }
    //           })
    //         })
    //     .catchError((error) => print('Failed to get logbook: $error'));

    //retrieving medication

    return reminderList;
  }

  //This function returns a list of all Medication reminders
  //UserMgr calls this function to maintain a local copy of all existing medication reminders
  Future<List> getMedicationReminders() async {
    List medReminderList = [];
    await FirebaseFirestore.instance
        .collection('MedicationReminders')
        .doc(userEmail)
        .collection('reminders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                medReminderList.add(
                  MedicationReminder(
                    dosage: doc['dosage'],
                    medicineName: doc['name'],
                    type: doc['type'],
                    timing: doc['timings'],
                  ),
                );
                print("added to list");
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));
    return medReminderList;
  }

  //This function returns a list of all glucose reminders
  //User Mgr calls this function to maintain a local copy of all existing glucose reminders
  Future<List> getGlucoseReminders() async {
    List<GlucoseReminder> glucReminderList = [];
    await FirebaseFirestore.instance
        .collection('GlucoseReminders')
        .doc(userEmail)
        .collection('reminders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                glucReminderList.add(
                  GlucoseReminder(timings: doc['timings']),
                );
                print("added to list");
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));
    return glucReminderList;
  }
}
