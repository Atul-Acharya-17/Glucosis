import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationManager {
  static final _auth = FirebaseAuth.instance;

  void signUp(String email, String password) async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        print("Hello");
        final user = await _auth.currentUser();
        FirebaseUser loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        print("You Exist");
      } else {
        print("Doesn't Exist");
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() {
    _auth.signOut();
  }
}
