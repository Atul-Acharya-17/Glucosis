import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import '../model/User.dart';

/// Controller class for user entity, which retrieves user details from a users database.
class UserManager
{

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// Adds a user to the user database.
Future<void> addUser(String email, DateTime birthday, String diabetesType, List<String> dietaryRestrictions,String exercisePreference,
String foodPreference,String gender,double height,String location, String name,int phone,int targetCalories,int weight, Map targetRange) {
  return users
    .doc(email)
    .set({
      'DOB': Timestamp.fromDate(birthday),
      'diabetes type':diabetesType,
      'dietary restrictions': dietaryRestrictions,
      'exercise Preference':exercisePreference,
      'food preference':foodPreference,
      'gender':gender,
      'height':height,
      'location':location,
      'name':name,
      'phone number':phone,
      'targetCalories':targetCalories,
      'weight':weight,
      'targetRange':targetRange
    })
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));
}

    /// Gets a user's details from the users database based on user's email.
    void retrieveDetails(String email)
    {

    FirebaseFirestore.instance
    .collection('users')
    .doc(email)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        print('one field '+documentSnapshot['name']);
      } else {
        print('Document does not exist on the database');
      }
    });
    }
}





