import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/view/NavigationBar.dart';
import 'package:flutterapp/view/CustomRadioButton.dart';
//import 'package:date_time_picker/date_time_picker.dart';

class MedicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MedicationBar(),
        body: MedicationBody(),
        bottomNavigationBar: NavigationBar(),
      ),
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  ])
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ])),
              MyCustomForm()
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
          CustomRadio(),
          TextFormField(
            // The validator receives the text that the user has entered.
            decoration: new InputDecoration(
                labelText: "Enter name of medication",
                labelStyle: TextStyle(
                  color: Colors.green[900],
                  fontSize: 20,
                )),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
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
                ),
              ),
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.green[900]),
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
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
