import '../model/ExerciseRecord.dart';
import '../model/Data.dart';

/// Log book collection entity containing a user's past exercise records.
class ExerciseLogBook {
  List<ExerciseRecord> _exerciseRecordsList;

  ExerciseLogBook({
    exerciseRecordsList,
  }) : _exerciseRecordsList = exerciseRecordsList;

  get exerciseRecordsList => _exerciseRecordsList;

  /// Gets data to create chart on home page.
  List<Data> dataHomePage() {
    List<Data> chartData = logBookToData();
    return chartData.sublist(0, 7);
  }

  /// Gets data to create chart on log book page.
  List<Data> dataLogBookPage() {
    List<Data> chartData = logBookToData();
    return chartData;
  }

  /// Add exercise record.
  void addRecord(ExerciseRecord exerciseRecord) {
    _exerciseRecordsList.add(exerciseRecord);
  }

  /// Get exercise records history.
  List<Data> logBookToData() {
    List<Data> chartData;
    for (int i = 0; i < exerciseRecordsList.length; i++) {
      ExerciseRecord record = exerciseRecordsList[i];
      chartData.add(
        Data(
          dateTime: record.dateTime,
          y: record.duration,
        ),
      );
    }
    chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }
}
