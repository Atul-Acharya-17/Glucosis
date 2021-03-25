/// Entity representing details about a meal plan from the food recommendation system.
class MealPlan {
  String _dietaryPref;
  //_targetCarbs;
  //int _targetSugar;
  String _targetCal;
  String _allergies;
  String _id;

  MealPlan({
    String dietaryPref,
    String targetCal,
    String allergies,
    String id
  })  : _dietaryPref = dietaryPref,
        _targetCal = targetCal,
        _allergies = allergies,
        _id = id;

  get dietaryPref => _dietaryPref;
  get calories => _targetCal;
  get allergies => _allergies;
  get id => _id;

}
