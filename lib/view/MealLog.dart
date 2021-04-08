import 'package:flutter/material.dart';
import 'package:flutterapp/model/Recipes.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
          counterClockwise: true,
          startAngle: 0,
          angleRange: 360,
          infoProperties: InfoProperties(
              topLabelText: "Carbs",
              modifier: (double percentage){
                return percentage.ceil().toInt().toString();
              }
          ),
        ),
        onChange: (double value) {
          _carbs = value.toInt();
        });
    double progressValue = 153;
    return Form(
      key: _formKey,
      child: Scaffold(
        endDrawer: CustomDrawer(),
        appBar: CommonAppBar(title:"Meal Log"),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                        width: 200,
                        height: 200,
                        child: slider
                    ),

                    Container(

                        child: Row(
                            children: [Padding(
                                padding: EdgeInsets.only(top: 0, left: 10),
                                child:Text(
                                  'What did you have ?',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal.shade800),
                                )
                            )
                            ]
                        )
                    ),

                    Container(
                        margin:
                        EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                        child: TextFormField(
                            controller: _namecontrolller,
                            //initialValue: _foodItem,
                            // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                                suffixIcon: new IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () async{
                                      Recipe recipe = await Navigator.push(context,
                                        // Create the SelectionScreen in the next step.
                                        MaterialPageRoute(builder: (context) => (MainFetchData())),
                                      );
                                      setState(() {
                                        _calories = recipe.cal;
                                        _foodItem = recipe.title;
                                        _servings = recipe.serving;
                                        _carbs = recipe.carbs;
                                      });
                                      _calcontroller.text = recipe.cal.toString();
                                      _namecontrolller.text = recipe.title;
                                      _servingscontroller.text = recipe.serving.toString();

                                      print(recipe.carbs);
                                      print(_calories);
                                    }
                                ),
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
                    Container(

                        child: Row(
                            children: [Padding(
                                padding: EdgeInsets.only(top: 0, left: 10),
                                child:Text(
                                  'Calorie intake',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal.shade800),
                                )
                            )
                            ]
                        )
                    ),

                    Container(
                        margin:
                        EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                        child: TextFormField(
                          // The validator receives the text that the user has entered.
                          //initialValue: _calories.toString(),
                            controller: _calcontroller,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "kcals",
                                labelStyle: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 20,
                                )
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              _calories = int.parse(value);
                              return null;
                            })),
                    Container(

                        child: Row(
                            children: [Padding(
                                padding: EdgeInsets.only(top: 0, left: 10),
                                child:Text(
                                  'Serving Size',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.teal.shade800),
                                )
                            )
                            ]
                        )
                    ),

                    Container(
                        margin:
                        EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
                        child: TextFormField(
                            controller: _servingscontroller,
                            keyboardType: TextInputType.number,
                            // The validator receives the text that the user has entered.
                            //initalValue: (_calories != null)?_calories.toString(): "",
                            decoration: InputDecoration(
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

                    Container(
                        child: Row(
                          children: [Padding(
                              padding: EdgeInsets.only(top: 0, left: 10),
                              child: Text(
                                'Date & Time',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.teal.shade800),
                              )
                          ),
                          ],
                        )
                    ),
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            padding: EdgeInsets.only(left: 5, bottom: 10, top: 10),
                            width: MediaQuery.of(context).size.width * 0.40,
                            height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatter.format(currentDate),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  IconButton(
                                      icon: Icon(Icons.calendar_today_sharp,size: 20),
                                      onPressed: () => _selectDate(context))
                                ])),
                        Container(
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
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  IconButton(
                                      icon: Icon(Icons.alarm_add_rounded),
                                      onPressed: () => _selectTime(context))
                                ]))
                      ],
                    ),

                    SizedBox(
                        width: 200,
                        height:40,
                        child: ElevatedButton.icon(
                          onPressed: (){
                            if (!_formKey.currentState.validate()){
                              return;
                            }
                            print(currentDate);
                            print(_time);
                            print(this._foodItem);
                            print(this._servings);
                            print(_calories);

                            // Need to get form for Carbs

                            //LogBookMgr.addFoodRecord(currentDate, _foodItem, 20, _calories, _servings);
                          },


                          icon: Icon(
                            Icons.sticky_note_2_outlined,
                            size: 22,
                          ),
                          label: Text("Log Meal",
                              style: Theme.of(context).textTheme.headline3),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.pink.shade100)
                                  )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.pink.shade100)),
                        ))
                  ])))),
    );
  }
}