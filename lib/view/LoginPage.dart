import 'package:flutter/material.dart';

void main() {
  runApp(LoginPage());
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter App',
        home: LoginScreen(),
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

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      decoration: new InputDecoration(
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
      decoration: new InputDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back,
      //         color: Colors.transparent,
      //       ),
      //       onPressed: null),
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   shadowColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 5000,
          color: Theme.of(context).backgroundColor,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 40),
                Center(
                  child: Align(
                    child:
                    Image.asset('images/user_icon.jpeg', width: 100, height: 100),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Align(
                      child:
                      Text("Managing your health shouldn't be hard, even with diabetes.",
                          style: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center)
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter your email address",
                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 10),
                _buildEmail(),
                const SizedBox(height: 10),
                Text(
                  "Enter your password",
                  style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                ),
                const SizedBox(height: 10),
                _buildPassword(),
                SizedBox(height: 30),
                Center(
                  child: Align(
                    child: ElevatedButton(
                        child: Text("Sign in", style: TextStyle(fontSize: 20, color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          primary: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();

                          print(_email);
                          print(_password);
                        }),
                  ),
                ),
                Center(
                  child: Align(
                    child: TextButton(
                      child: Text("Create an account",
                          style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor)),
                      onPressed: () {
                        //runApp(CreateAccountPage());
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}