/// Entity containing details about a medication reminder.
class GlucoseReminder {
  DateTime _timings;

  GlucoseReminder({DateTime timings}) : _timings = timings;

  get timings => _timings;

  Map<String, dynamic> toMap(int i) {
    return {
      'type': "glucose",
      'message': "Log your glucose levels",
      'timings': timings,
      'index': i,
    };
  }

  bool compareTo(DateTime b) {
    if (timings.hour > b.hour ||
        (timings.hour == b.hour && timings.minute >= b.minute)) {
      return true;
    }
    return false;
  }
}