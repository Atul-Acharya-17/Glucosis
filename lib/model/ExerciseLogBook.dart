import 'package:intl/intl.dart';
import '../model/ExerciseRecord.dart';
import '../model/LogBook.dart';
import '../model/Data.dart';

/// Log book collection entity containing a user's past exercise records.
class ExerciseLogBook extends LogBook {
  List<ExerciseRecord> _exerciseRecordsList;

  ExerciseLogBook(List<ExerciseRecord> exerciseRecordsList) {
    exerciseRecordsList.sort((ExerciseRecord a, ExerciseRecord b) =>
        a.dateTime.compareTo(b.dateTime));
    _exerciseRecordsList = exerciseRecordsList;
  }

  get exerciseRecordsList => _exerciseRecordsList;

  /// Add exercise record.
  void addRecord(ExerciseRecord exerciseRecord) {
    if (_exerciseRecordsList == null)
      _exerciseRecordsList = new List<ExerciseRecord>();
    _exerciseRecordsList.add(exerciseRecord);
  }

  /// Get exercise records history.
  @override
  /*List<Data> logBookToData() {
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
  }*/
  List<Data> logBookToData() {
    List<Data> chartData = [];
    String date;
    int dayDuration = 0;

    if (exerciseRecordsList == null) {
      return chartData;
    }

    if (exerciseRecordsList.length > 0) {
      date = DateFormat('yyyy-MM-dd').format(exerciseRecordsList[0].dateTime);
    }
    for (int i = 0; i < exerciseRecordsList.length; i++) {
      ExerciseRecord record = exerciseRecordsList[i];
      if (DateFormat('yyyy-MM-dd').format(record.dateTime) == date) {
        dayDuration += record.duration;
      } else {
        chartData.add(
          Data(
            dateTime: DateTime.parse(date),
            y: dayDuration.toDouble(),
          ),
        );
        print(date);
        print(dayDuration);
        date = DateFormat('yyyy-MM-dd').format(record.dateTime);
        dayDuration = record.duration;
      }
      //print(chartData);
    }
    if (exerciseRecordsList.length > 0) {
      chartData.add(
        Data(
          dateTime: DateTime.parse(date),
          y: dayDuration.toDouble(),
        ),
      );
    }
    // chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }

  /// Get exercise records for displaying log book.
  @override
  List<List<String>> getListOfRecords() {
    List<List<String>> listOfRecords = [];

    List<String> record = [
      'Date',
      'Time',
      'Exercise',
      'Duration',
    ];
    listOfRecords.add(
      record,
    );

    _exerciseRecordsList.forEach((exerciseRecord) {
      record = [];
      record.add(DateFormat.yMMMMEEEEd().format(exerciseRecord.dateTime));
      record.add(DateFormat('kk:mm').format(exerciseRecord.dateTime));
      record.add(exerciseRecord.exercise);
      record.add(exerciseRecord.duration.toString());
      listOfRecords.add(record);
    });

    return listOfRecords;
  }
}
