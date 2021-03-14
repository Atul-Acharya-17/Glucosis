// import 'package:flutterapp/model/ExerciseRecord.dart';
// import 'package:flutterapp/model/FoodRecord.dart';

class GlucoseRecord {
  String date;
  String time;
  bool beforeMeal;  // true for before meal, false for after meal
  double glucoseLevel; // in mg/dL

  GlucoseRecord(this.date, this.time, this.beforeMeal, this.glucoseLevel);
}

// void main() {
//   GlucoseRecord record = GlucoseRecord("14/03/2021", "0806", false, 50);
//   print(record.date);
//   FoodRecord record2 = FoodRecord("14/03/2021", "0822", "Pizza", 15, 200, 1, "This was awesome");
//   print(record2.notes);
//   ExerciseRecord record3 = ExerciseRecord("14/03/2021", "0843", 30, "Walking");
//   print(record3.time);
// }