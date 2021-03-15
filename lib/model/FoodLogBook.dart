import './LogBook.dart';
import './FoodRecord.dart';

class FoodLogBook extends LogBook {
  List<FoodRecord> _foodRecords;

  FoodLogBook(String email) : super(email: email);

  // Need to implement a method to create the composition objects

  void createFoodRecord(String date, String time, String foodName, int carbs,
      int calories, double servingSize,
      [String notes = ""]) {
    FoodRecord record = new FoodRecord(
        date: date,
        time: time,
        foodName: foodName,
        carbs: carbs,
        calories: calories,
        servingSize: servingSize,
        notes: notes);

    this._foodRecords.add(record);
  }

  void graph() {
    // Filter data for graph
  }
}
