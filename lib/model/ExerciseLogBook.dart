import '../model/ExerciseRecord.dart';
import '../model/Data.dart';

class ExerciseLogBook {
  List<ExerciseRecord> exerciseRecordsList;

  ExerciseLogBook({
    this.exerciseRecordsList,
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
