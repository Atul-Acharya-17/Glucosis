import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  CustomRadio({@required this.text1, this.text2});
  final String text1;
  final String text2;
  static bool toggle;
  @override
  createState() {
    return new CustomRadioState(text1, text2);
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = new List<RadioModel>();

  CustomRadioState(String text1, String text2) {
    sampleData.add(new RadioModel(false, text1, ''));
    sampleData.add(new RadioModel(false, text2, ''));
  }

  // @override
  // void initState(text1,text2) {
  //   // ignore: todo
  //   // TODO: implement initState
  //   super.initState();
  //   sampleData.add(new RadioModel(false, text1, ''));
  //   sampleData.add(new RadioModel(false, text2, ''));
  // }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      child: new ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: sampleData.length,
        itemBuilder: (BuildContext context, int index) {
          return new InkWell(
            //highlightColor: Colors.red,
            splashColor: Theme.of(context).primaryColor,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
                if(index == 0)
                  CustomRadio.toggle = true;
                else
                  CustomRadio.toggle = false;
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
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height * 0.05,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Theme.of(context).accentColor : Theme.of(context).primaryColor,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Theme.of(context).accentColor : Theme.of(context).primaryColor),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
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
