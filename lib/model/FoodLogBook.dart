import 'package:intl/intl.dart';
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
  List<Data> getHomePageData() {
    List<Data> chartData = logBookToData();
    int end = chartData.length >= 7 ? 7 : chartData.length;
    return chartData.sublist(0, end);
  }

  /// Gets data to create chart on log book page.
  List<Data> getLogBookPageData() {
    List<Data> chartData = logBookToData();
    return chartData;
  }

  /// Add food record.
  void addRecord(FoodRecord foodRecord) {
    _foodRecordsList.add(foodRecord);
  }

  /// Get food records history.
  List<Data> logBookToData() {
    List<Data> chartData = [];
    for (int i = 0; i < foodRecordsList.length; i++) {
      FoodRecord record = foodRecordsList[i];
      chartData.add(
        Data(
          dateTime: record.dateTime,
          y: double.parse(record.calories.toString()),
        ),
      );
    }
    chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }

  /// Get food records for displaying log book.
  List<List<String>> getListOfRecords() {
    List<List<String>> listOfRecords = [];

    List<String> record = [
      'Date',
      'Time',
      'Food',
      'Carbs',
      'Calories',
      'Serving Size',
      'Notes',
    ];
    listOfRecords.add(
      record,
    );

    _foodRecordsList.forEach((foodRecord) {
      record = [];
      record.add(DateFormat.yMMMMEEEEd().format(foodRecord.dateTime));
      record.add(DateFormat('kk:mm').format(foodRecord.dateTime));
      record.add(foodRecord.food);
      record.add(foodRecord.carbs.toString());
      record.add(foodRecord.calories.toString());
      record.add(foodRecord.servingSize.toString());
      record.add(foodRecord.notes);
      listOfRecords.add(record);
    });

    return listOfRecords;
  }
}