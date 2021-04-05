import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import '../model/User.dart';
import '../model/GlucoseRecord.dart';
import '../model/FoodRecord.dart';
import '../model/ExerciseRecord.dart';

/// Controller class for user entity, which retrieves user details from a users database.
class UserManager
{
  // need to add code in entity and controller for target range attribute
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  static User user;

  /// Adds a user to the user database.
Future<void> addUser(String email, DateTime birthday, String diabetesType, List<String> dietaryRestrictions,String exercisePreference,
String foodPreference,String gender,double height,String location, String name,String phone,int targetCalories,double weight, Map targetRange) async{
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
  await users
    .doc(email)
    .set({
      'DOB': null,
      'diabetes type':null,
      'dietary restrictions': null,
      'exercise Preference':"Basic",
      'food preference':"Vegetarian",
      'gender':null,
      'height':null,
      'location':null,//is it there in the page?
      'name':name,
      'phone number':phoneNumber,  
      'targetCalories':null,
      'weight':null,
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
    .catchError((error) => print("Failed to add  new user: $error"));
}

//function to be called after second page of signup

void updateOnSignup(DateTime dateOfBirth,String gender,String location, double weight, double height,String diabetesType) async{
    user.setDob=dateOfBirth;
    user.setGender=gender;
    user.setLocation=location;
    user.setWeight=weight;
    user.setHeight=height;
    user.setDiabetesType=diabetesType;
     await users
    .doc(user.email)
    .update({'DOB': Timestamp.fromDate(dateOfBirth),'gender':gender,"location":location,"weight":weight,"height":height,"diabetes type":diabetesType})
    .then((value) => print("succesful update"))
    .catchError((error) => print("Failed to update"));
  }


  void updateFoodPref(List<String> dietaryRestrictions,String foodPreference,int targetCalories) async{
    user.setdietRestrictions=dietaryRestrictions;
    user.setFoodPreference=foodPreference;
    user.setTargetCalories=targetCalories;
     await users
    .doc(user.email)
    .update({'dietary restrictions': dietaryRestrictions,'food preference':foodPreference,'targetCalories':targetCalories})
    .then((value) => print("succesful update"))
    .catchError((error) => print("Failed to update"));
  }



    /// Gets a user's details from the users database based on user's email on login
    void retrieveDetails (String email) async
    {
      print(email);
    await
    FirebaseFirestore.instance
    .collection('users')
    .doc(email)
    .get()
    .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data());
        UserManager.user=new User(dateOfBirth:documentSnapshot['DOB'].toDate(),
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
        weight:documentSnapshot['weight']
        ,email: email);

      
        
      } else {
        print('Document does not exist on the database');
      }
    });

     print(getProfileDetails());
        
        
    }

     static Map<String,dynamic> getProfileDetails()
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

    static Map<String,dynamic> getFoodPreferenceDetails()
    {
      Map<String,dynamic> foodProfileDetails=
        {
          'targetCalories':user.targetCalories,
          'dietaryRestrictions':user.dietRestrictions,
          'foodPreference':user.foodPreference,
        
        };
        return foodProfileDetails;
    }

    String getCurrentUserEmail()
    {
       return user.email;
    }

    void addGlucoseRecord(GlucoseRecord gr)
    {

    }

    void addExerciseRecord(FoodRecord fr)
    {

    }

    void addFoodRecord(ExerciseRecord er)
    {

    }


}





