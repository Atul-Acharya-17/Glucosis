import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/GlucoseLogBook.dart';
import '../model/FoodLogBook.dart';
import '../model/ExerciseLogBook.dart';
import '../model/GlucoseRecord.dart';
import '../model/FoodRecord.dart';
import '../model/ExerciseRecord.dart';
import '../controller/UserMgr.dart';

/// Controller that handles the LogBook data of the User
class LogBookMgr {
  static instantiateLogBooks(String email) {
    FirebaseFirestore.instance.collection('GlucoseLogBook').doc(email).set({});
    FirebaseFirestore.instance.collection('FoodLogBook').doc(email).set({});
    FirebaseFirestore.instance.collection('ExerciseLogBook').doc(email).set({});
  }

  /// Adds a new Record to the Glucose LogBook
  static Future<void> addGlucoseRecord(
    double glucoseLevel,
    DateTime dateTime,
    bool beforeMeal,
  ) {
    String email = UserManager.getCurrentUserEmail();
    UserManager.addGlucoseRecord(
      GlucoseRecord(
        dateTime: dateTime,
        glucoseLevel: glucoseLevel,
        beforeMeal: beforeMeal,
      ),
    );
    return FirebaseFirestore.instance
        .collection('GlucoseLogBook')
        .doc(email)
        .collection('GlucoseRecords')
        .add({
          'glucoseLevel': glucoseLevel,
          'dateTime': dateTime,
          'beforeMeal': beforeMeal,
        })
        .then((value) => print('Glucose record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  /// Adds a new Record to the Food LogBook
  static Future<void> addFoodRecord(DateTime dateTime, String food, int carbs,
      int calories, double servingSize,
      {String notes = ""}) {
    String email = UserManager.getCurrentUserEmail();
    UserManager.addFoodRecord(
      FoodRecord(
        dateTime: dateTime,
        food: food,
        carbs: carbs,
        calories: calories,
        servingSize: servingSize,
        notes: notes,
      ),
    );
    return FirebaseFirestore.instance
        .collection('FoodLogBook')
        .doc(email)
        .collection('FoodRecords')
        .add({
          'dateTime': dateTime,
          'food': food,
          'carbs': carbs,
          'calories': calories,
          'servingSize': servingSize,
          'notes': notes,
        })
        .then((value) => print('Food record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  /// Adds a new Record to the Exercise LogBook
  static Future<void> addExerciseRecord(
    DateTime dateTime,
    String exercise,
    int duration,
  ) {
    String email = UserManager.getCurrentUserEmail();
    ExerciseRecord exerciseRecord = new ExerciseRecord(
        exercise: exercise, dateTime: dateTime, duration: duration);
    UserManager.addExerciseRecord(exerciseRecord);
    print(email);
    return FirebaseFirestore.instance
        .collection('ExerciseLogBook')
        .doc(email)
        .collection('ExerciseRecords')
        .add({
          'exercise': exercise,
          'dateTime': dateTime,
          'duration': duration,
        })
        .then((value) => print('Exercise record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  /// Retrieves the Data of the Glucose LogBook
  static Future<GlucoseLogBook> getGlucoseLogBook(String email) async {
    List<GlucoseRecord> recordsList = [];

    await FirebaseFirestore.instance
        .collection('GlucoseLogBook')
        .doc(email)
        .collection('GlucoseRecords')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                recordsList.add(
                  GlucoseRecord(
                    dateTime: DateTime.fromMicrosecondsSinceEpoch(
                      doc['dateTime'].microsecondsSinceEpoch,
                    ),
                    beforeMeal: doc['beforeMeal'],
                    glucoseLevel: doc['glucoseLevel'].toDouble(),
                  ),
                );
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));

    print("glucose:");
    recordsList.forEach((record) {
      print(record.glucoseLevel);
    });
    return new GlucoseLogBook(
      glucoseRecordsList: recordsList,
    );
  }

  /// Retrieves the Data of the Food LogBook
  static Future<FoodLogBook> getFoodLogBook(String email) async {
    List<FoodRecord> recordsList = [];

    await FirebaseFirestore.instance
        .collection('FoodLogBook')
        .doc(email)
        .collection('FoodRecords')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                recordsList.add(
                  FoodRecord(
                    dateTime: DateTime.fromMicrosecondsSinceEpoch(
                      doc['dateTime'].microsecondsSinceEpoch,
                    ),
                    food: doc['food'],
                    carbs: doc['carbs'],
                    calories: doc['calories'],
                    servingSize: doc['servingSize'].toDouble(),
                    notes: doc['notes'],
                  ),
                );
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));

    print("food:");
    print(recordsList);

    return new FoodLogBook(
      recordsList,
    );
  }

  /// Retrieves the Data of the Exercise LogBook
  static Future<ExerciseLogBook> getExerciseLogBook(String email) async {
    List<ExerciseRecord> recordsList = [];

    await FirebaseFirestore.instance
        .collection('ExerciseLogBook')
        .doc(email)
        .collection('ExerciseRecords')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) async {
                recordsList.add(
                  ExerciseRecord(
                    dateTime: DateTime.fromMicrosecondsSinceEpoch(
                      doc['dateTime'].microsecondsSinceEpoch,
                    ),
                    duration: doc['duration'],
                    exercise: doc['exercise'],
                  ),
                );
              })
            })
        .catchError((error) => print('Failed to get logbook: $error'));

    print("exercise");
    print(recordsList);

    return new ExerciseLogBook(
      recordsList,
    );
  }

  /// Returns the Data Formatted for the HomePage
  static Map getHomePageData() {
    print('Getting home page data');
    print(UserManager.getFoodLogBook());
    print(UserManager.getFoodLogBook().runtimeType);
    return {
      'Glucose': UserManager.getGlucoseLogBook().getHomePageData(),
      'Food': UserManager.getFoodLogBook().getHomePageData(),
      'Exercise': UserManager.getExerciseLogBook().getHomePageData(),
    };
  }

  /// Returns the Data Formatted for the LogBookPage
  static Map getLogBookPageData() {
    return {
      'Glucose': UserManager.getGlucoseLogBook().getLogBookPageData(),
      'Food': UserManager.getFoodLogBook().getLogBookPageData(),
      'Exercise': UserManager.getExerciseLogBook().getLogBookPageData(),
    };
  }

  /// Returns the Data Formatted for Popups
  static Map getPopUpData() {
    return {
      'Glucose': UserManager.getGlucoseLogBook().getListOfRecords(),
      'Food': UserManager.getFoodLogBook().getListOfRecords(),
      'Exercise': UserManager.getExerciseLogBook().getListOfRecords(),
    };
  }

  /// Downloads the LogBook data
  static Future<void> downloadGlucoseLogBook() async {
    List<List<String>> listOfRecords =
        UserManager.getGlucoseLogBook().getListOfRecords();

    String csvData = ListToCsvConverter().convert(listOfRecords);
    // final String directory = (await getApplicationDocumentsDirectory()).path;
    // final String directory = (await getExternalStorageDirectory()).path;
    final String directory =
        (await DownloadsPathProvider.downloadsDirectory).path;
    final path = '$directory/Glucose_Records_(${DateTime.now()}).csv';
    final File file = File(path);
    await file.writeAsString(csvData);
    print(path);
    print(csvData);
    print(await file.readAsString());
  }
}
