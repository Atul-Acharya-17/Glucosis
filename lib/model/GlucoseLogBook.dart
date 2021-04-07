import 'package:intl/intl.dart';
import '../model/GlucoseRecord.dart';
import '../model/LogBook.dart';
import '../model/Data.dart';

/// Collection entity containing past glucose entries of a user.
class GlucoseLogBook extends LogBook {
  List<GlucoseRecord> _glucoseRecordsList;

  GlucoseLogBook({
    glucoseRecordsList,
  }) : _glucoseRecordsList = glucoseRecordsList;

  get glucoseRecordsList => _glucoseRecordsList;

  /// Add glucose record.
  void addRecord(GlucoseRecord glucoseRecord) {
    _glucoseRecordsList.add(glucoseRecord);
  }

  /// Get glucose records for the charts.
  @override
  List<Data> logBookToData() {
    List<Data> chartData = [];
    for (int i = 0; i < glucoseRecordsList.length; i++) {
      GlucoseRecord record = glucoseRecordsList[i];
      chartData.add(
        Data(
          dateTime: record.dateTime,
          y: record.glucoseLevel,
        ),
      );
    }
    chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }

  /// Get glucose records for displaying log book.
  @override
  List<List<String>> getListOfRecords() {
    List<List<String>> listOfRecords = [];

    List<String> record = [
      'Date',
      'Time',
      'Glucose Level',
      'Before/After Meal',
    ];
    listOfRecords.add(
      record,
    );

    _glucoseRecordsList.forEach((glucoseRecord) {
      record = [];
      record.add(DateFormat.yMMMMEEEEd().format(glucoseRecord.dateTime));
      record.add(DateFormat('kk:mm').format(glucoseRecord.dateTime));
      record.add(glucoseRecord.glucoseLevel.toString());
      record
          .add(glucoseRecord.beforeMeal == true ? 'Before Meal' : 'After Meal');
      listOfRecords.add(record);
    });

    return listOfRecords;
  }
}