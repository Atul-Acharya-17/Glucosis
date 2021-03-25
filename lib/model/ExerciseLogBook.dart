import './LogBook.dart';
import './ExerciseRecord.dart';

/// Log book collection entity containing a user's past exercise records.
class ExerciseLogBook extends LogBook {
  List<ExerciseRecord> _exerciseRecords;

  ExerciseLogBook({String email}) : super(email: email);

  void createExerciseRecord({DateTime datetime, int duration, String type}) {
    ExerciseRecord record =
        new ExerciseRecord(datetime: datetime, duration: duration, type: type);
    this._exerciseRecords.add(record);
  }

  get exerciseRecords => _exerciseRecords;
}
