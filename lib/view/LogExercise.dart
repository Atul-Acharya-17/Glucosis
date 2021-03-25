import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controller/UserMgr.dart';
import './AppBar.dart';

void main() => runApp(MaterialApp(home: LogExercisePage()));

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

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.all(20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Enter duration exercised',
                        style: TextStyle(
                            fontSize: 20, color: Colors.teal.shade800),
                      ))),

              Container(
                  margin:
                      EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                  child: TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Duration",
                          labelStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20,
                          )),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      })),

              Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Enter the type of exercise',
                        style: TextStyle(
                            fontSize: 20, color: Colors.teal.shade800),
                      ))),

              Container(
                  margin:
                      EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                  child: TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "ExerciseType",
                          labelStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20,
                          )),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      })),
              // Add TextFormFields and ElevatedButton here.
              Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 10),
                      child: Text(
                        'Date&Time',
                        style: TextStyle(
                            fontSize: 20, color: Colors.teal.shade800),
                      ))),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 10),
                      padding: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatter.format(currentDate),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            IconButton(
                                icon: Icon(Icons.calendar_today_sharp),
                                onPressed: () => _selectDate(context))
                          ])),
                  Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${_time.format(context)}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                            IconButton(
                                icon: Icon(Icons.alarm_add_rounded),
                                onPressed: () => _selectTime(context))
                          ]))
                ],
              ),

              Center(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.

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
                                                  fontWeight: FontWeight.bold,
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
                        child: Text("Log Entry",
                            style: Theme.of(context).textTheme.headline3),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.pink.shade100)),
                      )))
            ])));
  }
}
