import '../model/GlucoseRecord.dart';
import '../model/Data.dart';

class GlucoseLogBook {
  List<GlucoseRecord> glucoseRecordsList;

  GlucoseLogBook({
    this.glucoseRecordsList,
  });

  List<Data> dataHomePage() {
    List<Data> chartData = logBookToData();
    return chartData.sublist(0, 7);
  }

  List<Data> dataLogBookPage() {
    List<Data> chartData = logBookToData();
    return chartData;
  }

  List<Data> logBookToData() {
    List<Data> chartData;
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
