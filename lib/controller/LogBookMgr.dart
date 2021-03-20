import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/model/GlucoseRecord.dart';
import 'package:flutterapp/model/FoodRecord.dart';
import 'package:flutterapp/model/ExerciseRecord.dart';

class LogBookMgr {
  CollectionReference glucoseLogBook;
  CollectionReference foodLogBook;
  CollectionReference exerciseLogBook;

  LogBookMgr(String type, String email) {
    switch (type) {
      case 'glucose':
        {
          this.glucoseLogBook = FirebaseFirestore.instance
              .collection('GlucoseLogBook')
              .doc(email)
              .collection('GlucoseRecords');
        }
        break;
      case 'food':
        {
          this.foodLogBook = FirebaseFirestore.instance
              .collection('FoodLogBook')
              .doc(email)
              .collection('FoodRecord');
          break;
        }
      case 'exercise':
        {
          this.exerciseLogBook = FirebaseFirestore.instance
              .collection('ExerciseLogBook')
              .doc(email)
              .collection('ExerciseRecord');
        }
    }
  }

  /*void initGlucoseLogBook(String email) {
    glucoseLogBook = FirebaseFirestore.instance
        .collection('GlucoseLogBook')
        .doc(email)
        .collection('GlucoseRecord');
  }

  void initFoodLogBook(String email) {
    foodLogBook = FirebaseFirestore.instance
        .collection('FoodLogBook')
        .doc(email)
        .collection('FoodRecord');
  }

  void initExerciseLogBook(String email) {
    exerciseLogBook = FirebaseFirestore.instance
        .collection('ExerciseLogBook')
        .doc(email)
        .collection('ExerciseRecord');
  }*/

  Future<void> addGlucoseRecord(GlucoseRecord record) {
    return glucoseLogBook
        .add({
      'glucoseLevel': record.glucoseLevel,
      'dateTime': record.dateTime,
      'beforeMeal': record.beforeMeal,
    })
        .then((value) => print('Glucose record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  Future<void> addFoodRecord(FoodRecord record) {
    DateTime dateTime = DateTime.parse(record.date + ' ' + record.time);

    return foodLogBook
        .add({
      'food': record.foodName,
      'dateTime': dateTime,
      'carbs': record.carbs,
      'calories': record.calories,
      'servingSize': record.servingSize,
      'notes': record.notes,
    })
        .then((value) => print('Food record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  Future<void> addExerciseRecord(ExerciseRecord record) {
    DateTime dateTime = DateTime.parse(record.date + ' ' + record.time);

    return exerciseLogBook
        .add({
      'exercise': record.type,
      'dateTime': dateTime,
      'duration': record.duration,
    })
        .then((value) => print('Exercise record added!'))
        .catchError((error) => print('Failed to add record: $error'));
  }

  Future<List<GlucoseRecord>> getGlucoseRecords() async {
    List<GlucoseRecord> recordsList = [];
    print('getting glucose records');
    glucoseLogBook.get().then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        print('entry');
        recordsList.add(
          GlucoseRecord(
            dateTime: doc['dateTime'],
            beforeMeal: doc['beforeMeal'],
            glucoseLevel: doc['glucoseLevel'],
          ),
        );
      })
    });

    return recordsList;
  }

/*var newsList = [];

    Future<QuerySnapshot> getData() async {
      return await glucoseLogBook.get();
    }

    QuerySnapshot data = await getData();
    if (data.doc.length > 0) {
      print("3");
      for (int i = 0; i < data.documents.length; i++) {
        newsList.add(data.documents[i].data["headline"]);
      }
    } else {
      print("Not Found");
    }
    print("4");
    return newsList;
  }*/
}
