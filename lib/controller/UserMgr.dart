import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import '../model/User.dart';


class UserManager
{


 CollectionReference users = FirebaseFirestore.instance.collection('users');

/*Future<void> addUser(String email) {
  return users
    .doc(email)
    .set({
      'full_name': "Mary Jane",
      'age': 18
    })
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));
}*/

    void retrieveDetails(String email)
    {

    FirebaseFirestore.instance
    .collection('users')
    .doc(email)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
      } else {
        print('Document does not exist on the database');
      }
    });
    }
}





