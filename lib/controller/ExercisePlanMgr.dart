
import 'package:cloud_firestore/cloud_firestore.dart';


class ExercisePlanMgr{
  final String _emailID;
  final CollectionReference _exercisePlan;
  final CollectionReference _chosenPlan;
  ExercisePlanMgr({String email})
      : _emailID = email,
        _exercisePlan = FirebaseFirestore.instance.collection('ExercisePlan'),
        _chosenPlan = FirebaseFirestore.instance.collection('ChosenPlan');


  Future<Map<String, dynamic>> setexercisePlan(String exercisePlanID) async{

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

  Future<Map<String, dynamic>> choosePlan(String options) async{
    Map exerciseMap = {
      'Beginner': "1",
      'Intermediate':"2",
      'Advanced': "3"
    };

    List objects = [];
    String message;
    try {
      String exIndex = exerciseMap[options];
      String identifier = exIndex;
      _exercisePlan.
      doc(identifier)
          .get()
          .then((querySnapshot){
        message = "Success";
        objects.add(querySnapshot.data());
      });
      return {
        "message": message,
        "objects": objects
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
}