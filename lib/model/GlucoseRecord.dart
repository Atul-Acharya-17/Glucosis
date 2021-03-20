class GlucoseRecord {
  DateTime _dateTime;
  bool _beforeMeal; // true for before meal, false for after meal
  double _glucoseLevel; // in mg/dL

  GlucoseRecord({
    DateTime dateTime,
    bool beforeMeal,
    double glucoseLevel,
  })  : _dateTime = dateTime,
        _beforeMeal = beforeMeal,
        _glucoseLevel = glucoseLevel;

  get dateTime => _dateTime;
  get beforeMeal => _beforeMeal;
  get glucoseLevel => _glucoseLevel;
}
