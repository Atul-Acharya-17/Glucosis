class ExerciseRecord {
  String _date;
  String _time;
  int _duration; // minutes
  String _type;

  ExerciseRecord({String date, String time, int duration, String type})
      : _date = date,
        _time = time,
        _duration = duration,
        _type = type;

  get date => _date;
  get time => _time;
  get duration => _duration;
  get type => _type;
}
