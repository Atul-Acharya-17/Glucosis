import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart';
import '../model/User.dart';
import '../model/GlucoseRecord.dart';
import '../model/FoodRecord.dart';
import '../model/ExerciseRecord.dart';
import '../controller/LogBookMgr.dart';
import '../model/ExerciseLogBook.dart';
import '../model/GlucoseLogBook.dart';
import '../model/FoodLogBook.dart';
import '../model/ExercisePlan.dart';
import '../model/MealPlan.dart';
import '../model/MedicationReminder.dart';
import '../model/GlucoseReminders.dart';
import '../controller/ReminderMgr.dart';

/// Controller class for user entity, which retrieves user details from a users database.
class UserManager {
  // need to add code in entity and controller for target range attribute
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  static User user;

  /// Adds a user to the user database.
  /*static Future<void> addUser(
      String email,
      DateTime birthday,
      String diabetesType,
      List<String> dietaryRestrictions,
      String exercisePreference,
      String foodPreference,
      String gender,
      double height,
      String location,
      String name,
      String phone,
      int targetCalories,
      double weight,
      Map targetRange) async {
    return users
        .doc(email)
        .set({
          'DOB': Timestamp.fromDate(birthday),
          'diabetes type': diabetesType,
          'dietary restrictions': dietaryRestrictions,
          'exercise Preference': exercisePreference,
          'food preference': foodPreference,
          'gender': gender,
          'height': height,
          'location': location,
          'name': name,
          'phone number': phone,
          'targetCalories': targetCalories,
          'weight': weight,
          'targetRange': targetRange
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }*/

//function to be called after initial signup

  /// Creates a new user account
  static Future<void> addUseronSignup(
      String email, String name, String phoneNumber) async {
    user = new User(
        email: email,
        name: name,
        phoneNumber: phoneNumber,
        exercisePreference: "Basic",
        foodPreference: "Vegetarian");
    await users
        .doc(email)
        .set({
          'DOB': null,
          'diabetes type': null,
          'dietary restrictions': null,
          'exercise Preference': "Basic",
          'food preference': "Vegetarian",
          'gender': null,
          'height': null,
          'location': null,
          //is it there in the page?
          'name': name,
          'phone number': phoneNumber,
          'targetCalories': null,
          'targetCarbs': null,
          'minGlucose': null,
          'maxGlucose': null,
          'weight': null,
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

  /// Updates the user details
  static void updateProfilePage(
      DateTime dateOfBirth,
      String gender,
      String location,
      double weight,
      double height,
      String diabetesType, //should be toggle in ui?
      double minGluc, //should use the same ui element as accountdetailspage?
      double maxGluc,
      String name,
      String phoneNumber,
      String exerciseLevel) async {
    user.setDob = dateOfBirth;
    user.setGender = gender;
    user.setLocation = location;
    user.setWeight = weight;
    user.setHeight = height;
    user.setDiabetesType = diabetesType;
    user.setMinTargetGlucose = minGluc;
    user.setMaxTargetGlucose = maxGluc;
    user.setExercisePreference = exerciseLevel;
    await users
        .doc(user.email)
        .update({
          'DOB': Timestamp.fromDate(dateOfBirth),
          'gender': gender,
          "location": location,
          "weight": weight,
          "height": height,
          "diabetes type": diabetesType,
          'minGlucose': minGluc,
          'maxGlucose': maxGluc,
          'exercise Preference': exerciseLevel
        })
        .then((value) => print("succesful update"))
        .catchError((error) => print("Failed to update"));
  }

//function to be called after second page of signup to update corresponding user details

  /// Updates the user details when signed up
  static void updateOnSignup(
      DateTime dateOfBirth,
      String gender,
      String location,
      double weight,
      double height,
      String diabetesType,
      double minGluc,
      double maxGluc) async {
    user.setDob = dateOfBirth;
    user.setGender = gender;
    user.setLocation = location;
    user.setWeight = weight;
    user.setHeight = height;
    user.setDiabetesType = diabetesType;
    user.setMinTargetGlucose = minGluc;
    user.setMaxTargetGlucose = maxGluc;
    await users
        .doc(user.email)
        .update({
          'DOB': Timestamp.fromDate(dateOfBirth),
          'gender': gender,
          "location": location,
          "weight": weight,
          "height": height,
          "diabetes type": diabetesType,
          'minGlucose': minGluc,
          'maxGlucose': maxGluc
        })
        .then((value) => print("succesful update"))
        .catchError((error) => print("Failed to update"));
  }

  //to update food preferences

  /// Updates the user's food preference
  static void updateFoodPref(List<String> dietaryRestrictions,
      String foodPreference, int targetCalories, int targetCarbs) async {
    user.setdietRestrictions = dietaryRestrictions;
    user.setFoodPreference = foodPreference;
    user.setTargetCalories = targetCalories;
    user.setTargetCarbs = targetCarbs;
    await users
        .doc(user.email)
        .update({
          'dietary restrictions': dietaryRestrictions,
          'food preference': foodPreference,
          'targetCalories': targetCalories,
          'targetCarbs': targetCarbs
        })
        .then((value) => print("succesful update"))
        .catchError((error) => print("Failed to update"));
  }

  /// Gets a user's details from the users database based on user's email on login
  static Future<void> retrieveDetails(String email) async {
    print(email);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.data());
        print(documentSnapshot['DOB'].toDate().toLocal());
        print(DateTime.now());
        print(DateTime.now().toLocal());
        UserManager.user = new User(
            dateOfBirth: documentSnapshot['DOB'].toDate(),
            diabetesType: documentSnapshot['diabetes type'],
            //dietRestrictions: documentSnapshot['dietary restrictions'],
            exercisePreference: documentSnapshot['exercise Preference'],
            foodPreference: documentSnapshot['food preference'],
            gender: documentSnapshot['gender'],
            height: documentSnapshot['height'],
            location: documentSnapshot['location'],
            name: documentSnapshot['name'],
            phoneNumber: documentSnapshot['phone number'],
            //need to change this to int or update type to string in db
            targetCalories: documentSnapshot['targetCalories'],
            targetCarbs: documentSnapshot['targetCarbs'],
            minGlucose: documentSnapshot['minGlucose'].toDouble(),
            maxGlucose: documentSnapshot['maxGlucose'].toDouble(),
            weight: documentSnapshot['weight'],
            email: email);
      } else {
        print('Document does not exist on the database');
      }
    });

