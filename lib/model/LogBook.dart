/// Abstract class for user's various log books.
abstract class LogBook {
  String _email;

  LogBook({String email}) : _email = email;

  get email => _email;
}
