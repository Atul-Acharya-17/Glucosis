class Reminder {
  String _medicines; // List<String>
  String _dosage; // List<String>
  List<String> _days; // List<List<String>>
  List<String> _timings; // List<List<String>>

  Reminder(
      {String medicines,
      String dosage,
      List<String> days,
      List<String> timings})
      : _medicines = medicines,
        _dosage = dosage,
        _days = days,
        _timings = timings;

  get medicines => _medicines;
  get dosage => _dosage;
  get days => _days;
  get timings => _timings;
}
