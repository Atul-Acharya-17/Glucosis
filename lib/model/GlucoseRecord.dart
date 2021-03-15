// import 'package:flutterapp/model/ExerciseRecord.dart';
// import 'package:flutterapp/model/FoodRecord.dart';

class GlucoseRecord {
  String _date;
  String _time;
  bool _beforeMeal; // true for before meal, false for after meal
  double _glucoseLevel; // in mg/dL

  GlucoseRecord(
      {String date, String time, bool beforeMeal, double glucoseLevel})
      : _date = date,
        _time = time,
        _beforeMeal = beforeMeal,
        _glucoseLevel = glucoseLevel;

  get date => _date;
  get time => _time;
  get beforeMeal => _beforeMeal;
  get glucoseLevel => _glucoseLevel;
}

// void main() {
//   GlucoseRecord record = GlucoseRecord("14/03/2021", "0806", false, 50);
//   print(record.date);
//   FoodRecord record2 = FoodRecord("14/03/2021", "0822", "Pizza", 15, 200, 1, "This was awesome");
//   print(record2.notes);
//   ExerciseRecord record3 = ExerciseRecord("14/03/2021", "0843", 30, "Walking");
//   print(record3.time);
// }
