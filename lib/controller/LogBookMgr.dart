import 'package:cloud_firestore/cloud_firestore.dart';
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
    String email = UserMgr.getCurrentUserEmail();
    UserMgr.addGlucoseRecord(
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
    String email = UserMgr.getCurrentUserEmail();
    UserMgr.addFoodRecord(
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
    String email = UserMgr.getCurrentUserEmail();
    UserMgr.addExerciseRecord(
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
      'Glucose': UserMgr.getGlucoseLogBook().getHomePageData(),
      'Food': UserMgr.getFoodLogBook().getHomePageData(),
      'Exercise': UserMgr.getExerciseLogBook().getHomePageData(),
    };
  }

  static Map getLogBookPageData() {
    return {
      'Glucose': UserMgr.getGlucoseLogBook().getLogBookPageData(),
      'Food': UserMgr.getFoodLogBook().getLogBookPageData(),
      'Exercise': UserMgr.getExerciseLogBook().getLogBookPageData(),
    };
  }
}
