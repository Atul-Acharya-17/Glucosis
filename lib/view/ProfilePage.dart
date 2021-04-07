import 'package:flutter/material.dart';
import 'package:flutterapp/controller/AuthenticationMgr.dart';
import 'NavigationBar.dart';
import 'AppBar.dart';
import '../controller/UserMgr.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Diabetes App',
      home: ProfilePage(),
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

/// UI screen for changing password.
class PasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PasswordScreen();
  }
}

class PasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PasswordScreenState();
  }
}

class PasswordScreenState extends State<PasswordScreen> {
  String _password;
  String _passwordn1;
  String _passwordn2;

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, color: Theme.of(context).backgroundColor),
    );
  }

  Widget _buildPassword(String varValue, String hintText) {
    return TextFormField(
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }
        return null;
      },
      onSaved: (String value) {
        varValue = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Change Password',
      ),
      bottomNavigationBar: NavigationBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 10),
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildText("Enter old password:"),
            _buildPassword(_password, "Old password"),
            const SizedBox(height: 5),
            _buildText("Enter new password:"),
            _buildPassword(_passwordn1, "New password"),
            const SizedBox(height: 5),
            _buildText("Re-enter new password:"),
            _buildPassword(_passwordn2, "New password"),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                  child: Text("Change password",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    primary: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/profile');
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

/// UI screen for viewing and editing user's details.
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen();
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  //integration for password and target range needs to be done
  Map<String, dynamic> profileDetails = UserManager.getProfileDetails();
  String _name;
  String _gender = UserManager.getProfileDetails()['gender'];
  double _weight;
  double _height;
  String _type = UserManager.getProfileDetails()['diabetesType'];
  RangeValues _targetRange = RangeValues(
      UserManager.getProfileDetails()['minGlucose'],
      UserManager.getProfileDetails()['maxGlucose']);
  String _location;
  String _exercisePreference =
      (UserManager.getProfileDetails()['exercisePreference']);
  String _phoneNumber = "65659393";
  String _email = "hello@gmail.com";
  DateTime dateOfBirth =
      (UserManager.getProfileDetails()['dateOfBirth']).toLocal();

  DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    //DateTime dateOfBirth = UserManager.getProfileDetails()['dateOfBirth'];
    print('Date' + dateOfBirth.toString());
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

  Widget _buildHeader(String header) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(right: 20.0),
                child: Divider(
                  color: Colors.black,
                  height: 0,
                )),
          ),
          Text(header),
          Expanded(
            child: new Container(
              margin: const EdgeInsets.only(left: 20.0),
              child: Divider(
                color: Colors.black,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

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

  Widget _buildEmail() {
    _email = profileDetails['email'];
    return TextFormField(
      initialValue: _email,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Email address",
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
        if (!RegExp(
                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildName() {
    _name = profileDetails['name'];
    return TextFormField(
      initialValue: _name,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Name",
        filled: true,
        fillColor: Colors.white,
      ),
      //maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildPhoneNumber() {
    _phoneNumber = profileDetails['phoneNumber'];
    return TextFormField(
      initialValue: _phoneNumber,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Phone number",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
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

  Widget _buildLocation() {
    _location = profileDetails['location'];
    return TextFormField(
      initialValue: _location,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
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

  Widget _buildExercisePreference() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Radio(
            value: 'Basic',
            groupValue: _exercisePreference,
            onChanged: (String value) {
              setState(() {
                _exercisePreference = value;
              });
            },
          ),
        ),
        Text(
          'Basic',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(width: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Radio(
            value: 'Intermediate',
            groupValue: _exercisePreference,
            onChanged: (String value) {
              setState(() {
                _exercisePreference = value;
              });
            },
          ),
        ),
        Text(
          'Intermediate',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(width: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Radio(
            value: 'Advanced',
            groupValue: _exercisePreference,
            onChanged: (String value) {
              setState(() {
                _exercisePreference = value;
              });
            },
          ),
        ),
        Text(
          'Advanced',
          style: TextStyle(color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildWeight() {
    _weight = profileDetails['weight'];
    return TextFormField(
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "0.00",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      initialValue: _weight.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Weight is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _weight = double.parse(value);
      },
    );
  }

  Widget _buildHeight() {
    _height = profileDetails['height'];
    return TextFormField(
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
            new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "0.00",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      initialValue: _height.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Height is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _height = double.parse(value);
      },
    );
  }

  Widget _buildGender() {
    return Container(
        height: 30,
        width: double.infinity,
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
    decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    border: Border.all(
    color: Colors.grey,
    width: 1,
    ),
    ),
    child: DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      value: _gender,
      elevation: 0,
      style: TextStyle(
          color: Colors.black
      ),
      onChanged: (String newValue) {
        setState(() {
          _gender = newValue;
        });
      },
      items: <String>['female', 'Male', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      })
          .toList(),
    ),
    ),
    );
  }

  Widget _buildType() {
    return Container(
      height: 30,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _type,
          elevation: 0,
          style: TextStyle(
              color: Colors.black
          ),
          onChanged: (String newValue) {
            setState(() {
              _type = newValue;
            });
          },
          items: <String>['type1', 'type2', 'Prediabetes']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'My Profile',
      ),
      bottomNavigationBar: NavigationBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          color: Theme.of(context).canvasColor,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 5),
                _buildHeader("Account details"),
                Text(
                  "Email address",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildEmail(),
                TextButton(
                  child: Text("Change password",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).primaryColor)),
                  onPressed: () {
                    AuthenticationManager.changePassword();
                    //Navigator.of(context).pushNamed('/password');
                  },
                ),
                // Divider(
                //   color: Colors.black,
                //   height: 10,
                // ),

                _buildHeader("Personal details"),
                const SizedBox(height: 5),
                Text(
                  "Name",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildName(),
                const SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                child: _buildGender(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          Text(
                            "Weight",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                child: _buildWeight(),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "kg",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          Text(
                            "Height",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.24,
                                child: _buildHeight(),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "m",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                const SizedBox(height: 5),
                Text(
                  "Date of birth",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                const SizedBox(height: 5),
                Container(
                  child: _buildDOB(),
                  height: 40,
                ),
                const SizedBox(height: 5),
                Text(
                  "Diabetes Type",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildType(),
                const SizedBox(height: 5),
                Text(
                  "Target Blood Glucose",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                Container(
                  height: 30,
                  child: _buildRange(),
                ),
                const SizedBox(height: 5),
                Text(
                  "Exercise preference",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                Container(
                  height: 30,
                  child: _buildExercisePreference(),
                ),
                const SizedBox(height: 5),
                Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildLocation(),
                const SizedBox(height: 5),
                Text(
                  "Phone number",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildPhoneNumber(),
                const SizedBox(height: 15),
                Center(
                  child: Align(
                    child: ElevatedButton(
                        child: Text("Save changes",
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
                          _formKey.currentState.save();
                          print(_targetRange.start);
                          print(_targetRange.end);
                          UserManager.updateProfilePage(
                              dateOfBirth,
                              _gender,
                              _location,
                              _weight,
                              _height,
                              _type,
                              _targetRange.start,
                              _targetRange.end,
                              _name,
                              _phoneNumber);
                          //need to add dob and target range to profile page screen
                          //usermgr.addUser(_email, _dob, _type, _dietRestrictions.split(','), _exercisePreference,_foodPreference, _gender, _height, _location, _name, _phoneNumber, _calories, _weight, _targetRange);
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
