import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'NavigationBar.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';
import '../controller/UserMgr.dart';

void main() {
  runApp(MaterialApp(
    title: 'Diabetes App',
    home: UpdateFoodPreference(),
    theme: ThemeData(
      // Define the default brightness and colors.
      primaryColor: Colors.teal.shade800,
      backgroundColor: Colors.pink.shade100,

      // Define the default font family.
      fontFamily: 'Roboto',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
          headline3: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          headline4: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade800),
          headline5: TextStyle(fontSize: 40, color: Colors.teal.shade800),
          headline6: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black)),
    ),),);
}

/// UI screen for displaying and setting food preferences to be used in food recommendation system.
class UpdateFoodPreference extends StatefulWidget {
  @override
  _UpdateFoodPreferenceState createState() => _UpdateFoodPreferenceState();
}

class _UpdateFoodPreferenceState extends State<UpdateFoodPreference> {

  List<bool> _isSelected = [false, false, false];
  //need to make this page and account details page match
  Map<String,dynamic> foodPreference = UserManager.getFoodPreferenceDetails();
  String _foodPreference = UserManager.getFoodPreferenceDetails()['foodPreference'];
  int _targetCalories = UserManager.getFoodPreferenceDetails()['targetCalories'];
  int _targetCarbs = UserManager.getFoodPreferenceDetails()['targetCarbs'];
  List<String> _dietRestrictions = UserManager.getFoodPreferenceDetails()['dietaryRestrictions'];
  //need to add UI field for dietary restrictions
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
     switch(_foodPreference)
  {
    case 'Vegetarian':
                      _isSelected[1]=true;
                      break;
    case 'Non-Vegetarian':
                      _isSelected[0]=true;
                      break;
    case 'Vegan':
                      _isSelected[2]=true;
                      break;
  }
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: CommonAppBar(
            title: "Food Preference",
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(30, 30, 10, 10),
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
                        switch(index)
                        {
                          case 0: _foodPreference='Non-vegetarian';
                                  break;
                          case 1: _foodPreference='Vegetarian';
                                  break;
                          case 2: _foodPreference='Vegan';
                                  break;
                        }
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
                            'Target Calories',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.teal.shade600,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            width: 120,
                            height: 50,
                            margin: EdgeInsets.only(top: 15),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                                // The validator receives the text that the user has entered.
                                initialValue: _targetCalories.toString(),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: "300",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onSaved: (String value) {
                                   _targetCalories = int.parse(value);
                           },),
                          ),
                        ],
                      ),
                      SizedBox(width: 80),
                      Column(
                        children: <Widget>[
                          Text(
                            'Target Carbs',
                            style: TextStyle(
                              color: Colors.teal.shade600,
                              fontSize: 20,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 120,
                            height: 50,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                                 initialValue: _targetCarbs.toString()  ,
                                // The validator receives the text that the user has entered.
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    hintText: "300",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                            onSaved: (String value){
                                   _targetCarbs = int.parse(value);
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  //alignment: Alignment.bottomCenter,
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(top: 80),
                  padding: EdgeInsets.only(
                    right: 30,
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      UserManager.updateFoodPref(
                          _dietRestrictions, _foodPreference, _targetCalories,
                          _targetCarbs);
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
