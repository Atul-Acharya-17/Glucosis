import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:flutterapp/model/MedicationReminder.dart';

class ReminderMgr {
  static CollectionReference glucoseReminders =
      FirebaseFirestore.instance.collection('GlucoseReminders');
  static CollectionReference medicationReminders =
      FirebaseFirestore.instance.collection('MedicationReminders');
  final databaseReference = FirebaseFirestore.instance;
  final userEmail = FirebaseAuth.instance.currentUser.email;
  bool isLoading = true; //can be used in future development
  static List<bool> glucoseDismissed;
  static List<bool> medicationDismissed;

  //This function to be called in userMgr
  static void addGlucoseReminder(DateTime timing) async {
    String email = UserManager.getCurrentUserEmail();
    //setting new object in user
    GlucoseReminder G = new GlucoseReminder(timings: timing);
    print(G);
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
  static Future<void> addMedicationReminder(
      String medicineName, String dosage, String type, DateTime timing) async {
    String email = UserManager.getCurrentUserEmail();
    //setting new object in user
    MedicationReminder M = new MedicationReminder(
      medicineName: medicineName,
      dosage: dosage,
      type: type,
      timing: timing,
    );
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

    print("add medication medication reminder enters");
  }

  //This function returns a list of all Medication reminders
  //UserMgr calls this function to maintain a local copy of all existing medication reminders
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

  //This function returns a list of all glucose reminders
  //User Mgr calls this function to maintain a local copy of all existing glucose reminders
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

  static List<Map> getReminders() {
    List<Map> reminderList = new List();
    // print('getting reminders');
    // print(glucoseDismissed);
    // print(medicationDismissed);

    List<GlucoseReminder> allGlucose = UserManager.getGlucoseReminders();
    if (glucoseDismissed == null && allGlucose != null) {
      glucoseDismissed = List.filled(
        allGlucose.length,
        false,
      );
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
            (0 < allGlucose[i].timings
                .difference(DateTime.now())
                .inMinutes &&
                allGlucose[i].timings
                    .difference(DateTime.now())
                    .inMinutes <=
                    15)) {
          if (!glucoseDismissed[i]) {
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
    if (medicationDismissed == null && allMedication != null) {
      medicationDismissed = List.filled(
        allMedication.length,
        false,
      );
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
            (0 < allMedication[i].timing
                .difference(DateTime.now())
                .inMinutes &&
                allMedication[i].timing
                    .difference(DateTime.now())
                    .inMinutes <=
                    15)) {
          if (!medicationDismissed[i]) {
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

  static void setDismissed(
    String type,
    int i,
  ) {
    // print('Setting dismissed');
    if (type == 'Glucose') {
      glucoseDismissed[i] = true;
      // print(glucoseDismissed);
    } else if (type == 'Medication') {
      medicationDismissed[i] = true;
      // print(medicationDismissed);
    }
  }

  static Future<Map<String, MedicationReminder>>
      getMedicationRemindersWithKey() async {
    Map<String, MedicationReminder> medReminderMap = {};
    await FirebaseFirestore.instance
        .collection('MedicationReminders')
        .doc(UserManager.getCurrentUserEmail())
        .collection('reminders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                medReminderMap[doc.id] = MedicationReminder(
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
    print("med reminder list returned");

    print(medReminderMap.keys);
    return medReminderMap;
  }

  static Future<void> deleteReminder(String key) async {
    await FirebaseFirestore.instance
        .collection('MedicationReminders')
        .doc(UserManager.getCurrentUserEmail())
        .collection('reminders')
        .doc(key)
        .delete();
    await UserManager.setGlucoseReminders();
    await UserManager.setMedicationReminders();
  }
}
