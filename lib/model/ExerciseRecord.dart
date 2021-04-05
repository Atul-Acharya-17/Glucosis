/// Entity representing an exercise entry logged by a user.
class ExerciseRecord {
  DateTime _dateTime;
  /// Number of minutes of exercise.
  int _duration;
  /// Name of exercise.
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
