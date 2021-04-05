import '../model/GlucoseRecord.dart';
import '../model/Data.dart';

/// Collection entity containing past glucose entries of a user.
class GlucoseLogBook {
  List<GlucoseRecord> _glucoseRecordsList;

  GlucoseLogBook({
    glucoseRecordsList,
  }) : _glucoseRecordsList = glucoseRecordsList;

  get glucoseRecordsList => _glucoseRecordsList;

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

  /// Add glucose record.
  void addRecord(GlucoseRecord glucoseRecord) {
    _glucoseRecordsList.add(glucoseRecord);
  }

  /// Get glucose records history.
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
}