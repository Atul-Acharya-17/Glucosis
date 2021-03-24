
import 'package:cloud_firestore/cloud_firestore.dart';


class MealPlanMgr{
  final String _emailID;
  final CollectionReference _MealPlan;
  final CollectionReference _chosenPlan;
  MealPlanMgr({String email})
    : _emailID = email,
      _MealPlan = FirebaseFirestore.instance.collection('MealPlans'),
      _chosenPlan = FirebaseFirestore.instance.collection('ChosenPlan');


  Future<Map<String, dynamic>> setMealPlan(String mealPlanID) async{

    String message;
    _chosenPlan
        .doc(_emailID)
        .set({
          'Meal': mealPlanID
    }).then(
        (value)=> message = "Success").
    catchError((error)=> message = "Update failed");

    return {
      "message": message
    };
  }

  Future<Map<String, dynamic>> choosePlan(String diet, String calories, String allergies) async{

    Map<String, int> dietMap = {
      'Vegetarian': 0,
      'Non-vegetarian':1,
      'Vegan': 2
    };

    Map<String, int> calMap = {
      '500-1000': 0,
      '1000-1500':1,
      '1500-2000': 2,
      '2000-3000': 3
    };

    Map<String, int> allerMap = {

      'Peanuts': 0,
      'Groundnuts':1,
    };
    List objects = [];
    String message;
    try {
      int dietIndex = dietMap[diet];
      int calIndex = calMap[calories];
      int allerIndex = allerMap[allergies];
      String identifier = '($dietIndex, $calIndex, $allerIndex)';
      _MealPlan.
      where('identifier', isEqualTo: identifier)
      .get()
      .then((querySnapshot){
        message = "Success";
        querySnapshot.docs.forEach((result) {
          objects.add(result.data());
        });
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