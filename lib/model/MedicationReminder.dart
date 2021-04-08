import 'package:intl/intl.dart';

/// Entity containing details about a medication reminder.
class MedicationReminder {
  String _medicineName;
  String _dosage;
  DateTime _timing;
  String _type;

  MedicationReminder(
      {String medicineName, String dosage, DateTime timing, String type})
      : _medicineName = medicineName,
        _dosage = dosage,
        _timing = timing,
        _type = type;

  get medicineName => _medicineName;
  get dosage => _dosage;
  get timing => _timing;
  get type => _type;

  Map<String, dynamic> toMap(int i) {
    return {
      'type': "Medication",
      'message': "Take " + dosage + " " + type + " of " + medicineName,
      'timings': DateFormat('h:mm a').format(timing),
      'index': i,
    };
  }

  bool compareTo(DateTime b) {
    if (timing.hour > b.hour ||
        (timing.hour == b.hour && timing.minute >= b.minute)) {
      return true;
    }
    return false;
  }
}
