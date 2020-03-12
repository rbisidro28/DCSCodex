import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

class RequestPage extends StatefulWidget {
  static String tag = 'Request-page';
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2000),
      lastDate: new DateTime(2050)
    );

    if(picked != null && picked != _date){
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime() async {
    final TimeOfDay picked = await showTimePicker(
      context: context, 
      initialTime: _time
    );

    if(picked != null && picked != _time){
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        leading: new Icon(Icons.list),
        title: new Text("New Notification Request"),
        backgroundColor: Color(0xff800000),
      ),
      body: SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(10.0),
          child: new Column(
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(
                  hintText: "Target Recipients",
                  labelText: "Target Recipients",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
              new TextField(
                decoration: new InputDecoration(
                  hintText: "Title",
                  labelText: "Title",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
              new TextField(
                maxLines: 3,
                decoration: new InputDecoration(
                  hintText: "Message",
                  labelText: "Message",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
              new TextField(
                maxLines: 3,
                decoration: new InputDecoration(
                  hintText: "Purpose",
                  labelText: "Purpose",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0)
                  )
                ),
              ),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
              new Row(
                children: <Widget>[
                  new Text('Target: '),
                  new Padding(padding: new EdgeInsets.only(left: 20.0),),
                  new RaisedButton(
                    child: new Text('Date'),
                    onPressed: (){_selectDate();}
                  ),
                  new Padding(padding: new EdgeInsets.only(left: 20.0),),
                  new RaisedButton(
                    child: new Text('Time'),
                    onPressed: (){_selectTime();}
                  ),
                ],
              ),
              new Text('Date selected: ${_date.toString()}'),
              new Text('Time selected: ${_time.toString()}'),
              new Padding(padding: new EdgeInsets.only(top: 20.0),),
              new Row(
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.only(left: 30.0),),
                  new RaisedButton(
                    child: new Text('Submit'),
                    onPressed: null,
                  ),
                  new Padding(padding: new EdgeInsets.only(left: 100.0),),
                  new RaisedButton(
                    child: new Text('Cancel'),
                    onPressed: null,
                  ),
                ],
              ),
              new Padding(padding: new EdgeInsets.only(top: 100.0),),
            ],
          ),
        ),
      ),
    );
  }
}