import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/model/MedicationReminder.dart';
import 'package:flutterapp/view/NavigationBar.dart';
import 'package:flutterapp/view/CustomRadioButton.dart';
import './AppBar.dart';
import 'Drawer.dart';
import 'package:intl/intl.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';

void main() => MaterialApp(
      title: 'Diabetes App',
      home: MedicationPage(),
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
    );

/// UI screen for viewing and creating medication reminders.
class MedicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Medication',
      ),
      body: MedicationBody(),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: NavigationBar(),
    );
  }
}

class MedicationBar extends StatelessWidget implements PreferredSizeWidget {
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
          'Medication',
          style: TextStyle(
            fontSize: appBarTextSize,
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

class MedicationBody extends StatefulWidget {
  @override
  createState() {
    return new MedicationBodyState();
  }
}

class MedicationBodyState extends State<MedicationBody> {
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'mL';
  TimeOfDay _time = TimeOfDay.now();

  String dosage;
  String medicineName;
  String type;
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  final double iconSize = 56;
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);

  Future<List<Widget>> buildReminders() async {
    DateFormat dateFormat = DateFormat("HH:mm");
    List<Widget> reminderWidgets = new List<Widget>();

    var reminders = await ReminderMgr.getRemindersWithKey('Medication');
    var keys = reminders.keys.toList();

    for (int i = 0; i < reminders.length; ++i) {
      Color color = Theme.of(context).primaryColor;
      if (i % 2 == 0) {
        color = Theme.of(context).primaryColorLight;
      }
      ;
      Widget rem = Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: color,
        child: Row(children: [
          Column(children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 110,
                  child: Text(
                    (reminders[keys[i]] as MedicationReminder).medicineName,
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 45,
                  child: Text(
                    (reminders[keys[i]] as MedicationReminder)
                        .dosage
                        .toString(),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  width: 45,
                  child: Text(
                    dateFormat.format(
                        (reminders[keys[i]] as MedicationReminder).timing),
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(width: 10),
          Column(children: <Widget>[
            Container(
              width: 20,
              child: IconButton(
                  onPressed: () {
                    ReminderMgr.deleteReminder('Medication', keys[i]);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete)),
            )
          ]),
        ]),
      );
      reminderWidgets.add(rem);
    }
    if (reminderWidgets.length == 0) {
      reminderWidgets.add(SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ));
    }
    return reminderWidgets;
    // Get List of Medication Reminders
    // Make sure you retrieve the index of reminders also
    // In the onPressed of the button, delete the index from the database
    // and call setState
  }

  List<bool> _isSelected = [false, false];

  Widget _buildType() {
    return Container(
      alignment: Alignment.topLeft,
      child: CustomToggleButtons(
        borderColor: Colors.transparent,
        spacing: 20.0,
        unselectedFillColor: Theme.of(context).primaryColorLight,
        fillColor: Theme.of(context).primaryColor,
        isSelected: _isSelected,
        selectedColor: Colors.black,
        children: <Widget>[
          Text(
            'Pills',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            'Syringe',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
        onPressed: (index) {
          setState(() {
            _isSelected[1 - index] = false;
            _isSelected[index] = true;
            if (_isSelected[0]) {
              type = "Pills";
            } else {
              type = "Syringe";
            }
          });
        },
      ),
    );
  }

  Widget _buildTiming() {
    return SizedBox(
      width: double.infinity,
      child: Container(
          padding: EdgeInsets.only(left: 10),
          width: MediaQuery.of(context).size.width * 0.40,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(5.0)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("${_time.format(context)}",
                style: TextStyle(fontSize: 20, color: Colors.black)),
            IconButton(
                icon: Icon(Icons.alarm_add_rounded),
                onPressed: () => _selectTime(context))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    buildReminders();

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double normalFontSize = width * 0.06;
    final double miniFontSize = normalFontSize - 5;

    return FutureBuilder<List<Widget>>(
        future: buildReminders(),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          Widget child;

          if (snapshot.hasData) {
            child = SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        margin: EdgeInsets.only(bottom: margin),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 200,
                          width: double.infinity,
                          child: SingleChildScrollView(
                              child: Column(children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: Text(
                                  "Daily Schedule",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Column(
                                children: snapshot.data,
                              ),
                            ),
                          ])),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Card(
                              elevation: 2,
                              margin: EdgeInsets.only(bottom: margin),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                              ),
                              color: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Add Reminder',
                                      style: Theme.of(context).textTheme.headline1,
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Select type of medication',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(height: 5),
                                    _buildType(),
                                    SizedBox(height: 10),
                                    Text(
                                      'Enter name of medication',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(height: 5),
                                    Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey[400]),
                                          borderRadius:
                                              BorderRadius.circular(5.0)),
                                      child: TextFormField(
                                        decoration: new InputDecoration(
                                            fillColor: Colors.white,
                                            filled: true,
                                            hintText: "Name"),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                        onSaved: (String value) {
                                          medicineName = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Enter dosage',
                                      style:
                                      Theme.of(context).textTheme.headline4,
                                    ),
                                SizedBox(height: 5),
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey[400]),
                                      borderRadius:
                                      BorderRadius.circular(5.0)),
                                  child:
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            width: 210,
                                            child: TextFormField(
                                              // The validator receives the text that the user has entered.
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <
                                                  TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              // Only numbers can be entered
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                              onSaved: (String value) {
                                                dosage = value;
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: DropdownButton<String>(
                                              value: dropdownValue,
                                              icon: Icon(Icons.arrow_downward),
                                              iconSize: 24,
                                              elevation: 5,
                                              style: TextStyle(
                                                  color: Colors.teal.shade800),
                                              onChanged: (String newValue) {
                                                setState(() {
                                                  dropdownValue = newValue;
                                                });
                                              },
                                              items: <String>[
                                                'mL',
                                                'Pills',
                                                'g'
                                              ].map<DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),),
                                    SizedBox(height: 10),
                                    Text(
                                      'Timing',
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    ),
                                    SizedBox(height: 5),
                                    _buildTiming(),
                                    SizedBox(height: 20),
                                    Center(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.07,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                              // background
                                              onPrimary:
                                                  Colors.black, // foreground
                                            ),
                                            onPressed: () async {
                                              // Validate returns true if the form is valid, otherwise false.
                                              if (_formKey.currentState
                                                  .validate()) {
                                                _formKey.currentState.save();

                                                DateTime now =
                                                    new DateTime.now();

                                                Map<String, dynamic> data = {};
                                                data['medicineName'] =
                                                    medicineName;
                                                data['dosage'] = dosage +
                                                    " " +
                                                    dropdownValue;
                                                data['type'] = type;
                                                data['timing'] = DateTime(
                                                    now.year,
                                                    now.month,
                                                    now.day,
                                                    _time.hour,
                                                    _time.minute);
                                                ReminderMgr.addReminder(
                                                    'Medication', data);
                                                setState(() {});
                                                return showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  // user must tap button!
                                                  builder:
                                                      (BuildContext context) {
                                                    // can add logic to store entry here
                                                    return AlertDialog(
                                                      //title: Text('AlertDialog Title'),
                                                      content:
                                                          SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Text(
                                                                'Medication reminder is set',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        30,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .black)),
                                                            SizedBox(
                                                                height: 20),
                                                            TextButton(
                                                              child: Text('OK',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .black)),
                                                              style: ButtonStyle(
                                                                  backgroundColor:
                                                                      MaterialStateProperty.all<
                                                                          Color>(Colors
                                                                              .green[
                                                                          500])),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
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
                                            child: Text("Create reminder",
                                                style: Theme.of(context).textTheme.button,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            child = Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            child = Column(children: [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
              //Padding(
              //padding: EdgeInsets.only(top: 16),
              //child: Text('Awaiting result...'),
              //)
            ]);
          }

          return child;
        });
  }

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
}
