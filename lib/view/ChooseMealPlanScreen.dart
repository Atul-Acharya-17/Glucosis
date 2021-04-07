import 'package:flutter/material.dart';
import 'package:flutterapp/view/AppBar.dart';
import 'AppBar.dart';
import 'Drawer.dart';
import 'NavigationBar.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Diabetes App',
      home: ChooseMealPlan(),
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
      ),),
  );
}

/*
enum SingingCharacter { lafayette, jefferson }

class ChooseMealPlan extends StatefulWidget {
  @override
  _ChooseMealPlanState createState() => _ChooseMealPlanState();
}

class _ChooseMealPlanState extends State<ChooseMealPlan> {
  @override
  String _plan = 'None';
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose Meal Plan'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade800,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: null),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    _plan = 'Selected Plan 1';
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Text('Plan 1'),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text('9:00 - Eggs'),
                      Text('13:00 - Apples'),
                      Text('19:00 - Bananas'),
                    ]),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _plan = 'Selected Plan 2';
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(children: <Widget>[
                      Text('Plan 2'),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text('9:00 - Eggs'),
                      Text('13:00 - Apples'),
                      Text('19:00 - Bananas'),
                    ]),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _plan = 'Selected Plan 3';
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(children: <Widget>[
                      Text('Plan 3'),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text('9:00 - Eggs'),
                      Text('13:00 - Apples'),
                      Text('19:00 - Bananas'),
                    ]),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              Text(
                _plan,
                style: TextStyle(
                  color: Colors.teal.shade400,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  child: Text(
                    'Confirm',
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.lightGreen;
                        return Colors
                            .lightGreen; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _plan = 'Confirmed Plan';
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
 */

class ChooseMealPlan extends StatefulWidget {
  @override
  _ChooseMealPlanState createState() => _ChooseMealPlanState();
}

class _ChooseMealPlanState extends State<ChooseMealPlan> {
  List<bool> _isSelected = [false, false, false];
  Color selectedColor = Colors.teal.shade100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: CustomDrawer(),
        appBar: CommonAppBar(title: 'Choose Meal Plan'),
        bottomNavigationBar: NavigationBar(),
        body: Container(
          padding: EdgeInsets.only(top: 20, left: 30, right: 30),
          child: Column(
            children: <Widget>[
              /*
              Shift the button content logic to a function

               */

              // Button 1
              RaisedButton(
                color: _isSelected[0] ? Colors.teal.shade50 : Color(0xfffafaff),
                onPressed: () {
                  changeActiveButton(0);
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
                child: Column(children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0)),
                      color: Colors.teal.shade600,
                    ),
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Text(
                      "Plan 1",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Breakfast - Eggs, Bananas, Apples",
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Lunch - Pasta, Tomatoes, Yoghurt",
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Dinner - Salad",
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              SizedBox(height: 20),
              RaisedButton(
                color: _isSelected[1] ? Colors.teal.shade50 : Color(0xfffafaff),
                onPressed: () {
                  changeActiveButton(1);
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
                child: Column(children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0)),
                      color: Colors.teal.shade600,
                    ),
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Text(
                      "Plan 2",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Breakfast - Eggs, Bananas, Apples",
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Lunch - Pasta, Tomatoes, Yoghurt",
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Dinner - Salad",
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              SizedBox(height: 20),

              RaisedButton(
                color: _isSelected[2] ? Colors.teal.shade50 : Color(0xfffafaff),
                onPressed: () {
                  changeActiveButton(2);
                },
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0),
                ),
                padding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 20),
                child: Column(children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0)),
                      color: Colors.teal.shade600,
                    ),
                    alignment: Alignment.topCenter,
                    width: double.infinity,
                    child: Text(
                      "Plan 3",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Breakfast - Eggs, Bananas, Apples",
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Lunch - Pasta, Tomatoes, Yoghurt",
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Dinner - Salad",
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              Container(
                //alignment: Alignment.bottomCenter,
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                ),
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.pink[100],
                  child: Text(
                    'Confirm Plan',
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
            ],
          ),
        ),
      );
  }

  List<Widget> getButtons() {
    List<Widget> buttons = new List<Widget>();

    // Logic here
  }

  void changeActiveButton(int index) {
    setState(() {
      _isSelected = [false, false, false];
      _isSelected[index] = true;
    });
  }
}