abstract class LogBook {
  String _email;

  LogBook({String email}) : _email = email;

  get email => _email;

  // Need to change return type
  void graph();
}
