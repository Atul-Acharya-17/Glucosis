class FoodRecord {
  DateTime _dateTime;
  String _food;
  int _carbs; // in grams
  int _calories; // in kcal
  double _servingSize;
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
