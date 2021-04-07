import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/view/NavigationBar.dart';
import 'package:flutterapp/view/CustomRadioButton.dart';
import './AppBar.dart';
import 'Drawer.dart';

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
  final double borderRadius = 10;
  final double margin = 5;
  final double padding = 5;
  final double iconSize = 56;
  final Color backgroundColor = Color.fromRGBO(180, 180, 180, 0.2);
  final Color green = Color.fromRGBO(0, 110, 96, 1);
  final Color pink = Color.fromRGBO(254, 179, 189, 1);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double normalFontSize = width * 0.06;
    final double miniFontSize = normalFontSize - 5;

    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.all(10),
                    color: Colors.white,
                    child: Column(children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Color(0xFD2765),
                          child: Text(
                            "Daily Schedule",
                            style: TextStyle(
                                color: Colors.pink[400],
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              color: Colors.pink[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Crocin',
                                        ),
                                        SizedBox(width: 30),
                                        Text(
                                          '1 pill',
                                        ),
                                        SizedBox(width: 30),
                                        Text(
                                          '09:00',
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Column(children: <Widget>[
                                    Row(children: <Widget>[
                                      IconButton(
                                        onPressed: null,
                                        icon: Icon(Icons.edit),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.delete))
                                    ])
                                  ]),
                                ],
                              ),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01),
                            Container(
                              color: Colors.pink[100],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'Insulin',
                                        ),
                                        SizedBox(width: 30),
                                        Text(
                                          '50 ml',
                                        ),
                                        SizedBox(width: 30),
                                        Text(
                                          '15:00',
                                        ),
                                      ],
                                    ),
                                  ]),
                                  Column(children: <Widget>[
                                    Row(children: <Widget>[
                                      IconButton(
                                        onPressed: null,
                                        icon: Icon(Icons.edit),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.delete))
                                    ]),
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
              ),
              MyCustomForm(),
              // TextField(
              //   decoration: new InputDecoration(
              //       labelText: 'Set reminder timing',
              //       labelStyle: TextStyle(
              //         color: Colors.teal.shade800,
              //         fontSize: 20,
              //       )),
              // ),
              SizedBox(height: 30),
              // SizedBox(
              //   width: 150,
              //   height: 50,
              //   child: RaisedButton(
              //     child: Text('Add Schedule',
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold,
              //         )),
              //     onPressed: null,
              //     disabledColor: Colors.pink[100],
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(25.0),
              //       side: BorderSide(color: Colors.pink[100]),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
  // @override

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
  String dropdownValue = 'mL';
  TimeOfDay _time = TimeOfDay.now();

  String dosage;
  String medicineName;
  String type;

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
          SizedBox(height: 10),
          Text(
            'Add Schedule',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 10),
          Text(
            'Select type of medication',
            style: TextStyle(color: Colors.green[900]),
            textAlign: TextAlign.left,
          ),
          CustomRadio(text1: 'Pills', text2: 'Syringe'),
          TextFormField(
            // The validator receives the text that the user has entered.
            decoration: new InputDecoration(
                labelText: "Enter name of medication",
                labelStyle: TextStyle(
                  color: Colors.teal.shade800,
                  fontSize: 20,
                )),
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
          Container(
            child: Row(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    // The validator receives the text that the user has entered.

                    decoration: new InputDecoration(
                        labelText: "Enter dosage",
                        labelStyle: TextStyle(
                          color: Colors.green[900],
                          fontSize: 20,
                        )),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
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
                    elevation: 16,
                    style: TextStyle(color: Colors.teal.shade800),
                    underline: Container(
                      height: 2,
                      color: Colors.green[900],
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['mL', 'Pills', 'g']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
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
          SizedBox(
            width: 500,
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
                    ])),
          ),
          SizedBox(
            width: 500,
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
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
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
                      _formKey.currentState.save();

                      String type = CustomRadio.toggle ? "Pills" : "Syringe";
                      DateTime now = new DateTime.now();

                      ReminderMgr.addMedicationReminder(
                          medicineName,
                          dosage,
                          type,
                          DateTime(now.year, now.month, now.day, _time.hour,
                              _time.minute));

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
                                  Text('Medication reminder is set',
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
                  child: Text("Add Schedule", style: TextStyle(fontSize: 20)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
