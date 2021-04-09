import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/model/Recipes.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'NavigationBar.dart';

import 'AppBar.dart';
import 'Drawer.dart';
import 'Library.dart';

//void main() => runApp(ExercisePage());

class MealLogPage extends StatelessWidget {
  static final routeName = "/mealLog";

  @override
  Widget build(BuildContext context) {
    return MealLogPageState();
  }
}

class MealLogPageState extends StatefulWidget {
  @override
  MealLogForm createState() => MealLogForm();
}

class MealLogForm extends State<MealLogPageState> {
  final _formKey = GlobalKey<FormState>();
  DateTime currentDate = DateTime.now().toLocal();
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String _foodItem = "";
  num _servings;
  num _calories = 0;
  num _carbs = 10;
  final _calcontroller = TextEditingController();
  final _namecontrolller = TextEditingController();
  final _servingscontroller = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  TimeOfDay _time = TimeOfDay.now();

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
    var slider = SleekCircularSlider(
        min: 0,
        max: 200,
        initialValue: double.parse(_carbs.toString()),
        appearance: CircularSliderAppearance(
          counterClockwise: false,
          startAngle: 90,
          angleRange: 360,
          infoProperties: InfoProperties(
              topLabelText: "Carbs (g)",
              modifier: (double percentage) {
                return percentage.ceil().toInt().toString();
              }),
        ),
        onChange: (double value) {
          _carbs = value.toInt();
        });
    double progressValue = 153;

    Widget _buildDateTime() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.45,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Theme.of(context).shadowColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatter.format(currentDate)),
                    IconButton(
                        icon: Icon(Icons.calendar_today_sharp),
                        onPressed: () => _selectDate(context))
                  ])),
          Container(
              padding: EdgeInsets.only(left: 10),
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Theme.of(context).shadowColor),
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${_time.format(context)}"),
                    IconButton(
                        icon: Icon(Icons.alarm_add_rounded),
                        onPressed: () => _selectTime(context))
                  ]))
        ],
      );
    }

    return Form(
      key: _formKey,
      child: Scaffold(
          endDrawer: CustomDrawer(),
          appBar: CommonAppBar(title: "Log Meal"),
          bottomNavigationBar: NavigationBar(),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Container(
                            width: 150,
                            height: 150,
                            child: slider,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("What did you have?",
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(height: 5),
                        Container(
                            child: TextFormField(
                                controller: _namecontrolller,
                                //initialValue: _foodItem,
                                // The validator receives the text that the user has entered.
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    suffixIcon: new IconButton(
                                        icon: const Icon(Icons.search),
                                        onPressed: () async {
                                          Recipe recipe = await Navigator.push(
                                            context,
                                            // Create the SelectionScreen in the next step.
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    (MainFetchData())),
                                          );
                                          setState(() {
                                            _calories = recipe.cal;
                                            _foodItem = recipe.title;
                                            _servings = recipe.serving;
                                            _carbs = recipe.carbs;
                                          });
                                          _calcontroller.text =
                                              recipe.cal.toString();
                                          _namecontrolller.text = recipe.title;
                                          _servingscontroller.text =
                                              recipe.serving.toString();

                                          print(recipe.carbs);
                                          print(_calories);
                                        }),
                                    border: OutlineInputBorder(),
                                    //labelText: "kcals",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  this._foodItem = value;
                                  return null;
                                })),
                        SizedBox(height: 10),
                        Text("Calorie intake",
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(height: 5),
                        Container(
                            child: TextFormField(
                                // The validator receives the text that the user has entered.
                                //initialValue: _calories.toString(),
                                controller: _calcontroller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: "kcals",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  _calories = double.parse(value).toInt();
                                  return null;
                                })),
                        SizedBox(height: 10),
                        Text("Serving size",
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(height: 5),
                        Container(
                            child: TextFormField(
                                controller: _servingscontroller,
                                keyboardType: TextInputType.number,
                                // The validator receives the text that the user has entered.
                                //initalValue: (_calories != null)?_calories.toString(): "",
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(),
                                    labelText: "Servings",
                                    labelStyle: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 20,
                                    )),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  this._servings = double.parse(value);
                                  return null;
                                })),
                        SizedBox(height: 10),
                        Text("Date and time",
                            style: Theme.of(context).textTheme.headline4),
                        SizedBox(height: 5),
                        _buildDateTime(),
                        SizedBox(height: 20),
                        Center(
                            child: SizedBox(
                                width: 240,
                                height: 50,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return null;
                                    }
                                    print(currentDate);
                                    print(_time);
                                    print(this._foodItem);
                                    print(this._servings);
                                    print(_calories);

                                    // Need to get form for Carbs
                                    print('Hello');
                                    _carbs = _carbs.toInt();
                                    LogBookMgr.addFoodRecord(currentDate, _foodItem, _carbs, _calories, _servings);

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
                                                Text('Meal Logged',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black)),
                                                Text('Keep eating healthy!',
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black)),
                                                SizedBox(height: 20),
                                                TextButton(
                                                  child: Text('OK',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color: Colors.black)),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
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

                                  },
                                  icon: Icon(
                                    Icons.sticky_note_2_outlined,
                                    size: 22,
                                  ),
                                  label: Text("Log Meal Entry",
                                      style:
                                          Theme.of(context).textTheme.button),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                              side: BorderSide(
                                                  color:
                                                      Colors.pink.shade100))),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Theme.of(context).primaryColor)),
                                ))),
                      ])))),
    );
  }
}
