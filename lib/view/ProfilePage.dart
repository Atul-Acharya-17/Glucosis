import 'package:flutter/material.dart';
import 'NavigationBar.dart';
import 'AppBar.dart';

void main() {
  runApp(ProfilePage());
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        home: ProfileScreen(),
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
        ));
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  String _name = "my name";
  String _gender = "female";
  double _weight = 50;
  double _height = 1.50;
  String _type = "Prediabetes";
  RangeValues _targetRange = const RangeValues(90, 160);
  String _foodPreference = "Non-vegetarian";
  int _carbs = 50;
  int _calories = 2000;
  String _location = "Singapore";
  String _dietRestrictions = "Peanuts, ketchup";
  String _exercisePreference = "Basic";
  String _phoneNumber = "65659393";
  String _email = "hello@gmail.com";
  String _password = "********";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
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

  Widget _buildPassword() {
    return TextFormField(
      initialValue: _password,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Password",
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
        _password = value;
      },
    );
  }

  Widget _buildName() {
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

  Widget _buildFoodPreference() {
    return TextFormField(
      initialValue: _foodPreference,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Vegan/vegetarian/non-vegetarian",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Food preference is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _foodPreference = value;
      },
    );
  }

  Widget _buildDietRestrictions() {
    return TextFormField(
      initialValue: _dietRestrictions,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Dietary restrictions",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,

      onSaved: (String value) {
        _dietRestrictions = value;
      },
    );
  }

  Widget _buildExercisePreference() {
    return TextFormField(
      initialValue: _exercisePreference,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Basic/intermediate/advanced",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Exercise preference is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _foodPreference = value;
      },
    );
  }


  Widget _buildGender() {
    return TextFormField(
      initialValue: _gender,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Gender",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Gender is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _gender = value;
      },
    );
  }

  Widget _buildType() {
    return TextFormField(
      initialValue: _type,
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Type",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Type is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _type = value;
      },
    );
  }

  Widget _buildWeight() {
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
        _weight = value as double;
      },
    );
  }

  Widget _buildHeight() {
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
        _height = value as double;
      },
    );
  }

  Widget _buildCarbs() {
    return TextFormField(
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Carbs",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      initialValue: _carbs.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Carbs is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _carbs = value as int;
      },
    );
  }

  Widget _buildCalories() {
    return TextFormField(
      decoration: new InputDecoration(
        isDense: true,
        contentPadding:
        new EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Calories",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
      initialValue: _calories.toString(),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Calories is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _calories = value as int;
      },
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Diabetes Type",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: _buildType(),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Target Blood Glucose",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: _buildRange(),
                          ),
                        ],
                      ),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Food preference",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.32,
                                child: _buildFoodPreference(),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Target carbs",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.21,
                                child: _buildCarbs(),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "g",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Target calories",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.21,
                                child: _buildCalories(),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "kcal",
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
                  "Dietary restrictions",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildDietRestrictions(),
                const SizedBox(height: 5),
                Text(
                  "Exercise preference",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildExercisePreference(),
                const SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: _buildLocation(),
                          ),
                        ],
                      ),
                      const SizedBox(width: 5),
                      Column(
                        children: [
                          Text(
                            "Phone number",
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context).backgroundColor),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: _buildPhoneNumber(),
                          ),
                        ],
                      ),
                    ]),
                const SizedBox(height: 5),
                Text(
                  "Email address",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildEmail(),
                const SizedBox(height: 5),
                Text(
                  "Change password",
                  style: TextStyle(
                      fontSize: 16, color: Theme.of(context).backgroundColor),
                ),
                _buildPassword(),
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
