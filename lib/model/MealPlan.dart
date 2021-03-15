class MealPlan {
  String _dietaryPref;
  int _targetCarbs;
  int _targetSugar;
  String _allergies;

  MealPlan({
    String dietaryPref,
    int targetCarbs,
    int targetSugar,
    String allergies,
  })  : _dietaryPref = dietaryPref,
        _targetCarbs = targetCarbs,
        _targetSugar = targetSugar,
        _allergies = allergies;

  get dietaryPref => _dietaryPref;
  get targetCarbs => _targetCarbs;
  get targetSugar => _targetSugar;
  get allergies => _allergies;
}
