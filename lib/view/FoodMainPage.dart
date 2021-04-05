import 'package:flutter/material.dart';
import 'package:flutterapp/view/AppBar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';


void main() => runApp(MaterialApp(
  title: 'Diabetes App',
  home: FoodMainPage(),
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

/// UI for main food page.
class FoodMainPage extends StatelessWidget {
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
  // DateTime currentDate = DateTime.now().toLocal();
  // DateFormat formatter = DateFormat('yyyy-MM-dd');
  //
  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: currentDate,
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2050));
  //   if (pickedDate != null && pickedDate != currentDate)
  //     setState(() {
  //       currentDate = pickedDate;
  //     });
  // }
  //
  // TimeOfDay _time = TimeOfDay.now();
  //
  // void _selectTime(BuildContext context) async {
  //   final TimeOfDay newTime = await showTimePicker(
  //     context: context,
  //     initialTime: _time,
  //   );
  //   if (newTime != null) {
  //     setState(() {
  //       _time = newTime;
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    double progressValue = 153;
    return Scaffold(
        appBar: CommonAppBar(title: "Food Main Page"),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(children: [
                  // Container(
                  //     width: 200,
                  //     height: 200,
                  //     child: SfRadialGauge(axes: <RadialAxis>[
                  //       RadialAxis(
                  //           minimum: 0,
                  //           maximum: 100,
                  //           showLabels: false,
                  //           showTicks: false,
                  //           startAngle: 270,
                  //           endAngle: 270,
                  //           axisLineStyle: AxisLineStyle(
                  //             thickness: 0.2,
                  //             cornerStyle: CornerStyle.bothFlat,
                  //             color: Colors.pink.shade100,
                  //             thicknessUnit: GaugeSizeUnit.factor,
                  //           ),
                  //           pointers: <GaugePointer>[
                  //             RangePointer(
                  //                 value: (progressValue/250 *100),
                  //                 cornerStyle: CornerStyle.bothFlat,
                  //                 width: 0.2,
                  //                 sizeUnit: GaugeSizeUnit.factor,
                  //                 color: Colors.pink.shade300)
                  //           ],
                  //           annotations: <GaugeAnnotation>[
                  //             GaugeAnnotation(
                  //                 positionFactor: 0.7,
                  //                 angle: 90,
                  //                 widget: Container(
                  //                     padding: EdgeInsets.only(left: 20, right: 20),
                  //                     child: Column(
                  //                         children: [
                  //                           Text(
                  //                             (progressValue).toStringAsFixed(0),
                  //                             style: TextStyle(
                  //                               fontSize: 40,
                  //                               fontWeight: FontWeight.bold,
                  //                             ),
                  //                           ),
                  //                           Text(
                  //                             'Carbs',
                  //                             style: TextStyle(
                  //                               fontSize: 20,
                  //                               fontWeight: FontWeight.normal,
                  //                             ),
                  //                           )       ]//children array
                  //                     )
                  //                 )
                  //             )
                  //           ])
                  //     ])),


                  SizedBox(
                      width: 400,
                      height: 300,

                      child: Card(
                          elevation: 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text('Calorie Intake (7 days)',
                                      style:
                                      TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    margin: EdgeInsets.only(
                                        left: 80, right: 0, top: 10)),
                              ]
                          )
                      )
                  ),
                  Container (
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 20),
                      child: SizedBox(
                          width: 200,
                          height:40,
                          child: ElevatedButton.icon(
                            onPressed: (){
                              Navigator.of(context).pushNamed('/mealLog');
                            },

                            icon: Icon(
                              Icons.sticky_note_2_outlined,
                              size: 18,
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
                          ))),
                  Container(
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 20),
                      child: Column(
                          children: [
                            Row(
                              children: [Text("Current Meal Plan",
                                  style: Theme.of(context).textTheme.headline3)],
                            ),
                            Card(
                                elevation: 5,
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    //padding:EdgeInsets.all(15),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('9:00 AM',
                                              style:
                                              Theme.of(context).textTheme.headline4),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Vegetable omelette + fruits side",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3),
                                              ]),
                                        ]))),
                            Card(
                                elevation: 5,
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    //padding:EdgeInsets.all(15),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('2:00 PM',
                                              style:
                                              Theme.of(context).textTheme.headline4),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Basil fried bown rice",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3),
                                              ]),
                                        ]))),
                            Card(
                                elevation: 5,
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    //padding:EdgeInsets.all(15),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('7:00 PM',
                                              style:
                                              Theme.of(context).textTheme.headline4),
                                          Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Chicken White Bean soup",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline3),
                                              ]),
                                        ]))),
                          ]
                      )
                  ),
                  Container (
                      margin: EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: SizedBox(
                          width: 300,
                          height:40,
                          child: ElevatedButton.icon(
                            onPressed: (){
                              Navigator.of(context).pushNamed('/mealPlanChange');
                            },

                            icon: Icon(
                              Icons.edit_outlined,
                              size: 18,
                            ),
                            label: Text("Change Meal Plan",
                                style: Theme.of(context).textTheme.headline3),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.pink.shade100)
                                    )),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.pink.shade100)),
                          ))),
                ]
                )
            )
        )
    );
  }
}
