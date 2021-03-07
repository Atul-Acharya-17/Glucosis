import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    sampleData.add(new RadioModel(false, 'Pills', ''));
    sampleData.add(new RadioModel(false, 'Syringe', ''));
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      // appBar: new AppBar(
      //   title: new Text("ListItem"),
      // ),
      height: MediaQuery.of(context).size.height * 0.12,
      child: new ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: Colors.pink[200],
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
              });
            },

            child: Column(
              children: <Widget>[
                new SizedBox(width: 30),
                new RadioItem(sampleData[index]),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 50.0,
            width: 150.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Colors.pink : Colors.pink[200],
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Colors.pink : Colors.pink[200]),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}
