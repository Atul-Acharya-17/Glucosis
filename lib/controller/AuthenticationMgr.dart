import 'package:firebase_auth/firebase_auth.dart';

/// Controller which validates users account details from an account information database.
class AuthenticationManager {
  static final _auth = FirebaseAuth.instance;

  /// Creates a new user in the database.
  Future<bool> signUp(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        print("Hello");
        final user = _auth.currentUser;
        print(user.email);
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Validates the account details from database to allow user to log in.
  Future<bool> login(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        print("You Exist");
        return true;
      } else {
        print("Doesn't Exist");
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Signs user out.
  static void signOut() {
    _auth.signOut();
  }

  /// Gets email of the user currently logged in.
  String getCurrentUser() {
    return _auth.currentUser.email != null ? _auth.currentUser.email : null;
  }
}
