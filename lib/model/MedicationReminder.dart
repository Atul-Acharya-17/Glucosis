class MedicationReminder {
  /*
  FireBase schema is slightly different
  */
  //String _medicines; // List<String>
  //String _dosage; // List<String>
  //List<String> _days; // List<List<String>>
  //List<String> _timings; // List<List<String>>

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
}
