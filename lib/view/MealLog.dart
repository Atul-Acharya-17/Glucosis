import 'package:flutter/material.dart';
import 'package:flutterapp/controller/LogBookMgr.dart';
import 'package:flutterapp/view/AppBar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';


void main() => runApp(MaterialApp(
  title: 'Diabetes App',
  home: MealLogPage(),
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
  ),),);

/// UI screen for logging meal entries.
class MealLogPage extends StatelessWidget {
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
  String _foodItem;
  double _servings;
  int _calories;

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
    double progressValue = 153;
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: CommonAppBar(title:"Meal Log"),
          body: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(children: [
                    Container(
                        width: 200,
                        height: 200,
                        child: SfRadialGauge(axes: <RadialAxis>[
                          RadialAxis(
                              minimum: 0,
                              maximum: 100,
                              showLabels: false,
                              showTicks: false,
                              startAngle: 270,
                              endAngle: 270,
                              axisLineStyle: AxisLineStyle(
                                thickness: 0.2,
                                cornerStyle: CornerStyle.bothFlat,
                                color: Colors.pink.shade100,
                                thicknessUnit: GaugeSizeUnit.factor,
                              ),
                              pointers: <GaugePointer>[
                                RangePointer(
                                    value: (progressValue/250 *100),
                                    cornerStyle: CornerStyle.bothFlat,
                                    width: 0.2,
                                    sizeUnit: GaugeSizeUnit.factor,
                                    color: Colors.pink.shade300)
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                    positionFactor: 0.7,
                                    angle: 90,
                                    widget: Container(
                                        padding: EdgeInsets.only(left: 20, right: 20),
                                        child: Column(
                                            children: [
                                              Text(
                                                (progressValue).toStringAsFixed(0),
                                                style: TextStyle(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'Carbs',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )       ]//children array
                                        )
                                    )
                                )
                              ])
                        ])),

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
                          // The validator receives the text that the user has entered.
                            decoration: InputDecoration(
                                suffixIcon: new IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: (){
                                      Navigator.of(context).pushNamed('/library');
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
                            keyboardType: TextInputType.number,
                          // The validator receives the text that the user has entered.
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatter.format(currentDate),
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black)),
                                  IconButton(
                                      icon: Icon(Icons.calendar_today_sharp),
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

                            LogBookMgr.addFoodRecord(currentDate, _foodItem, 20, _calories, _servings);
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
