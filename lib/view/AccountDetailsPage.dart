import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import '../controller/UserMgr.dart';

/*
return MaterialApp(
      title: 'Flutter App',
      home: AccountDetailsScreen(),
      theme: ThemeData(
        // Define the default brightness and colors.
        backgroundColor: Colors.teal.shade800,
        accentColor: Color.fromRGBO(248, 139, 160, 1),
        primaryColor: Color.fromRGBO(248, 181, 188, 1),
        primaryColorLight: Color.fromRGBO(253, 225, 228, 1),

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
*/
void main() {
  runApp(
      MaterialApp(
        title: 'Diabetes App',
        home: AccountDetailsPage(),
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

/// UI screen for entering account details when creating account.
class AccountDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountDetailsScreen(),
    );
  }
}

class AccountDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountDetailsScreenState();
  }
}

class AccountDetailsScreenState extends State<AccountDetailsScreen> {
  String _gender;
  String _location;
  double _weight;
  double _height;
  String _type;
  RangeValues _targetRange = const RangeValues(90, 160);

  DateTime dateOfBirth = DateTime.now().toLocal();
  DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: dateOfBirth,
        firstDate: DateTime(1900),
        lastDate: DateTime(2022));
    if (pickedDate != null && pickedDate != dateOfBirth)
      setState(() {
        dateOfBirth = pickedDate;
      });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildDOB() {
    return Container(
      padding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      //width: MediaQuery.of(context).size.width * 0.40,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.circular(3.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formatter.format(dateOfBirth),
              style: TextStyle(fontSize: 16, color: Colors.black)),
          IconButton(
              icon: Icon(Icons.calendar_today_sharp),
              onPressed: () => _selectDate(context)),
        ],
      ),
    );
  }

  Widget _buildRange() {
    return RangeSlider(
      values: _targetRange,
      min: 70,
      max: 180,
      divisions: 110,
      activeColor: Theme.of(context).accentColor,
      inactiveColor: Theme.of(context).primaryColorLight,
      labels: RangeLabels(
        _targetRange.start.round().toString(),
        _targetRange.end.round().toString(),
      ),
      onChanged: (RangeValues values) {
        setState(() {
          _targetRange = values;
        });
      },
    );
  }

  Widget _buildGender() {
    return CustomRadioButton(
      elevation: 0,
      absoluteZeroSpacing: false,
      unSelectedColor: Theme.of(context).primaryColorLight,
      buttonLables: [
        'female',
        'male',
        'Other',
      ],
      buttonValues: [
        "female",
        "male",
        "other",
      ],
      buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          textStyle: TextStyle(fontSize: 16)),
      radioButtonValue: (value) {
        _gender = value;
      },
      selectedColor: Theme.of(context).accentColor,
    );
  }

  Widget _buildType() {
    return CustomRadioButton(
      elevation: 0,
      absoluteZeroSpacing: false,
      unSelectedColor: Theme.of(context).primaryColorLight,
      buttonLables: [
        'Type 1',
        'Type 2',
        'Prediabetes',
      ],
      buttonValues: [
        "type1",
        "type2",
        "prediabetes",
      ],
      buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          textStyle: TextStyle(fontSize: 16)),
      radioButtonValue: (value) {
        _type = value;
      },
      selectedColor: Theme.of(context).accentColor,
    );
  }

  Widget _buildLocation() {
    return TextFormField(
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Country",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Country is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _location = value;
      },
    );
  }

  Widget _buildWeight() {
    return TextFormField(
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "000.00",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Weight is Required';
        }
        return null;
      },
      onSaved: (String value) {
        print("Receiving string");
        _weight = double.parse(value);
        print("Converted to double");
      },
    );
  }

  Widget _buildHeight() {
    return TextFormField(
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "0.00",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Height is Required';
        }
        return null;
      },
      onSaved: (String value) {
        print("Receiving string");
        _height = double.parse(value);
        print("Converted to double");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,

        backgroundColor: Theme.of(context).backgroundColor,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Theme.of(context).backgroundColor,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Align(
                    child: Text(
                        "Welcome! Tell us a little more about yourself.",
                        style: TextStyle(
                            fontSize: 28,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Gender",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                _buildGender(),
                const SizedBox(height: 10),
                Text(
                  "Date of birth",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                _buildDOB(),
                const SizedBox(height: 10),
                Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                _buildLocation(),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: _buildWeight(),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "kg",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Height",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.30,
                                child: _buildHeight(),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "m",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                const SizedBox(height: 10),
                Text(
                  "Diabetes Type",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 5),
                _buildType(),
                const SizedBox(height: 10),
                Text(
                  "Target Range",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                _buildRange(),
                SizedBox(height: 10),
                Center(
                  child: Align(
                    child: ElevatedButton(
                        child: Text("Create account",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          primary: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          print("Yes");
                          _formKey.currentState.save();
                          print("No");
                          /*
                        Update details of current user in the UserMgr class.
                        Use AuthMgr getCurrentUser to do the updates

                        Currently only NAVIGATION is implemented
                        */
                          UserManager.updateOnSignup(dateOfBirth, _gender, _location, _weight, _height, _type, _targetRange.start, _targetRange.end);
                          Map<String,dynamic> details=UserManager.getProfileDetails();
                          print(details);
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                              '/home', ModalRoute.withName('/'));
                        }),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
