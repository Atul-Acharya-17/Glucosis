import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/controller/ReminderMgr.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import '../controller/AuthenticationMgr.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() {
  runApp(
      MaterialApp(
        title: 'Diabetes App',
        home: LoginPage(),
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
        ),)  );
}

/// UI screen for logging into an existing account.
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //title: 'Flutter App',
        body: LoginScreen(),

    );
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
  bool showSpinner = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
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
      obscureText: true,
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            color: Theme.of(context).backgroundColor,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 30),
                  Center(
                    child: Align(
                      child: Image.asset('images/Glucosis.png',
                          width: 120, height: 120),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Align(
                      child: Text(
                          "Managing your health shouldn't be hard, even with diabetes.",
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
                  SizedBox(height: 30),
                  Center(
                    child: Align(
                      child: ElevatedButton(
                          child: Text("Sign in",
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
                            setState(() {
                              showSpinner = true;
                            });
                            _formKey.currentState.save();

                            AuthenticationManager auth =
                                new AuthenticationManager();
                            await auth.login(_email, _password).then((loginSuccess) async => {
                                  if(loginSuccess)
                                  {
                                    await UserManager.retrieveDetails(_email).then((value) async =>
                                    {
                                      UserManager.setData().then((value) => {
                            setState(() {
                            showSpinner =  false;
                            }),
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            '/home', ModalRoute.withName('/'))
                                      })
                                    })
                                  }
                              else{
                                loginError()
                                }
                                });

                            //print(_email);
                            //print(_password);
                          }),
                    ),
                  ),
                  Center(
                    child: Align(
                      child: TextButton(
                        child: Text("Create an account",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginError (){

    setState(() {
      showSpinner = false;
    });

    return showDialog<void>(
      context: context,
      barrierDismissible:
      false, // user must tap button!
      builder: (BuildContext context) {
        // can add logic to store entry here
        return AlertDialog(
          //title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Invalid Credentials',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),

                SizedBox(height: 20),
                TextButton(
                  child: Text('Cancel',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all<
                          Color>(
                          Colors.red[500])),
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
}
