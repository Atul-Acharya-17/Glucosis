/// Entity representing a blood glucose level entry recorded by a user.
class GlucoseRecord {
  DateTime _dateTime;
  /// True for before meal, false for after meal.
  bool _beforeMeal;
  /// In mg/dL.
  double _glucoseLevel;

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
