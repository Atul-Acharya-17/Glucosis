import 'dart:math';
import 'package:flutterapp/controller/UserMgr.dart';

import '../controller/MealPlanManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'AppBar.dart';
// import 'NavigationBar.dart';
import '../model/Recipes.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';

import 'MealResult.dart';


/// UI screen for displaying and setting food preferences to be used in food recommendation system.
class UpdateFoodPreference extends StatefulWidget {
  static final routename = '/chooseRecipe';
  @override
  _UpdateFoodPreferenceState createState() => _UpdateFoodPreferenceState();
}

class _UpdateFoodPreferenceState extends State<UpdateFoodPreference> {
  @override
  final _formKey = GlobalKey<FormState>();

  final _calcontroller = TextEditingController();
  final _carbcontrolller = TextEditingController();
  final _sugarcontroller = TextEditingController();
  String dropdownValue = "";
  String cal;
  String carbs;
  String sugar;
  MealPlanMgr mgr = new MealPlanMgr();

  List<bool> _isSelected = [false, false, false];
  Widget build(BuildContext context) {
    return

      Scaffold(
        appBar: AppBar(
            title:
            Text('Choose Recipes Page', style: TextStyle(color: Colors.pink.shade100)),
            centerTitle: true,
            // add back button functionality
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.pink.shade100,
              ),
              onPressed:() {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },),
            backgroundColor: Colors.teal.shade800),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30, 30, 10, 10),
          child: Form(
            key: _formKey,
            //padding: EdgeInsets.fromLTRB(30, 30, 10, 10),
            child: Column(
              children: <Widget>[
                // Text

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Dietary Preferences',
                    style: TextStyle(
                      color: Colors.teal.shade600,
                      fontSize: 20,
                    ),
                  ),
                ),

                // Toggle Buttons

                Container(
                  margin: EdgeInsets.only(right: 5, top: 25),
                  alignment: Alignment.topLeft,
                  child: CustomToggleButtons(
                    spacing: 10.0,
                    unselectedFillColor: Colors.pink.shade50,
                    fillColor: Colors.pink.shade100,
                    isSelected: _isSelected,
                    selectedColor: Colors.black,
                    children: <Widget>[
                      Text(
                        'Non-vegetarian',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Veg',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Vegan',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                    onPressed: (index) {
                      setState(() {
                        for (int i = 0; i < _isSelected.length; i++) {
                          _isSelected[i] = false;
                        }
                        _isSelected[index] = true;
                      });
                    },
                  ),
                ),

                // Container
                Container(
                  margin: EdgeInsets.only(right: 5, top: 50),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'Target Carbs',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.teal.shade600,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 60,
                            margin: EdgeInsets.only(top: 15),
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                                controller: _carbcontrolller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: "mg",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                onChanged: (val){
                                  setState(() {
                                    carbs = _carbcontrolller.text.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter';
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      ),
                      SizedBox(width: 80),
                      Column(
                        children: <Widget>[
                          Text(
                            'Target Sugar',
                            style: TextStyle(
                              color: Colors.teal.shade600,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 120,
                            height: 60,
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                                controller: _sugarcontroller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: "mg",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                onChanged: (val){
                                  setState(() {
                                    sugar = _sugarcontroller.text.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter';
                                  }
                                  return null;
                                }),
                          ),
                        ],
                      ),

                    ],
                  ),

                ),

                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(  top: 25),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Target Calories',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.teal.shade600,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 60,
                        margin: EdgeInsets.only(top: 15),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                            controller: _calcontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                hintText: "kcal",
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20,
                                )),
                            onChanged: (val){
                              setState(() {
                                cal = _calcontroller.text.toString();
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter';
                              }
                              return null;
                            }),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   child: DropdownButton<String>(
                //     value: dropdownValue,
                //     icon: Icon(Icons.arrow_downward),
                //     iconSize: 24,
                //     elevation: 16,
                //     style: TextStyle(color: Colors.teal.shade800),
                //     underline: Container(
                //       height: 2,
                //       color: Colors.green[900],
                //     ),
                //     onChanged: (String newValue) {
                //       setState(() {
                //         dropdownValue = newValue;
                //       });
                //     },
                //     items: <String>['Peanuts', 'Pills', 'g']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(
                //           value,
                //           style: TextStyle(fontSize: 20),
                //         ),
                //       );
                //     }).toList(),
                //   ),
                // ),

                Container(
                  //alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.only(
                    right: 30,
                  ),
                  child: RaisedButton(
                    onPressed: () async{
                      if (_formKey.currentState.validate()) {
                        print("Cal ${cal}");
                        print("Carbs ${carbs}");
                        print("Sugar ${sugar}");
                        print(_isSelected);
                        var diet;
                        if (_isSelected[0] = true)
                          diet = "";
                        if (_isSelected[1])
                          diet = 'Vegetarian';
                        if (_isSelected[2])
                          diet = 'Vegan';
                        Map<String, dynamic> request = {
                          "diet": diet,
                          //"intolerances": "",
                          //"minCarbs": [int.parse(carbs)-75,0].reduce((curr, next) => curr > next? curr: next).toString(),
                          "maxCarbs": carbs,
                          //"minCalories": [int.parse(cal)-200,0].reduce((curr, next) => curr > next? curr: next).toString(),
                          "maxCalories": cal,
                          "minSugar": "0",
                          "maxSugar": sugar,
                          "number": "10",
                          "addRecipeInformation": "true"
                        };
                        List<Recipe> response = await mgr.fetchRecipes(request);
                        print (response);
                        if (diet == "")
                          diet = "Non-Vegetarian";

                        List<String> dietRestrictions = [""];

                        UserManager.updateFoodPref(
                           dietRestrictions , diet, int.parse(cal),
                            int.parse(carbs));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new mealResultsPage(response),
                            ));
                      }
                      // print("Cal ${cal}");
                      // print("Carbs ${carbs}");
                      // print("Sugar ${sugar}");
                      // print(_isSelected);
                    },
                    color: Colors.pink[100],
                    child: Text(
                      'Update Preferences',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                // Button to confirm

              ],
            ),
          ),
        ),
      );
  }
}