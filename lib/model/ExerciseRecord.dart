class ExerciseRecord {
  DateTime _datetime;
  int _duration; // minutes
  String _type;

  ExerciseRecord({DateTime datetime, int duration, String type})
      : _datetime = datetime,
        _duration = duration,
        _type = type;

  get datetime => _datetime;
  get duration => _duration;
  get type => _type;
}
