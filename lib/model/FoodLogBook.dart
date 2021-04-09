import 'package:intl/intl.dart';
import '../model/FoodRecord.dart';
import '../model/LogBook.dart';
import '../model/Data.dart';

/// Collection entity containing past food entries of a user.
class FoodLogBook extends LogBook {
  List<FoodRecord> _foodRecordsList;

  FoodLogBook(List<FoodRecord> foodRecordsList) {
    foodRecordsList
        .sort((FoodRecord a, FoodRecord b) => a.dateTime.compareTo(b.dateTime));
    _foodRecordsList = foodRecordsList;
  }

  get foodRecordsList => _foodRecordsList;

  /// Add food record.
  void addRecord(FoodRecord foodRecord) {
    _foodRecordsList.add(foodRecord);
  }

  /// Get food records history.
  @override
  List<Data> logBookToData() {
    List<Data> chartData = [];
    String date;
    int dayCalories = 0;
    if (foodRecordsList.length > 0) {
      date = DateFormat('yyyy-MM-dd').format(foodRecordsList[0].dateTime);
    }
    for (int i = 0; i < foodRecordsList.length; i++) {
      FoodRecord record = foodRecordsList[i];
      if (DateFormat('yyyy-MM-dd').format(record.dateTime) == date) {
        dayCalories += record.calories;
      } else {
        chartData.add(
          Data(
            dateTime: DateTime.parse(date),
            y: dayCalories.toDouble(),
          ),
        );
        print(date);
        print(dayCalories);
        date = DateFormat('yyyy-MM-dd').format(record.dateTime);
        dayCalories = record.calories;
      }
      //print(chartData);
    }
    chartData.add(
      Data(
        dateTime: DateTime.parse(date),
        y: dayCalories.toDouble(),
      ),
    );
    // chartData.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return chartData;
  }

  /// Get food records for displaying log book.
  @override
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
