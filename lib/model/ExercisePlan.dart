/// Entity containing details about exercise plan for a user.
class ExercisePlan {
  /// In minutes.
  int _targetExTime;
  /// In minutes.
  int _achievedExTime;
  /// Basic, intermediate, or advanced.
  String _exerciseLevel;
  String _id;
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
  get id => _id;
  get recommendationTable => _recommendationTable;
}
