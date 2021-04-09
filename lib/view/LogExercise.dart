import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:intl/intl.dart';
import '../controller/UserMgr.dart';
import './AppBar.dart';
import 'Drawer.dart';
import 'NavigationBar.dart';

void main() => runApp(
      MaterialApp(
        title: 'Diabetes App',
        home: LogExercisePage(),
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
        ),
      ),
    );

/// UI screen for logging new exercise entries.
class MyAppLogExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //used this for testing usermanager
    /*UserManager userManager=new UserManager();
    userManager.retrieveDetails("nishasnr@gmail.com");
    userManager.addUser("nisha952001@gmail.com", DateTime.utc(2000, 11, 9), "type2", ["ketchup"], "advanced", "vegetarian", "female", 1.7, "singapore", "nisha", 84672918, 1800, 50, {'start':80, 'end':100});
    */

    return MaterialApp(home: LogExercisePage());
  }
}

class LogExercisePage extends StatefulWidget {
  @override
  LogExercisePageState createState() => LogExercisePageState();
}

class LogExercisePageState extends State<LogExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        bottomNavigationBar: NavigationBar(),
        endDrawer: CustomDrawer(),
        appBar: CommonAppBar(title: 'Log Exercise'),
        body: SingleChildScrollView(
          /// Flutter code sample for Form
          child: MyCustomForm(),
        ));
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  String _exerciseName;
  int _duration;

  DateTime _currentDate = DateTime.now().toLocal();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: _currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != _currentDate)
      setState(() {
        _currentDate = pickedDate;
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

  Widget _buildDuration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter duration exercised',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 250,
                child: TextFormField(
                    // The validator receives the text that the user has entered.
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        hintText: "0",
                        filled: true,
                        labelStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                        )),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      this._duration = int.parse(value);
                      return null;
                    }),
              ),
              Text('minutes'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Enter type of exercise',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: 5),
        Container(
          child: TextFormField(
              // The validator receives the text that the user has entered.
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  hintText: "Exercise name",
                  filled: true,
                  labelStyle: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                this._exerciseName = value;
                return null;
              }),
        ),
      ],
    );
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
                  Text(formatter.format(_currentDate)),
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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildType(),
                  SizedBox(height: 15),
                  _buildDuration(),
                  SizedBox(height: 15),
                  Text(
                    'Date and time',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 5),
                  _buildDateTime(),
                  const SizedBox(height: 30),
                  Center(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                print(_exerciseName);
                                print(_duration);
                                print(_time);
                                print(_currentDate);

                                LogBookMgr.addExerciseRecord(
                                    _currentDate, _exerciseName, _duration);

                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    // can add logic to store entry here
                                    return AlertDialog(
                                      //title: Text('AlertDialog Title'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('Exercise Logged',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Text('Keep up the effort!',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            SizedBox(height: 20),
                                            TextButton(
                                              child: Text('OK',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black)),
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
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
                            child: Text("Log Exercise Entry",
                                style: Theme.of(context).textTheme.button),
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              primary: Theme.of(context).primaryColor,
                            ),
                          )))
                ])));
  }
}
