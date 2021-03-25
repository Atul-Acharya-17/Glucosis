/// Entity representing an exercise entry logged by a user.
class ExerciseRecord {
  DateTime _datetime;
  /// Number of minutes of exercise.
  int _duration;
  String _type;

  ExerciseRecord({DateTime datetime, int duration, String type})
      : _datetime = datetime,
        _duration = duration,
        _type = type;

  get datetime => _datetime;
  get duration => _duration;
  get type => _type;
}
