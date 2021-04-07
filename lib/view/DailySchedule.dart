import 'package:flutter/material.dart';
import 'package:flutterapp/model/GlucoseRecord.dart';
import 'package:flutterapp/model/GlucoseReminders.dart';
// import 'package:flutter/services.dart';
import 'package:flutterapp/view/NavigationBar.dart';
// import 'package:flutterapp/view/CustomRadioButton.dart';
import './AppBar.dart';
import 'package:flutterapp/controller/ReminderMgr.dart';

import 'Drawer.dart';

void main() => runApp(
      MaterialApp(
        title: 'Diabetes App',
        home: DailySchedule(),
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

/// UI component for setting daily blood glucose reading reminders.
class DailySchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Daily Schedule'),
      body: DailyScheduleBody(),
      bottomNavigationBar: NavigationBar(),
      endDrawer: CustomDrawer(),
    );
  }
}

class DailyScheduleBar extends StatelessWidget implements PreferredSizeWidget {
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double appBarTextSize = height * 0.035;
    final double appBarIconSize = width * 0.07;

    return AppBar(
      backgroundColor: green,
      leading: GestureDetector(
        onTap: () {},
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: appBarIconSize,
            color: pink,
          ),
          onPressed: () {},
        ),
      ),
      title: Center(
        child: Text(
          'Create Daily Schedule',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(254, 179, 189, 1),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: new Image.asset('images/user_icon.jpeg'),
          iconSize: appBarIconSize,
          padding: EdgeInsets.only(right: 18.0),
          onPressed: () {},
        ),
      ],
    );
  }
}

class DailyScheduleBody extends StatefulWidget {
  @override
  createState() {
    return new DailyScheduleBodyState();
  }
}

class DailyScheduleBodyState extends State<DailyScheduleBody> {
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  final double iconSize = 56;
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: MyCustomForm());
    throw UnimplementedError();
  }
}

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
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 700,
            child: Container(
                child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 10),
                    child: Text(
                      'Set Reminder',
                      style:
                          TextStyle(fontSize: 20, color: Colors.teal.shade800),
                    ))),
          ),
          Row(
            children: [
              SizedBox(width: 10),
              SizedBox(
                width: 350,
                child: Container(
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
                          style: TextStyle(fontSize: 20, color: Colors.black)),
                      IconButton(
                          icon: Icon(Icons.alarm_add_rounded),
                          onPressed: () => _selectTime(context))
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            width: 400,
            child: Text(
              '+ Add reminder',
              style: TextStyle(
                fontSize: 15,
                color: Colors.teal.shade800,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      primary: Colors.pink[100], // background
                      onPrimary: Colors.black, // foreground
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.

                        DateTime now = new DateTime.now();

                        ReminderMgr().addGlucoseReminder(DateTime(now.year,
                            now.month, now.day, _time.hour, _time.minute));

                        /*

                        Change to form data

                        GlucoseReminderMgr mgr =
                            new GlucoseReminderMgr('nishasnr@gmail.com');
                        DateTime date = DateTime.parse("1969-07-20 20:18:04Z");
                        GlucoseReminder ent = GlucoseReminder(timings: date);
                        mgr.addReminder(ent);
                         */
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
                                    Text('Glucose reminder is set',
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
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green[500])),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child:
                        Text("Create Schedule", style: TextStyle(fontSize: 25)),
                  )))
        ],
      ),
    );
  }
}
