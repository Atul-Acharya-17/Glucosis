import '../model/FoodRecord.dart';
import '../model/Data.dart';

class FoodLogBook {
  List<FoodRecord> foodRecordsList;

  FoodLogBook({
    this.foodRecordsList,
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
    for (int i = 0; i < foodRecordsList.length; i++) {
      FoodRecord record = foodRecordsList[i];
      chartData.add(
        Data(
          dateTime: record.dateTime,
          y: record.calories,
        ),
      );
    }
    chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }
}
