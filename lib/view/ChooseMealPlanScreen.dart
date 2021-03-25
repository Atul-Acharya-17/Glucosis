import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChooseMealPlan(),
    ),
  );
}

enum SingingCharacter { lafayette, jefferson }

/// UI screen for choosing meal plan from recommendations.
class ChooseMealPlan extends StatefulWidget {
  @override
  _ChooseMealPlanState createState() => _ChooseMealPlanState();
}

class _ChooseMealPlanState extends State<ChooseMealPlan> {
  @override
  String _plan = 'None';
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose Meal Plan'),
          centerTitle: true,
          backgroundColor: Colors.teal.shade800,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: null),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    _plan = 'Selected Plan 1';
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      Text('Plan 1'),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text('9:00 - Eggs'),
                      Text('13:00 - Apples'),
                      Text('19:00 - Bananas'),
                    ]),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _plan = 'Selected Plan 2';
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(children: <Widget>[
                      Text('Plan 2'),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text('9:00 - Eggs'),
                      Text('13:00 - Apples'),
                      Text('19:00 - Bananas'),
                    ]),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _plan = 'Selected Plan 3';
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Column(children: <Widget>[
                      Text('Plan 3'),
                      Divider(
                        height: 20,
                        thickness: 2,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Text('9:00 - Eggs'),
                      Text('13:00 - Apples'),
                      Text('19:00 - Bananas'),
                    ]),
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
              ),
              SizedBox(height: 30),
              Text(
                _plan,
                style: TextStyle(
                  color: Colors.teal.shade400,
                  fontSize: 40,
                ),
              ),
              SizedBox(height: 50),
              ElevatedButton(
                  child: Text(
                    'Confirm',
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.lightGreen;
                        return Colors
                            .lightGreen; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _plan = 'Confirmed Plan';
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
