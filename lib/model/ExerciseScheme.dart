class ExerciseScheme {
  String _day;

  // Must change to int (minutes??)
  String _duration;

  String _name;

  ExerciseScheme({String day, String duration, String name})
      : _day = day,
        _duration = duration,
        _name = name;

  get name => _name;
  get duration => _duration;
  get day => _day;
}
