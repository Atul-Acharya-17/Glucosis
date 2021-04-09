import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:flutterapp/model/MedicationReminder.dart';
import 'package:flutterapp/model/Reminder.dart';

/// Controller that handles in-app reminders
class ReminderMgr {
  static CollectionReference glucoseReminders =
      FirebaseFirestore.instance.collection('GlucoseReminders');
  static CollectionReference medicationReminders =
      FirebaseFirestore.instance.collection('MedicationReminders');
  final databaseReference = FirebaseFirestore.instance;
  final userEmail = FirebaseAuth.instance.currentUser.email;
  bool isLoading = true; //can be used in future development
  static List<bool> glucoseDismissed = new List<bool>();
  static List<bool> medicationDismissed = new List<bool>();

  /// Returns a list of all Medication reminders
  static Future<List<MedicationReminder>> getMedicationReminders(
      userEmail) async {
    List<MedicationReminder> medReminderList = [];
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
                    timing: DateTime.fromMicrosecondsSinceEpoch(
                      doc['timing'].microsecondsSinceEpoch,
                    ),
                  ),
                );
                print("added to list");
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));
    print("med reminder list returned");
    return medReminderList;
  }

  ///Returns a list of all glucose reminders
  static Future<List<GlucoseReminder>> getGlucoseReminders(userEmail) async {
    List<GlucoseReminder> glucReminderList = [];
    await FirebaseFirestore.instance
        .collection('GlucoseReminders')
        .doc(userEmail)
        .collection('reminders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                glucReminderList.add(
                  GlucoseReminder(
                    timings: DateTime.fromMicrosecondsSinceEpoch(
                      doc['timings'].microsecondsSinceEpoch,
                    ),
                  ),
                );
                print("added to list");
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));

    print("gluc rem list returned");
    return glucReminderList;
  }

  /// Gets a list of all reminders
  static List<Map> getRemindersHomePage() {
    List<Map> reminderList = [];

    List<GlucoseReminder> allGlucose = UserManager.getGlucoseReminders();

    if (allGlucose != null && glucoseDismissed != null) {
      int end = allGlucose.length - glucoseDismissed.length;
      for (int i = 0; i < end; i++) {
        print('entered');
        glucoseDismissed.add(false);
      }
    }

    DateTime nextGlucose;
    if (allGlucose != null && allGlucose.length != 0) {
      nextGlucose = allGlucose
          .reduce((a, b) =>
              ((!a.compareTo(DateTime.now()) && b.compareTo(DateTime.now())) ||
                      (b.compareTo(DateTime.now()) && a.compareTo(b.timings)) ||
                      (a.compareTo(b.timings) && !a.compareTo(DateTime.now())))
                  ? b
                  : a)
          .timings;
    }

    if (allGlucose != null) {
      for (int i = 0; i < allGlucose.length; i++) {
        if (allGlucose[i].timings == nextGlucose ||
            (0 < allGlucose[i].timings.difference(DateTime.now()).inMinutes &&
                allGlucose[i].timings.difference(DateTime.now()).inMinutes <=
                    15)) {
          if (i < glucoseDismissed.length && !glucoseDismissed[i]) {
            reminderList.add(
              allGlucose[i].toMap(
                i,
              ),
            );
          }
        } else {
          glucoseDismissed[i] = false;
        }
      }
    }

    List<MedicationReminder> allMedication =
        UserManager.getMedicationReminders();
    if (allMedication != null && medicationDismissed != null) {
      int end2 = allMedication.length - medicationDismissed.length;
      for (int i = 0; i < end2; i++) {
        medicationDismissed.add(false);
      }
    }

    DateTime nextMedication;
    if (allMedication != null && allMedication.length != 0) {
      nextMedication = allMedication
          .reduce((a, b) =>
              ((!a.compareTo(DateTime.now()) && b.compareTo(DateTime.now())) ||
                      (b.compareTo(DateTime.now()) && a.compareTo(b.timing)) ||
                      (a.compareTo(b.timing) && !a.compareTo(DateTime.now())))
                  ? b
                  : a)
          .timing;
    }
    // print(nextMedication);

    if (allMedication != null) {
      for (int i = 0; i < allMedication.length; i++) {
        if (allMedication[i].timing == nextMedication ||
            (0 < allMedication[i].timing.difference(DateTime.now()).inMinutes &&
                allMedication[i].timing.difference(DateTime.now()).inMinutes <=
                    15)) {
          if (i < medicationDismissed.length && !medicationDismissed[i]) {
            reminderList.add(
              allMedication[i].toMap(
                i,
              ),
            );
          }
        } else {
          medicationDismissed[i] = false;
        }
      }
    }

    // print(glucoseDismissed);
    // print(medicationDismissed);

    return reminderList;
  }

  /// Dismisses reminders
  static void setDismissed(
    String type,
    int index,
  ) {
    // print('Setting dismissed');
    if (type == 'Glucose') {
      glucoseDismissed[index] = true;
      // print(glucoseDismissed);
    } else if (type == 'Medication') {
      medicationDismissed[index] = true;
      // print(medicationDismissed);
    }
  }

  /// Below is the code that helps implement factory pattern

  /// Adds a new Reminder to the database
  static Future<void> addReminder(
      String reminderType, Map<String, dynamic> data) async {
    String email = UserManager.getCurrentUserEmail();

    if (reminderType == "Medication") {
      MedicationReminder M = new MedicationReminder(
        medicineName: data['medicineName'],
        dosage: data['dosage'],
        type: data['type'],
        timing: data['timing'],
      );

      UserManager.addMedicationReminder(M);
      //setting object in database
      await medicationReminders
          .doc(email)
          .collection('reminders')
          .add({
            'name': data['medicineName'],
            'dosage': data['dosage'],
            'timing': data['timing'],
            'type': data['type'],
          })
          .then((value) => print('Medication Reminder added!'))
          .catchError((error) => print('Failed to add reminder: $error'));
    } else if (reminderType == "Glucose") {
      GlucoseReminder G = new GlucoseReminder(timings: data['timings']);

      UserManager.addGlucoseReminder(G);
      //updating database with new object
      await glucoseReminders
          .doc(email)
          .collection('reminders')
          .add({'timings': data['timings']})
          .then((value) => print('Glucose record added!'))
          .catchError((error) => print('Failed to add record: $error'));
    } else {
      print("Invalid Reminder Type");
    }

    print('Done');
  }

  /// Deletes a reminder from the database
  static Future<void> deleteReminder(String reminderType, String key) async {
    if (reminderType == 'Medication') {
      await FirebaseFirestore.instance
          .collection('MedicationReminders')
          .doc(UserManager.getCurrentUserEmail())
          .collection('reminders')
          .doc(key)
          .delete();
      await UserManager.setMedicationReminders();
    } else if (reminderType == 'Glucose') {
      await FirebaseFirestore.instance
          .collection('GlucoseReminders')
          .doc(UserManager.getCurrentUserEmail())
          .collection('reminders')
          .doc(key)
          .delete();
      await UserManager.setGlucoseReminders();
    } else
      print('Invalid reminderType');
  }

  /// Gets all Reminders witth their key
  static Future<Map<String, Reminder>> getRemindersWithKey(
      String reminderType) async {
    Map<String, Reminder> reminderMap = {};

    if (reminderType == 'Medication') {
      await FirebaseFirestore.instance
          .collection('MedicationReminders')
          .doc(UserManager.getCurrentUserEmail())
          .collection('reminders')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  reminderMap[doc.id] = MedicationReminder(
                    dosage: doc['dosage'],
                    medicineName: doc['name'],
                    type: doc['type'],
                    timing: DateTime.fromMicrosecondsSinceEpoch(
                      doc['timing'].microsecondsSinceEpoch,
                    ),
                  );
                  print("added to list");
                })
              })
          .catchError((error) => print('Failed to get logbook: $error'));
    } else if (reminderType == 'Glucose') {
      await FirebaseFirestore.instance
          .collection('GlucoseReminders')
          .doc(UserManager.getCurrentUserEmail())
          .collection('reminders')
          .get()
          .then((QuerySnapshot querySnapshot) => {
                querySnapshot.docs.forEach((doc) async {
                  reminderMap[doc.id] = GlucoseReminder(
                    timings: DateTime.fromMicrosecondsSinceEpoch(
                      doc['timings'].microsecondsSinceEpoch,
                    ),
                  );
                  print("added to list");
                })
              })
          .catchError((error) => print('Failed to get logbook: $error'));
    } else {
      print('Invalid Reminder Type');
    }

    return reminderMap;
  }
}
