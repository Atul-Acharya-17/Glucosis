class ExerciseRecord {
  DateTime _dateTime;
  int _duration; // minutes
  String _exercise;

  ExerciseRecord({
    DateTime dateTime,
    int duration,
    String exercise,
  })  : _dateTime = dateTime,
        _duration = duration,
        _exercise = exercise;

  get dateTime => _dateTime;
  get duration => _duration;
  get exercise => _exercise;
}
