import 'package:dcscodex/main_drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationsPage extends StatefulWidget {
  static String tag = 'notifications-page';
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  Future<List<Notif>> _getNotifs() async {
    var data =  await http.get("http://www.json-generator.com/api/json/get/bHRZreEfCa?indent=2");
    var jsonData = json.decode(data.body);

    List<Notif> notifs = [];

    for(var u in jsonData){
      Notif notif = Notif(u["index"], u["group"], u["title"], u["info"]);
      notifs.add(notif);
    }

    print(notifs.length);
    return notifs;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Notifications'),
        backgroundColor: Color(0xff800000),
      ),
      drawer: MainDrawer(),
      body: Container(
        child: FutureBuilder(
          future: _getNotifs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {

            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading...")
                )
              );
            } else {
              return ListView.builder(
                padding: EdgeInsets.all(20.0),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    child: ListTile(
                      title: Text(snapshot.data[index].group),
                      subtitle: Text(snapshot.data[index].title),
                      onTap: () {
                        Navigator.push(context,
                          new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );
                      },
                    ),
                    background: Container(
                      color: Colors.green,
                    ),
                    key: ValueKey("dismiss notif"),
                    onDismissed: (direction) {
                      (snapshot.data).removeAt(index);
                      Scaffold.of(context).showSnackBar(new SnackBar(
                        content: new Text("Acknowledged"),
                        ));
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Notif notif;

  DetailPage(this.notif);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(notif.title),
        backgroundColor: Color(0xff800000),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Text(notif.info),
      ),
    );
  }
}

class Notif {
  final int index;
  final String group;
  final String title;
  final String info;

  Notif(this.index, this.group, this.title, this.info);
}