class FoodRecord {
  String _date;
  String _time;
  String _foodName;
  int _carbs; // in grams
  int _calories; // in kcal
  double _servingSize;
  String _notes;

  FoodRecord(
      {String date,
      String time,
      String foodName,
      int carbs,
      int calories,
      double servingSize,
      String notes = ""})
      : _date = date,
        _time = time,
        _foodName = foodName,
        _carbs = carbs,
        _calories = calories,
        _servingSize = servingSize,
        // Default Value
        _notes = notes ?? "";

  get date => _date;
  get time => _time;
  get foodName => _foodName;
  get carbs => _carbs;
  get calories => _calories;
  get servingSize => _servingSize;
  get notes => _notes;
}
