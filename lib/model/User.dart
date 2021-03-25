/*
target range [min, max]
*/

/// Entity representing the user, their personal details, and the logbooks, plans and reminders associated with them.
class User {
  String _name;
  String _email;
  String _phoneNumber;
  String _diabetesType;
  String _location;
  double _weight;
  double _height;
  List<String> _dietRestrictions;
  String _exercisePreference;
  String _foodPreference;
  String _gender;
  int _targetCalories;
  DateTime _dateOfBirth;

  User(
      {String name,
      String email,
      String phoneNumber,
      String diabetesType,
      String location,
      double weight,
      double height,
      List<String> dietRestrictions,
      String exercisePreference,
      String foodPreference,
      String gender,
      int targetCalories,
      DateTime dateOfBirth})
      : _name = name,
        _email = email,
        _phoneNumber = phoneNumber,
        _diabetesType = diabetesType,
        _location = location,
        _weight = weight,
        _height = height,
        _dietRestrictions = dietRestrictions,
        _exercisePreference = exercisePreference,
        _foodPreference = foodPreference,
        _gender = gender,
        _targetCalories = targetCalories,
        _dateOfBirth = dateOfBirth;

  get name => _name;
  get height => _height;
  get weight => _weight;
  get location => _location;
  get diabetesType => _diabetesType;
  get phoneNumber => _phoneNumber;
  get email => _email;
  get dietRestrictions => _dietRestrictions;
  get exercisePreference => _exercisePreference;
  get foodPreference => _foodPreference;
  get gender => _gender;
  get targetCalories => _targetCalories;
  get dateOfBirth => _dateOfBirth;
}