    print(getProfileDetails());
  }

//to get all profile details for the profile page
  /// Retrieves the user's profile details
  static Map<String, dynamic> getProfileDetails() {
    Map<String, dynamic> profileDetails = {
      'email': user.email,
      'name': user.name,
      'phoneNumber': user.phoneNumber,
      'height': user.height,
      'weight': user.weight,
      'location': user.location,
      'diabetesType': user.diabetesType,
      'targetCalories': user.targetCalories,
      'targetCarbs': user.targetCarbs,
      'minGlucose': user.minGlucose,
      'maxGlucose': user.maxGlucose,
      'dietaryRestrictions': user.dietRestrictions,
      'foodPreference': user.foodPreference,
      'exercisePreference': user.exercisePreference,
      'gender': user.gender,
      'dateOfBirth': user.dateOfBirth
    };
    return profileDetails;
  }

  // to display the info in the updatefoodpreferences page

  /// Gets the user's current preference
  static Map<String, dynamic> getFoodPreferenceDetails() {
    Map<String, dynamic> foodProfileDetails = {
      'targetCalories': user.targetCalories,
      'dietaryRestrictions': user.dietRestrictions,
      'foodPreference': user.foodPreference,
      'targetCarbs': user.targetCarbs
    };
    return foodProfileDetails;
  }

  /// Gets the user's emailID
  static String getCurrentUserEmail() {
    return user.email;
  }

  /// Adds a new GlucoseRecord
  static void addGlucoseRecord(GlucoseRecord gr) {
    user.glucoseLogBook.addRecord(gr);
  }

  /// Adds a new Exercise Record
  static void addExerciseRecord(ExerciseRecord er) {
    if (user.exerciseLogBook == null)
      user.setExerciseLogBook = new ExerciseLogBook(new List<ExerciseRecord>());
    user.exerciseLogBook.addRecord(er);
  }

  /// Adds a new Food Record
  static void addFoodRecord(FoodRecord fr) {
    user.foodLogBook.addRecord(fr);
  }

  /// Adds a new Medication Reminder
  static void addMedicationReminder(MedicationReminder mr) {
    user.addMedicationReminder(mr);
  }

  /// Adds a new Glucose Reminder
  static void addGlucoseReminder(GlucoseReminder gr) {
    print(user.glucoseReminders);
    if (user.glucoseReminders == null) {
      print('Hi');
      user.setGlucoseReminders = new List<GlucoseReminder>();
    } else {
      print("Hello");
      print(user.glucoseReminders);
    }
    user.addGlucoseReminder(gr);
  }

  static void setUserMealPlan(MealPlan mp) {
    user.setMealPlan = mp;
  }

  static void setUserExercisePlan(ExercisePlan ep) {
    user.setExercisePlan = ep;
  }

  /// Sets the user's data on Login
  static Future<void> setData() async {
    await setUserGlucoseLogBook();
    await setUserFoodLogBook();
    await setUserExerciseLogBook();
    await setGlucoseReminders();
    await setMedicationReminders();
  }

  /// Sets the Glucose Reminders of the user
  static Future<void> setGlucoseReminders() async {
    await ReminderMgr.getGlucoseReminders(user.email)
        .then((glucoseReminder) => {
              if (glucoseReminder != null)
                user.setGlucoseReminders = glucoseReminder
              else
                user.setGlucoseReminders = new List<GlucoseReminder>()
            });
  }

  /// Sets the Medication Reminder of the user
  static Future<void> setMedicationReminders() async {
    await ReminderMgr.getMedicationReminders(user.email)
        .then((medicationReminder) => {
              if (medicationReminder != null)
                user.setMedicationReminders = medicationReminder
              else
                user.setMedicationReminders = new List<MedicationReminder>()
            });
  }

  /// Sets the Glucose LogBook
  static Future<void> setUserGlucoseLogBook() async {
    await LogBookMgr.getGlucoseLogBook(user.email).then((glucoseLogBook) => {
          if (glucoseLogBook != null)
            user.setGlucoseLogbook = glucoseLogBook
          else
            user.setGlucoseLogbook = new GlucoseLogBook(
                glucoseRecordsList: new List<GlucoseRecord>())
        });
  }

  /// Sets the Food LogBook
  static Future<void> setUserFoodLogBook() async {
    await LogBookMgr.getFoodLogBook(user.email).then((foodLogBook) => {
          if (foodLogBook != null)
            user.setFoodLogBook = foodLogBook
          else
            user.setFoodLogBook = new FoodLogBook(new List<FoodRecord>())
        });
  }

  /// Sets the Exercise LogBook
  static Future<void> setUserExerciseLogBook() async {
    await LogBookMgr.getExerciseLogBook(user.email).then((exerciseLogBook) => {
          if (exerciseLogBook != null)
            user.setExerciseLogBook = exerciseLogBook
          else
            user.setExerciseLogBook =
                new ExerciseLogBook(new List<ExerciseRecord>())
        });
  }

  /// Retrieves the GlucoseLogBook
  static GlucoseLogBook getGlucoseLogBook() {
    print(user.glucoseLogBook);
    if (user.glucoseLogBook == null)
      user.setGlucoseLogbook =
          new GlucoseLogBook(glucoseRecordsList: new List<GlucoseRecord>());
    return user.glucoseLogBook;
  }

  /// Retrieves the Exercise LogBook
  static ExerciseLogBook getExerciseLogBook() {
    print(user.exerciseLogBook);
    if (user.exerciseLogBook == null)
      user.setExerciseLogBook = new ExerciseLogBook(new List<ExerciseRecord>());
    return user.exerciseLogBook;
  }

  /// Retrieves the Food LogBook
  static FoodLogBook getFoodLogBook() {
    print(user.foodLogBook);
    if (user.foodLogBook == null)
      user.setFoodLogBook = new FoodLogBook(new List<FoodRecord>());
    return user.foodLogBook;
  }

  /// Retrieves the Medication Reminders
  static List<MedicationReminder> getMedicationReminders() {
    return user.medicationReminders;
  }

  /// Retrieves the Glucose Reminders
  static List<GlucoseReminder> getGlucoseReminders() {
    return user.glucoseReminders;
  }

  static ExercisePlan getExercisePlan() {
    return user.exercisePlan;
  }

  static MealPlan getMealPlan() {
    return user.mealPlan;
  }
}
