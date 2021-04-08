import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/view/NavigationBar.dart';
import 'package:intl/intl.dart';
import './AppBar.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';

import 'Drawer.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Diabetes App',
      home: LogGlucosePage(),
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
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            headline4: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800),
            headline5: TextStyle(fontSize: 40, color: Colors.teal.shade800),
            headline6: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    ),
  );
}

/// UI screen for logging new blood glucose level entries.
class LogGlucosePage extends StatefulWidget {
  @override
  LogGlucosePageState createState() => LogGlucosePageState();
}

class LogGlucosePageState extends State<LogGlucosePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: CustomDrawer(),
      backgroundColor: Theme.of(context).canvasColor,
      appBar: CommonAppBar(
        title: 'Log Blood Glucose',
      ),
      bottomNavigationBar: NavigationBar(),
      body: SingleChildScrollView(
        child: MyCustomForm(),
      ),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  List<bool> _isSelected = [false, false];
  double _glucoseLevel;
  bool _beforeMeal;
  bool beforeMeal;

  DateTime currentDate = DateTime.now().toLocal();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  TimeOfDay _time = TimeOfDay.now();

  void _selectTime(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  Widget _buildDateTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme.of(context).shadowColor),
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatter.format(currentDate)),
                  IconButton(
                      icon: Icon(Icons.calendar_today_sharp),
                      onPressed: () => _selectDate(context))
                ])),
        Container(
            padding: EdgeInsets.only(left: 10),
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Theme.of(context).shadowColor),
                borderRadius: BorderRadius.circular(5.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${_time.format(context)}"),
                  IconButton(
                      icon: Icon(Icons.alarm_add_rounded),
                      onPressed: () => _selectTime(context))
                ]))
      ],
    );
  }

  Widget _buildGlucose() {
    return Row(
      children: [
        Container(
          width: 150,
          child: TextFormField(
            // The validator receives the text that the user has entered.
            decoration: new InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
                hintText: "000.00",
                labelStyle: TextStyle(
                  color: Colors.teal.shade800,
                  fontSize: 20,
                )),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              _glucoseLevel = double.parse(value);
              return null;
            },
          ),
        ),
        SizedBox(width: 5),
        Text(
          'mg/dL',
          style: TextStyle(color: Colors.black),
        )
      ],
    );
  }

  Widget _buildTiming() {
    return Container(
      alignment: Alignment.topLeft,
      child: CustomToggleButtons(
        spacing: 20.0,
        unselectedFillColor: Theme.of(context).primaryColorLight,
        fillColor: Theme.of(context).primaryColor,
        isSelected: _isSelected,
        selectedColor: Colors.black,
        children: <Widget>[
          Text(
            'Before meal',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            'After meal',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
        onPressed: (index) {
          setState(() {
            _isSelected[1 - index] = false;
            _isSelected[index] = true;
            _beforeMeal = _isSelected[0];
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Blood glucose level (mg/dL)',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 5),
              _buildGlucose(),
              const SizedBox(height: 15),
              Text(
                'Timing',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 5),
              _buildTiming(),
              const SizedBox(height: 15),
              Text(
                'Date and time',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 5),
              _buildDateTime(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Text("Log glucose entry",
                      style: Theme.of(context).textTheme.button),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      print(_beforeMeal);
                      print(_glucoseLevel);
                      print(currentDate);
                      print(_time);

                      LogBookMgr.addGlucoseRecord(
                          _glucoseLevel, currentDate, _beforeMeal);

                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          // can add logic to store entry here
                          return AlertDialog(
                            //title: Text('AlertDialog Title'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Glucose Logged',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                  SizedBox(height: 20),
                                  TextButton(
                                    child: Text('OK',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green[500])),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // can't center button if put in actions
                            // actions: <Widget>[
                            //     TextButton(
                            //     child: Text('OK',style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:Colors.black)),
                            //     style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.green[500]) ),
                            //     onPressed: () {
                            //       Navigator.of(context).pop();
                            //     },
                            //   ),

                            // ],
                          );
                        },
                      );
                    }
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
