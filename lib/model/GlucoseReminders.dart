import 'package:flutterapp/model/Reminder.dart';
import 'package:intl/intl.dart';

/// Entity containing details about a medication reminder.
class GlucoseReminder extends Reminder{
  DateTime _timings;

  GlucoseReminder({DateTime timings}) : _timings = timings;

  get timings => _timings;

  Map<String, dynamic> toMap(int i) {
    return {
      'type': "Glucose",
      'message': "Log your glucose levels",
      'timings': DateFormat('h:mm a').format(timings),
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
