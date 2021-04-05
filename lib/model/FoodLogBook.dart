import '../model/FoodRecord.dart';
import '../model/Data.dart';

/// Collection entity containing past food entries of a user.
class FoodLogBook {
  List<FoodRecord> _foodRecordsList;

  FoodLogBook({
    foodRecordsList,
  }) : _foodRecordsList = foodRecordsList;

  get foodRecordsList => _foodRecordsList;

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

  /// Add food record.
  void addRecord(FoodRecord foodRecord) {
    _foodRecordsList.add(foodRecord);
  }

  /// Get food records history.
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
