import 'package:flutter/painting.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import '../controller/MealPlanManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'NavigationBar.dart';
import 'Drawer.dart';

// import 'AppBar.dart';
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
  Map<String, dynamic> _restrictions = {
    'Dairy': false,
    'Peanut': true,
    'Seafood': true,
    'Gluten': true,
    'Egg': false
  };
  List<bool> _isSelected = [false, false, false];


  Widget _buildPreference() {
    return Container(
      alignment: Alignment.topLeft,
      child: CustomToggleButtons(
        spacing: 10.0,
        unselectedFillColor: Theme.of(context).primaryColorLight,
        fillColor: Theme.of(context).primaryColor,
        isSelected: _isSelected,
        selectedColor: Colors.black,
        borderColor: Colors.transparent,
        children: <Widget>[
          Text(
            'Non-vegetarian',
          ),
          Text(
            'Vegetarian',
          ),
          Text(
            'Vegan',
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
    );
  }

  Widget _buildCarbs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Target carbs',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Row(children: <Widget>[
          Container(
            width: 120,
            height: 50,
            child: TextFormField(
                // The validator receives the text that the user has entered.
                controller: _carbcontrolller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "0"),
                onChanged: (val) {
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
          SizedBox(width: 5),
          Container(
            height: 20,
            child: Text("mg"),
          ),
        ]),
      ],
    );
  }

  Widget _buildSugar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Target Sugar',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Row(children: <Widget>[
          Container(
            width: 120,
            height: 50,
            child: TextFormField(
                controller: _sugarcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "0"),
                onChanged: (val) {
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
          SizedBox(width: 5),
          Container(
            height: 20,
            child: Text("mg"),
          ),
        ]),
      ],
    );
  }

  Widget _buildRestrictions() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Dietary restrictions",
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 5),
          Container(
            height: 25,
            child: Row(children: <Widget>[
              Text(
                "Dairy",
              ),
              Checkbox(
                checkColor: Colors.black,
                activeColor: Theme.of(context).primaryColorLight,
                value: _restrictions['Dairy'],
                onChanged: (bool value) {
                  setState(() {
                    _restrictions['Dairy'] = value;
                  });
                },
              ),
              const SizedBox(width: 10),
              Text(
                "Peanuts",
              ),
              Checkbox(
                checkColor: Colors.black,
                activeColor: Theme.of(context).primaryColorLight,
                value: _restrictions['Peanut'],
                onChanged: (bool value) {
                  setState(() {
                    _restrictions['Peanut'] = value;
                  });
                },
              ),
              Text(
                "Seafood",
              ),
              Checkbox(
                checkColor: Colors.black,
                activeColor: Theme.of(context).primaryColorLight,
                value: _restrictions['Seafood'],
                onChanged: (bool value) {
                  setState(() {
                    _restrictions['Seafood'] = value;
                  });
                },
              ),
            ]),
          ),
          Container(
            height: 25,
            child: Row(children: <Widget>[
              Text(
                "Gluten",
              ),
              Checkbox(
                checkColor: Colors.black,
                activeColor: Theme.of(context).primaryColorLight,
                value: _restrictions['Gluten'],
                onChanged: (bool value) {
                  setState(() {
                    _restrictions['Gluten'] = value;
                  });
                },
              ),
              Text(
                "Egg",
              ),
              Checkbox(
                checkColor: Colors.black,
                activeColor: Theme.of(context).primaryColorLight,
                value: _restrictions['Egg'],
                onChanged: (bool value) {
                  setState(() {
                    _restrictions['Egg'] = value;
                  });
                },
              ),
            ]),
          )
        ]);
  }

  Widget _buildCalories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Target calories',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Row(children: <Widget>[
          Container(
            width: 120,
            height: 50,
            child: TextFormField(
                // The validator receives the text that the user has entered.
                controller: _calcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: "0"),
                onChanged: (val) {
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
          SizedBox(width: 5),
          Container(
            height: 20,
            child: Text("kcal"),
          ),
        ]),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          title: Text('Choose Recipes Page',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          centerTitle: true,
          toolbarHeight: MediaQuery.of(context).size.height * 0.062,
          // add back button functionality
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          backgroundColor: Theme.of(context).backgroundColor),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: NavigationBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Dietary Preferences',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              SizedBox(height: 5),
              _buildPreference(),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[_buildCarbs(), _buildSugar()]),
              SizedBox(height: 20),
              _buildCalories(),
              SizedBox(height: 20),
              _buildRestrictions(),
              SizedBox(height: 30),
              Center(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          print("Cal ${cal}");
                          print("Carbs ${carbs}");
                          print("Sugar ${sugar}");
                          print(_isSelected);
                          var diet;
                          if (_isSelected[0] = true) diet = "";
                          if (_isSelected[1]) diet = 'Vegetarian';
                          if (_isSelected[2]) diet = 'Vegan';
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
                            "addRecipeInformation": "true",
                            "sort": "random"
                          };
                          List<Recipe> response =
                              await mgr.fetchRecipes(request);
                          print(response);
                          if (diet == "") diet = "Non-Vegetarian";

                          List<String> dietRestrictions = [""];

                          UserManager.updateFoodPref(dietRestrictions, diet,
                              int.parse(cal), int.parse(carbs));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    new mealResultsPage(response),
                              ));
                        }
                        // print("Cal ${cal}");
                        // print("Carbs ${carbs}");
                        // print("Sugar ${sugar}");
                        // print(_isSelected);



                      },
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Update Preferences\nand View Recipes',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
