import 'package:flutter/material.dart';
import 'package:journal/Model/Journal.dart';
import 'package:journal/main.dart';

class ViewNote extends StatefulWidget {
  final Journal journal;

  ViewNote({this.journal});
  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {  
  String title;
  String body;
  String date;

  @override
  void initState() {
    title = widget.journal.title;
    body = widget.journal.body;
    date = widget.journal.date.toString();
    super.initState();
  }
  
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      endDrawer: new DrawNav(),
      appBar: AppBar(title: Text(date.toString()),
      centerTitle: true,
      actions: <Widget>[
        IconButton(icon: Icon(Icons.settings),
          onPressed: (){_scaffoldKey.currentState.openEndDrawer();},)
      ],),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Flexible(
            flex: 10,
            child: SingleChildScrollView(
              child: Text(
                body,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ),
          )
        ],
      ),
    );
  }
}