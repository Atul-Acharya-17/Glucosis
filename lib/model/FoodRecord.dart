/// Entity representing a food record logged by a user.
class FoodRecord {
  DateTime _dateTime;
  String _food;
  /// Number of carbs in grams.
  int _carbs;
  /// Number of calories in kcal.
  int _calories;
  /// Serving size ie: 2.5 servings, etc.
  double _servingSize;
  /// Optional; user's personal notes commenting about the meal.
  String _notes;

  FoodRecord({
    DateTime dateTime,
    String food,
    int carbs,
    int calories,
    double servingSize,
    String notes,
  })  : _dateTime = dateTime,
        _food = food,
        _carbs = carbs,
        _calories = calories,
        _servingSize = servingSize,
        _notes = notes;

  get dateTime => _dateTime;
  get food => _food;
  get carbs => _carbs;
  get calories => _calories;
  get servingSize => _servingSize;
  get notes => _notes;
}
