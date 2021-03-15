class User {
  String _email;
  String _phoneNumber;
  String _diabetesType;
  String _location;
  double _weight;
  double _height;

  User(
      {String email,
      String phoneNumber,
      String diabetesType,
      String location,
      double weight,
      double height})
      : _email = email,
        _phoneNumber = phoneNumber,
        _diabetesType = diabetesType,
        _location = location,
        _weight = weight,
        _height = height;

  get height => _height;
  get weight => _weight;
  get location => _location;
  get diabetesType => _diabetesType;
  get phoneNumber => _phoneNumber;
  get email => _email;
}
