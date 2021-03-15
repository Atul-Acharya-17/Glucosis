class ExercisePlan {
  int _targetExTime;
  int _achievedExTime;
  String _exerciseLevel;
  var _recommendationTable;

  ExercisePlan({
    int targetExTime,
    int achievedExTime,
    String exerciseLevel,
    var recommendationTable,
  })  : _targetExTime = targetExTime,
        _achievedExTime = achievedExTime,
        _exerciseLevel = exerciseLevel,
        _recommendationTable = recommendationTable;

  get targetExTime => _targetExTime;
  get achievedExTime => _achievedExTime;
  get exerciseLevel => _exerciseLevel;
  get recommendationTable => _recommendationTable;
}
