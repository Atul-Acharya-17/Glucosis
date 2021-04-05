import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import '../model/GlucoseLogBook.dart';
import '../model/FoodLogBook.dart';
import '../model/ExerciseLogBook.dart';
import '../model/GlucoseRecord.dart';
import '../model/FoodRecord.dart';
import '../model/ExerciseRecord.dart';
import '../controller/UserMgr.dart';

class LogBookMgr {
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

  static Future<void> addFoodRecord(
      DateTime dateTime,
      String food,
      int carbs,
      int calories,
      double servingSize,
      String notes,
      ) {
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

  static Future<void> addExerciseRecord(
      DateTime dateTime,
      String exercise,
      int duration,
      ) {
    String email = UserManager.getCurrentUserEmail();
    UserManager.addExerciseRecord(
      ExerciseRecord(
        dateTime: dateTime,
        exercise: exercise,
        duration: duration,
      ),
    );
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

    return GlucoseLogBook(
      glucoseRecordsList: recordsList,
    );
  }

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

    return FoodLogBook(
      foodRecordsList: recordsList,
    );
  }

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

    return ExerciseLogBook(
      exerciseRecordsList: recordsList,
    );
  }

  static Map getHomePageData() {
    return {
      'Glucose': UserManager.getGlucoseLogBook().getHomePageData(),
      'Food': UserManager.getFoodLogBook().getHomePageData(),
      'Exercise': UserManager.getExerciseLogBook().getHomePageData(),
    };
  }

  static Map getLogBookPageData() {
    return {
      'Glucose': UserManager.getGlucoseLogBook().getLogBookPageData(),
      'Food': UserManager.getFoodLogBook().getLogBookPageData(),
      'Exercise': UserManager.getExerciseLogBook().getLogBookPageData(),
    };
  }

  static Future<void> downloadGlucoseLogBook() async {
    List<List<String>> listOfRecords = [];
    List<GlucoseRecord> glucoseRecordsList =
        UserManager.getGlucoseLogBook().glucoseRecordsList;

    List<String> record = [
      'Date',
      'Time',
      'Glucose Level',
      'Before/After Meal',
    ];
    listOfRecords.add(
      record,
    );

    glucoseRecordsList.forEach((glucoseRecord) {
      record = [];
      record.add(DateFormat.yMMMMEEEEd().format(glucoseRecord.dateTime));
      record.add(DateFormat('kk:mm').format(glucoseRecord.dateTime));
      record.add(glucoseRecord.glucoseLevel.toString());
      record
          .add(glucoseRecord.beforeMeal == true ? 'Before Meal' : 'After Meal');
      listOfRecords.add(record);
    });

    String csvData = ListToCsvConverter().convert(listOfRecords);
    final String directory = (await getApplicationDocumentsDirectory()).path;
    final path = "$directory/Glucose Records (${DateTime.now()}).csv";
    final File file = File(path);
    await file.writeAsString(csvData);
  }
}