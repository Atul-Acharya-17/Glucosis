import 'package:flutter/material.dart';
import 'AppBar.dart';
import 'NavigationBar.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';

void main() {
  runApp(UpdateFoodPreference());
}

class UpdateFoodPreference extends StatefulWidget {
  @override
  _UpdateFoodPreferenceState createState() => _UpdateFoodPreferenceState();
}

class _UpdateFoodPreferenceState extends State<UpdateFoodPreference> {
  @override
  List<bool> _isSelected = [false, false, false];
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CommonAppBar(
          title: "Food Preference",
        ),
        bottomNavigationBar: NavigationBar(),
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
                          height: 50,
                          margin: EdgeInsets.only(top: 15),
                          child: TextFormField(
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
                          height: 50,
                          child: TextFormField(
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
                  onPressed: () {},
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
