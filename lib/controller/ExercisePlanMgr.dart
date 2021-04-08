import 'package:cloud_firestore/cloud_firestore.dart';

/// Controller which retrieves and manages user's chosen exercise plan from an exercise plan database.
class ExercisePlanMgr{
  static String _emailID;
  static final CollectionReference _exercisePlan = FirebaseFirestore.instance.collection('ExercisePlan');
  static final CollectionReference _chosenPlan = FirebaseFirestore.instance.collection('ChosenPlan');


  static Future<Map<String, dynamic>> setExercisePlan(String exercisePlanID) async{

    String message;
    _chosenPlan
        .doc(_emailID)
        .set({
      'Exercise': exercisePlanID
    }).then(
            (value)=> message = "Success").
    catchError((error)=> message = "Update failed");

    return {
      "message": message
    };
  }

  static Future<Map<String, dynamic>> choosePlan(String options) async{
    Map exerciseMap = {
      'Basic': "0",
      'Intermediate':"1",
      'Advanced': "2"
    };

    List objects = [];
    String message;
    try {
      String exIndex = exerciseMap[options];
      String identifier = exIndex;
      await _exercisePlan.
      doc(identifier).collection('ExerciseScheme')
          .get().then((value) => {
         value.docs.forEach((element) {
           objects.add(element);
         })
      });
      print(objects.length);

      var sortedObjects = sortExercises(objects);
      return {
        "message": "Success",
        "objects": sortedObjects
      };

    }
    catch(e){
      message = "Index Not found error";
      // failed message
      return {
        "message": message,
        "objects": []
      };
    }

  }

  static List<dynamic> sortExercises(List objects){
    print("In Sort");
    List sortedObjects = [];
    var days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    for (String day in days){
      List dayObjects = objects.where((element) => element['day'] == day).toList();
      if (dayObjects.length == 0)
        continue;
      sortedObjects.addAll(dayObjects);
    }

    return sortedObjects;
  }
}