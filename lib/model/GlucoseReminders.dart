/// Entity containing details about a medication reminder.
class GlucoseReminder {
  DateTime _timings;

  GlucoseReminder({DateTime timings}) : _timings = timings;

  get timings => _timings;
  Map<String, dynamic> toMap() {
    return {
      'type': "glucose",
      'message': "Log your glucose levels",
      'timings': timings
    };
  }
}
