/*
target range [min, max]
*/
import '../model/ExerciseLogBook.dart';
import '../model/GlucoseLogBook.dart';
import '../model/FoodLogBook.dart';
import '../model/ExercisePlan.dart';
import '../model/MealPlan.dart';
import '../model/MedicationReminder.dart';
import '../model/GlucoseReminders.dart';
// need to check if date of birth and target range have been added to account details, profilepage and food preference
/// Entity representing the user, their personal details, and the logbooks, plans and reminders associated with them.
class User {
  String _name;
  String _email;
  String _phoneNumber;
  String _diabetesType;
  String _location;
  double _weight;
  double _height;
  List<String> _dietRestrictions;
  String _exercisePreference;
  String _foodPreference;
  String _gender;
  int _targetCalories;
  int _targetCarbs;
  double _minGlucose;
  double _maxGlucose;
  DateTime _dateOfBirth;
  ExerciseLogBook _exerciseLogBook;
  FoodLogBook _foodLogBook;
  GlucoseLogBook _glucoseLogBook;
  List<MedicationReminder> _medicationReminders;
  List<GlucoseReminder> _glucoseReminders;
  ExercisePlan _exercisePlan;
  MealPlan _mealPlan;


  User(
      {String name,
      String email,
      String phoneNumber,
      String diabetesType,
      String location,
      double weight,
      double height,
      List<String> dietRestrictions,
      String exercisePreference,
      String foodPreference,
      String gender,
      int targetCalories,
      int targetCarbs,
      double minGlucose,
      double maxGlucose,
      DateTime dateOfBirth})
      : _name = name,
        _email = email,
        _phoneNumber = phoneNumber,
        _diabetesType = diabetesType,
        _location = location,
        _weight = weight,
        _height = height,
        _dietRestrictions = dietRestrictions,
        _exercisePreference = exercisePreference,
        _foodPreference = foodPreference,
        _gender = gender,
        _targetCalories = targetCalories,
        _targetCarbs = targetCarbs,
        _minGlucose = minGlucose,
        _maxGlucose = maxGlucose,
        _dateOfBirth = dateOfBirth;

  get name => _name;

  get height => _height;

  get weight => _weight;

  get location => _location;

  get diabetesType => _diabetesType;

  get phoneNumber => _phoneNumber;

  get email => _email;

  get dietRestrictions => _dietRestrictions;

  get exercisePreference => _exercisePreference;

  get foodPreference => _foodPreference;

  get gender => _gender;

  get targetCalories => _targetCalories;

  get targetCarbs => _targetCarbs;

  get minGlucose => _minGlucose;

  get maxGlucose => _maxGlucose;

  get dateOfBirth => _dateOfBirth;

  get exerciseLogBook => _exerciseLogBook;

  get foodLogBook => _foodLogBook;

  get glucoseLogBook => _glucoseLogBook;

  get medicationReminders =>_medicationReminders;
 
  get glucoseReminders => _glucoseReminders;

  get exercisePlan => _exercisePlan;

  get mealPlan =>_mealPlan;


  set setName(String name) {
    _name = name;
  }

  set setHeight(double height) {
    _height = height;
  }

  set setWeight(double weight) {
    _weight = weight;
  }

  set setLocation(String location) {
    _location = location;
  }

  set setPhoneNumber(String phoneNumber) {
    _phoneNumber = phoneNumber;
  }

  set setGender(String gender) {
    _gender = gender;
  }

  set setdietRestrictions(List<String> dietaryRestrictions) {
    _dietRestrictions = dietaryRestrictions;
  }

  set setFoodPreference(String foodPreference) {
    _foodPreference = foodPreference;
  }

  set setExercisePreference(String exerPreference) {
    _exercisePreference = exerPreference;
  }

  set setDiabetesType(String diabetesType) {
    _diabetesType = diabetesType;
  }

  set setTargetCalories(int calories) {
    _targetCalories = calories;
  }

  set setTargetCarbs(int carbs) {
    _targetCarbs = carbs;
  }

  set setMinTargetGlucose(double minGlucose) {
    _minGlucose = minGlucose;
  }

  set setMaxTargetGlucose(double maxGlucose) {
    _maxGlucose = maxGlucose;
  }

  set setDob(DateTime dateOfBirth) {
    _dateOfBirth = dateOfBirth;
  }

  set setGlucoseLogbook(GlucoseLogBook glucoseLogBook)
  {
    _glucoseLogBook=glucoseLogBook;
  }

  set setExerciseLogBook(ExerciseLogBook exerciseLogBook)
  {
    _exerciseLogBook=exerciseLogBook;
  }

  set setFoodLogBook(FoodLogBook foodLogBook)
  {
    _foodLogBook=foodLogBook;
  }

  set setMedicationReminders(List<MedicationReminder> medicationReminders)
  {
    _medicationReminders=medicationReminders;
  }

  set setGlucoseReminders(List<GlucoseReminder> glucoseReminders)
  {
    _glucoseReminders=glucoseReminders;
  }

  set setExercisePlan(ExercisePlan exercisePlan)
  {
    _exercisePlan=exercisePlan;
  }

  set setMealPlan(MealPlan mealPlan)
  {
    _mealPlan=mealPlan;
  }

  void addGlucoseReminder(GlucoseReminder gr)
  {
    _glucoseReminders.add(gr);
  }

  void addMedicationReminder(MedicationReminder mr)
  {
    _medicationReminders.add(mr);
  }
}
