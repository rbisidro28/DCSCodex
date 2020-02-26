import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:table_calendar/table_calendar.dart';
import './main_drawer.dart';

class HomePage extends StatefulWidget {
	 static String tag = 'home-page';
  @override
  _HomePageState createState() =>_HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;
  Map<DateTime,List<dynamic>> _events;
  TextEditingController _eventController;

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
  }

  Map<String,dynamic> encodeMap(Map<String,dynamic> map) {
    Map<String,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map) {
    Map<DateTime,dynamic> newMap = {};
    map.forEach((key,value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('DCS Codex Calendar'),
        backgroundColor: Color(0xff800000),
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              calendarStyle: CalendarStyle(
                todayColor: Color(0xff02e36f),
                selectedColor: Color(0xff015d2d),
              ),
              onDaySelected: (date, events) {
                print(date.toIso8601String());
              },
              calendarController: _controller,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ),
        actions: <Widget>[
          FlatButton( 
            child: Text("Save"),
            onPressed: (){
              if(_eventController.text.isEmpty) return;
              setState(() {
                if(_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add(_eventController.text);
                }else{
                  _events[_controller.selectedDay] = [_eventController.text];
                }
              });
            },
          )
        ],
      )
    );
  }

}