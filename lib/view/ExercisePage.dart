import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutterapp/controller/ExercisePlanMgr.dart';
import 'package:flutterapp/controller/UserMgr.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'Drawer.dart';
import 'NavigationBar.dart';
import './AppBar.dart';

void main() => runApp(
      MaterialApp(
        title: 'Diabetes App',
        home: ExercisePage(),
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
        ),
      ),
    );

/// UI for main exercise page.
class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExercisePageState();
  }
}

class ExercisePageState extends StatelessWidget {
  Future<List<Widget>> buildExercises(context) async {
    List<Widget> exercises = new List<Widget>();

    String option = UserManager.getProfileDetails()['exercisePreference'];

    var exercise = await ExercisePlanMgr.choosePlan(option);

    print(exercise);

    for (int i = 0; i < exercise['objects'].length; ++i) {
      Widget plan = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
            child: Text(exercise['objects'][i]['day'],
                style: Theme.of(context).textTheme.headline4),
            margin: EdgeInsets.only(left: 15, right: 15, top: 3)),
        // probably should group each text and card as an object
        Container(
            color: Theme.of(context).primaryColorLight,
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(exercise['objects'][i]['name'],
                      style: Theme.of(context).textTheme.headline3),
                  Text(
                      exercise['objects'][i]['duration'].toString() +
                          " minutes",
                      style: Theme.of(context).textTheme.headline3)
                ])),
            SizedBox(height: 10),
      ]);

      exercises.add(plan);
    }
    return exercises;
  }

  @override
  Widget build(BuildContext context) {
    double progressValue = 75;
    return FutureBuilder<List<Widget>>(
        future: buildExercises(context),
        builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
          Widget child;

          if (snapshot.hasData) {
            child = Scaffold(
              endDrawer: CustomDrawer(),
              bottomNavigationBar: NavigationBar(),
              appBar: CommonAppBar(
                title: 'Exercise',
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                              width: 150,
                              height: 150,
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
                                      color: Theme.of(context).primaryColorLight,
                                      thicknessUnit: GaugeSizeUnit.factor,
                                    ),
                                    pointers: <GaugePointer>[
                                      RangePointer(
                                          value: progressValue,
                                          cornerStyle: CornerStyle.bothFlat,
                                          width: 0.2,
                                          sizeUnit: GaugeSizeUnit.factor,
                                          color: Theme.of(context).accentColor)
                                    ],
                                    annotations: <GaugeAnnotation>[
                                      GaugeAnnotation(
                                        positionFactor: 0.15,
                                        angle: 90,
                                        widget: Text(
                                            ((progressValue * 60) / 100)
                                                    .toStringAsFixed(0) +
                                                '/60\n   Min',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline1),
                                      )
                                    ])
                              ])),
                        ),
                        SizedBox(height: 5),
                        Center(
                            child: Text('Good Job!',
                                style: Theme.of(context).textTheme.headline5)),
                        Container(
                            child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text('Recommended exercise plan',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline1))),
                        Card(
                            elevation: 5,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: snapshot.data)),
                        Card(
                            elevation: 5,
                            margin: EdgeInsets.only(top: 10),
                            child: Container(
                                height: 75,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 0, left: 10, right: 10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Exercise Preference',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                      Container(
                                        height: 40,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Basic",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline3),
                                              TextButton(
                                                  child: Text("Edit Preference",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4),
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pushNamed('/profile');
                                                  })
                                            ]),
                                      ),
                                    ]))),
                        SizedBox(height:20),
                        Center(
                          child: ElevatedButton(
                              child: Text("Log Exercise Entry",
                                  style: Theme.of(context).textTheme.button),
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15),
                                primary: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed("/logexercise");
                              }),
                        ),
                      ]),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            child = Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                )
              ],
            );
          } else {
            child = Column(children: [
              SizedBox(
                child: CircularProgressIndicator(),
                width: 60,
                height: 60,
              ),
            ]);
          }

          return child;
        });
  }
}
