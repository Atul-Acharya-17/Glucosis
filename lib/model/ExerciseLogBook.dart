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
  List<Data> getHomePageData() {
    List<Data> chartData = logBookToData();
    int end = chartData.length >= 7? 7 : chartData.length;
    return chartData.sublist(0, end);
  }

  /// Gets data to create chart on log book page.
  List<Data> getLogBookPageData() {
    List<Data> chartData = logBookToData();
    return chartData;
  }

  /// Add exercise record.
  void addRecord(ExerciseRecord exerciseRecord) {
    if (_exerciseRecordsList == null)
      _exerciseRecordsList = new List<ExerciseRecord>();
    _exerciseRecordsList.add(exerciseRecord);
  }

  /// Get exercise records history.
  List<Data> logBookToData() {
    List<Data> chartData = [];
    for (int i = 0; i < exerciseRecordsList.length; i++) {
      ExerciseRecord record = exerciseRecordsList[i];
      chartData.add(
        Data(
          dateTime: record.dateTime,
          y: double.parse(record.duration.toString()),
        ),
      );
    }
    chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }
}
