import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationManager {
  static final _auth = FirebaseAuth.instance;

  Future<bool> signUp(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        print("Hello");
        final user = await _auth.currentUser();
        FirebaseUser loggedUser = user;
        print(loggedUser.email);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

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

  void signOut() {
    _auth.signOut();
  }
}
