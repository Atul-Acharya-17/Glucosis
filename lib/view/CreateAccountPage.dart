import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import '../controller/AuthenticationMgr.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

/*
return MaterialApp(
      title: 'Flutter App',
      home: CreateAccountScreen(),
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
        home: CreateAccountPage(),
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

/// UI screen for creating a new account.
class CreateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CreateAccountScreen());
  }
}

class CreateAccountScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountScreenState();
  }
}

class CreateAccountScreenState extends State<CreateAccountScreen> {
  String _email;
  String _password;
  String _password2;
  String _name;
  String _phoneNumber;
  bool showSpinner = false;

  //final _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
      obscureText: true,
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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

  Widget _buildPassword2() {
    return TextFormField(
      obscureText: true,
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        border: OutlineInputBorder(),
        hintText: "Password",
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.visiblePassword,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password re-entry is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _password2 = value;
      },
    );
  }

  Widget _buildName() {
    return TextFormField(
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
      decoration: new InputDecoration(
        contentPadding:
            new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
//                const SizedBox(height: 10),
                  Center(
                    child: Align(
                      child: Text("Start your journey\nwith Glucosis.",
                          style: TextStyle(
                              fontSize: 30,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Enter your email address",
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  _buildEmail(),
                  const SizedBox(height: 10),
                  Text(
                    "Enter your password",
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  _buildPassword(),
                  SizedBox(height: 10),
                  Text(
                    "Re-enter password",
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  _buildPassword2(),
                  SizedBox(height: 10),
                  Text(
                    "Name",
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  _buildName(),
                  SizedBox(height: 10),
                  Text(
                    "Phone number",
                    style: TextStyle(
                        fontSize: 16, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 10),
                  _buildPhoneNumber(),

                  SizedBox(height: 30),
                  Center(
                    child: Align(
                      child: ElevatedButton(
                          child: Text("Continue",
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
                          onPressed: () async {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            AuthenticationManager auth =
                                new AuthenticationManager();
                            bool success = false;
                            if (_password == _password2){
                              setState(() {
                                showSpinner = true;
                              });
                              success = await auth.signUp(_email, _password);
                            }

                            else {
                              print('Passwords are different');
                              setState(() {
                                showSpinner = false;
                              });
                            }

                            if (success) {
                                UserManager.addUseronSignup(_email, _name, _phoneNumber);
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.of(context).pushNamed('/accdetails');
                            }
                            else{
                              setState(() {
                                showSpinner = false;
                              });
                            }
                            //print(_email);
                            //print(_password);
                            //print(_password2);
                            //print(_name);
                            //print(_phoneNumber);
                          }),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
