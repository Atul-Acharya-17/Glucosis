import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import '../model/User.dart';

/// Controller class for user entity, which retrieves user details from a users database.
class UserManager
{
  // need to add code in entity and controller for target range attribute
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  static User user;

  /// Adds a user to the user database.
Future<void> addUser(String email, DateTime birthday, String diabetesType, List<String> dietaryRestrictions,String exercisePreference,
String foodPreference,String gender,double height,String location, String name,int phone,int targetCalories,int weight, Map targetRange) async{
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

//function to be called after initial signup

Future<void> addUseronSignup(String email,String name,String phoneNumber) async{

  user=new User(email:email,name:name,phoneNumber:phoneNumber,exercisePreference: "Basic",foodPreference: "Vegetarian");
  return users
    .doc(email)
    .set({
      'DOB': Null,
      'diabetes type':Null,
      'dietary restrictions': Null,
      'exercise Preference':"Basic",
      'food preference':"Vegetarian",
      'gender':Null,
      'height':Null,
      'location':Null,//is it there in the page?
      'name':name,
      'phone number':phoneNumber,  
      'targetCalories':Null,
      'weight':Null,
      /*'DOB': Timestamp.fromDate(_dateOfBirth),
      'diabetes type':_diabetesType,
      'dietary restrictions': _dietRestrictions,
      'exercise Preference':_exercisePreference,
      'food preference':_foodPreference,
      'gender':_gender,
      'height':_height,
      'location':_location,
      'name':_name,
      'phone number':_phoneNumber,  
      'targetCalories':targetCalories,
      'weight':_weight,*/
      //'targetRange':targetRange  need to update depending on corresponding attribute
    })
    .then((value) => print("User Added"))
    .catchError((error) => print("Failed to add user: $error"));
}

//function to be called after second page of signup

void updateOnSignup(DateTime dateOfBirth,String gender,String location, double weight, double height,String diabetesType) async
  {
    user.setDob=dateOfBirth;
    user.setGender=gender;
    user.setLocation=location;
    user.setWeight=weight;
    user.setHeight=height;
    user.setDiabetesType=diabetesType;
     users
    .doc(user.email)
    .update({'DOB': Timestamp.fromDate(dateOfBirth),'gender':gender,"location":location,"weight":weight,"height":height,"diabetes type":diabetesType})
    .then((value) => print("succesful update"))
    .catchError((error) => print("Failed to update"));
  }



    /// Gets a user's details from the users database based on user's email on login
    void retrieveDetails (String email) async
    {

    FirebaseFirestore.instance
    .collection('users')
    .doc(email)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        user=new User(dateOfBirth:documentSnapshot['DOB'],
        diabetesType:documentSnapshot['diabetes type'],
        dietRestrictions:documentSnapshot['dietary restrictions'],
        exercisePreference:documentSnapshot['exercise Preference'],
        foodPreference:documentSnapshot['food preference'],
        gender:documentSnapshot['gender'],
        height:documentSnapshot['height'],
        location:documentSnapshot['location'],
        name:documentSnapshot['name'],
        phoneNumber:documentSnapshot['phone number'],//need to change this to int or update type to string in db
        targetCalories:documentSnapshot['targetCalories'],
        weight:documentSnapshot['weight']);
        
      } else {
        print('Document does not exist on the database');
      }
    });
    }

    Map<String,dynamic> getProfileDetails()
    {
        Map<String,dynamic> profileDetails=
        {
          'email':user.email,
          'name':user.name,
          'phoneNumber':user.phoneNumber,
          'height':user.height,
          'weight':user.weight,
          'location':user.location,
          'diabetesType':user.diabetesType,
          'targetCalories':user.targetCalories,
          'dietaryRestrictions':user.dietRestrictions,
          'foodPreference':user.foodPreference,
          'exercisePreference':user.exercisePreference,
          'gender':user.gender,
          'dateOfBirth':user.dateOfBirth
        };
        return profileDetails;
    }

    Map<String,dynamic> getFoodPreferenceDetails()
    {
      Map<String,dynamic> foodProfileDetails=
        {
          'targetCalories':user.targetCalories,
          'dietaryRestrictions':user.dietRestrictions,
          'foodPreference':user.foodPreference,
        
        };
        return foodProfileDetails;
    }


}





