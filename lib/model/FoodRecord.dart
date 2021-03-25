/// Entity representing a food record logged by a user.
class FoodRecord {
  DateTime _datetime;
  String _foodName;
  /// In grams.
  int _carbs;
  /// In kcal.
  int _calories;
  double _servingSize;
  /// Optional; user's personal notes commenting about the meal.
  String _notes;

  FoodRecord(
      {DateTime datetime,
      String foodName,
      int carbs,
      int calories,
      double servingSize,
      String notes = ""})
      : _datetime = datetime,
        _foodName = foodName,
        _carbs = carbs,
        _calories = calories,
        _servingSize = servingSize,
        // Default Value
        _notes = notes ?? "";

  get datetime => _datetime;
  get foodName => _foodName;
  get carbs => _carbs;
  get calories => _calories;
  get servingSize => _servingSize;
  get notes => _notes;
}
