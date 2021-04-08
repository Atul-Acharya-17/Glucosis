import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp/model/GlucoseRecord.dart';
import 'package:flutterapp/model/GlucoseReminders.dart';
import 'package:flutterapp/model/Reminder.dart';
// import 'package:flutter/services.dart';
import 'package:flutterapp/view/NavigationBar.dart';
// import 'package:flutterapp/view/CustomRadioButton.dart';
import './AppBar.dart';
import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import 'package:intl/intl.dart';
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

// Widget fetch() {
//   List remindersList = UserManager.getGlucoseReminders();
//   for (int i; i <= remindersList.length; i++) {
//     return (Text(remindersList[i].timings));
//   }
// }

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

  get reminderList => UserManager.getGlucoseReminders();

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

  Future<List<Widget>> buildReminders() async {
    print('Factory!!!!!!!!1');
    DateFormat dateFormat = DateFormat("HH:mm");
    List<Widget> reminderWidgets = new List<Widget>();

    Map<String, Reminder> reminders = await ReminderMgr.getRemindersWithKey('Glucose');
    print(reminders.length);
    var keys = reminders.keys.toList();

    for (int i = 0; i < reminders.length; ++i) {
        Widget rem = SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
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
                Text(formatter.format((reminders[keys[i]] as GlucoseReminder).timings),
                    style:
                    TextStyle(fontSize: 20, color: Colors.black)),
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await ReminderMgr.deleteReminder('Glucose', keys[i]);
                      setState(() {

                      });
                    })
              ],
            ),
          ),
        );

        reminderWidgets.add(rem);
    }
    return reminderWidgets;
  }

  final DateFormat formatter = DateFormat('hh:mm a');
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return FutureBuilder<List<Widget>>(
        future: buildReminders(
    ),
    builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
    Widget child;

    if (snapshot.hasData) {
      child = Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,
              left: MediaQuery
                  .of(context)
                  .size
                  .width * 0.04),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 700,
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Existing Reminders',
                          style: TextStyle(
                              fontSize: 20, color: Colors.teal.shade800),
                        ))),
              ),
                Column(
                  children: snapshot.data,
                ),
              SizedBox(
                width: 700,
                child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(top: 20, left: 10),
                        child: Text(
                          'Add Reminder',
                          style: TextStyle(
                              fontSize: 20, color: Colors.teal.shade800),
                        ))),
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.8,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10, top: 10),
                      padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.40,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]),
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${_time.format(context)}",
                              style:
                              TextStyle(fontSize: 20, color: Colors.black)),
                          IconButton(
                              icon: Icon(Icons.alarm_add_rounded),
                              onPressed: () => _selectTime(context))
                        ],
                      ),
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.delete),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              // Padding(
              //   padding: EdgeInsets.only(
              //       left: MediaQuery.of(context).size.width * 0.05),
              //   child: SizedBox(
              //     width: 400,
              //     child: Text(
              //       '+ Add reminder',
              //       style: TextStyle(
              //         fontSize: 15,
              //         color: Colors.teal.shade800,
              //       ),
              // ),
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  child: Text("Create schedule",
                      style: Theme
                          .of(context)
                          .textTheme
                          .button),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    primary: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  onPressed: () async {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      DateTime now = new DateTime.now();



                      Map<String, dynamic> data = {};
                      data['timings'] =  DateTime(now.year, now.month,
                          now.day, _time.hour, _time.minute);

                      await ReminderMgr.addReminder(
                        'Glucose', data);
                      setState(() {});

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
                ),
              ),
            ],
          ),
        ),
      );
    }else if (snapshot.hasError) {
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
      child = Column(
          children:[
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
    }
    );

  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutterapp/model/GlucoseRecord.dart';
// import 'package:flutterapp/model/GlucoseReminders.dart';

// // import 'package:flutter/services.dart';
// import 'package:flutterapp/view/NavigationBar.dart';

// // import 'package:flutterapp/view/CustomRadioButton.dart';
// import './AppBar.dart';
// import 'package:flutterapp/controller/ReminderMgr.dart';
// import 'package:flutterapp/controller/UserMgr.dart';
// import 'package:intl/intl.dart';
// import 'Drawer.dart';

// void main() => runApp(
//       MaterialApp(
//         title: 'Diabetes App',
//         home: DailySchedule(),
//         theme: ThemeData(
//           // Define the default brightness and colors.
//           primaryColor: Colors.teal.shade800,
//           backgroundColor: Colors.pink.shade100,

//           // Define the default font family.
//           fontFamily: 'Roboto',

//           // Define the default TextTheme. Use this to specify the default
//           // text styling for headlines, titles, bodies of text, and more.
//           textTheme: TextTheme(
//               headline3: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black),
//               headline4: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.teal.shade800),
//               headline5: TextStyle(fontSize: 40, color: Colors.teal.shade800),
//               headline6: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black)),
//         ),
//       ),
//     );

// /// UI component for setting daily blood glucose reading reminders.
// class DailySchedule extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(title: 'Daily Schedule'),
//       body: DailyScheduleBody(),
//       bottomNavigationBar: NavigationBar(),
//       endDrawer: CustomDrawer(),
//       backgroundColor: Theme.of(context).canvasColor,
//     );
//   }
// }

// class DailyScheduleBar extends StatelessWidget implements PreferredSizeWidget {
//   final Color green = Color.fromRGBO(0, 110, 96, 1);
//   final Color pink = Color.fromRGBO(254, 179, 189, 1);
//   final DateFormat formatter = DateFormat('hh:mm a');
//   @override
//   Size get preferredSize => const Size.fromHeight(50);

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;
//     final double appBarTextSize = height * 0.035;
//     final double appBarIconSize = width * 0.07;

//     return AppBar(
//       backgroundColor: green,
//       leading: GestureDetector(
//         onTap: () {},
//         child: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             size: appBarIconSize,
//             color: pink,
//           ),
//           onPressed: () {},
//         ),
//       ),
//       title: Center(
//         child: Text(
//           'Create Daily Schedule',
//           style: TextStyle(
//             fontSize: 20,
//             color: Color.fromRGBO(254, 179, 189, 1),
//           ),
//         ),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: new Image.asset('images/user_icon.jpeg'),
//           iconSize: appBarIconSize,
//           padding: EdgeInsets.only(right: 18.0),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }

// // Widget fetch() {
// //   List remindersList = UserManager.getGlucoseReminders();
// //   for (int i; i <= remindersList.length; i++) {
// //     return (Text(remindersList[i].timings));
// //   }
// // }

// class DailyScheduleBody extends StatefulWidget {
//   @override
//   createState() {
//     return new DailyScheduleBodyState();
//   }
// }

// class DailyScheduleBodyState extends State<DailyScheduleBody> {
//   final double borderRadius = 10;
//   final double margin = 5;
//   final double padding = 5;
//   final double iconSize = 56;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(child: MyCustomForm());
//     throw UnimplementedError();
//   }
// }

// class MyCustomForm extends StatefulWidget {
//   @override
//   MyCustomFormState createState() {
//     return MyCustomFormState();
//   }
// }

// // Define a corresponding State class.
// // This class holds data related to the form.
// class MyCustomFormState extends State<MyCustomForm> {
//   // Create a global key that uniquely identifies the Form widget
//   // and allows validation of the form.
//   //
//   // Note: This is a `GlobalKey<FormState>`,
//   // not a GlobalKey<MyCustomFormState>.
//   final _formKey = GlobalKey<FormState>();
//   TimeOfDay _time = TimeOfDay.now();

//   get reminderList => UserManager.getGlucoseReminders();

//   get formatter => DateFormat('hh:mm a');

//   void _selectTime(BuildContext context) async {
//     final TimeOfDay newTime = await showTimePicker(
//       context: context,
//       initialTime: _time,
//     );
//     if (newTime != null) {
//       setState(() {
//         _time = newTime;
//       });
//     }
//   }

// /////////////////////////////
//   ///

//   Future<List<Widget>> buildReminders() async {
//     DateFormat dateFormat = DateFormat("HH:mm a");
//     List<Widget> reminderWidgets = new List<Widget>();

//     var reminders = await ReminderMgr.getGlucoseRemindersWithKey();
//     var keys = reminders.keys.toList();
//     Container(
//       child: Text(
//         'Existing Reminders',
//         style: TextStyle(fontSize: 20, color: Colors.teal.shade800),
//       ),
//     );
//     for (int i = 0; i < reminders.length; ++i) {
//       Widget rem = Container(
//         // color: Colors.pink.shade100,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Card(
//                     elevation: 5,
//                     child: Text(
//                       dateFormat.format(reminders[keys[i]].timings),
//                     ),
//                   ),
//                 ],
//               ),
//             ]),
//             Column(children: <Widget>[
//               Row(children: <Widget>[
//                 IconButton(
//                   onPressed: null,
//                   icon: Icon(Icons.edit),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       ReminderMgr.deleteGlucReminder(keys[i]);
//                       setState(() {});
//                     },
//                     icon: Icon(Icons.delete))
//               ])
//             ]),
//           ],
//         ),
//       );
//       reminderWidgets.add(rem);
//     }
//     if (reminderWidgets.length == 0) {
//       reminderWidgets.add(SizedBox(
//         height: MediaQuery.of(context).size.height * 0.05,
//       ));
//     }
//     return reminderWidgets;
//     // Get List of Medication Reminders
//     // Make sure you retrieve the index of reminders also
//     // In the onPressed of the button, delete the index from the database
//     // and call setState
//   }

// //////////////////  /////////////
//   ///
//   @override
//
// }

// //     return Form(
// //       key: _formKey,
// //       child: Container(
// //         padding: EdgeInsets.all(20),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: <Widget>[
// //             SizedBox(
// //               width: 700,
// //               child: Container(
// //                   child: Padding(
// //                       padding: EdgeInsets.only(top: 20, left: 20),
// //                       child: Text(
// //                         'Existing Reminders',
// //                         style: TextStyle(
// //                             fontSize: 20, color: Colors.teal.shade800),
// //                       ))),
// //             ),
// //             SizedBox(
// //               width: 700,
// //               child: Container(
// //                   child: Padding(
// //                       padding: EdgeInsets.only(top: 20, left: 10),
// //                       child: Text(
// //                         'Add Reminder',
// //                         style: TextStyle(
// //                             fontSize: 20, color: Colors.teal.shade800),
// //                       ))),
// //             ),
// //             Row(
// //               children: [
// //                 SizedBox(width: 30),
// //                 SizedBox(
// //                   width: MediaQuery.of(context).size.width * 0.8,
// //                   child: Card(
// //                     elevation: 5,
// //                     child: Container(
// //                       margin: EdgeInsets.only(bottom: 10, top: 10),
// //                       padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
// //                       width: MediaQuery.of(context).size.width * 0.40,
// //                       height: 60,
// //                       decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(5.0)),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text("${_time.format(context)}",
// //                               style:
// //                                   TextStyle(fontSize: 20, color: Colors.black)),
// //                           IconButton(
// //                               icon: Icon(Icons.alarm_add_rounded),
// //                               onPressed: () => _selectTime(context))
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //             SizedBox(
// //               height: MediaQuery.of(context).size.height * 0.05,
// //             ),
// //             Center(
// //               child: ElevatedButton(
// //                 child: Text("Create schedule",
// //                     style: Theme.of(context).textTheme.button),
// //                 style: ElevatedButton.styleFrom(
// //                   shape: new RoundedRectangleBorder(
// //                     borderRadius: new BorderRadius.circular(30.0),
// //                   ),
// //                   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
// //                   primary: Theme.of(context).primaryColor,
// //                 ),
// //                 onPressed: () {
// //                   // Validate returns true if the form is valid, otherwise false.
// //                   if (_formKey.currentState.validate()) {
// //                     // If the form is valid, display a snackbar. In the real world,
// //                     // you'd often call a server or save the information in a database.

// //                     DateTime now = new DateTime.now();

// //                     ReminderMgr.addGlucoseReminder(DateTime(now.year, now.month,
// //                         now.day, _time.hour, _time.minute));
// //                     setState(() {});

// //                     return showDialog<void>(
// //                       context: context,
// //                       barrierDismissible: false, // user must tap button!
// //                       builder: (BuildContext context) {
// //                         // can add logic to store entry here
// //                         return AlertDialog(
// //                           //title: Text('AlertDialog Title'),
// //                           content: SingleChildScrollView(
// //                             child: ListBody(
// //                               children: <Widget>[
// //                                 Text('Glucose reminder is set',
// //                                     style: TextStyle(
// //                                         fontSize: 30,
// //                                         fontWeight: FontWeight.bold,
// //                                         color: Colors.black)),
// //                                 SizedBox(height: 20),
// //                                 TextButton(
// //                                   child: Text('OK',
// //                                       style: TextStyle(
// //                                           fontSize: 20,
// //                                           fontWeight: FontWeight.bold,
// //                                           color: Colors.black)),
// //                                   style: ButtonStyle(
// //                                       backgroundColor:
// //                                           MaterialStateProperty.all<Color>(
// //                                               Colors.green[500])),
// //                                   onPressed: () {
// //                                     Navigator.of(context).pop();
// //                                   },
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   }
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }