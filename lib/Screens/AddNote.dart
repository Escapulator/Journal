import 'package:flutter/material.dart';
import 'package:journal/Model/Journal.dart';
import 'package:journal/Service/Journal_Service.dart';
import 'package:journal/main.dart';
import 'package:intl/intl.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _formkey = GlobalKey<FormState>();
  String ori;
  String body;
  String rating;
  DateTime dates = DateTime.now();
  String time = DateFormat.yMMMMEEEEd().format(DateTime.now());
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return Scaffold(key: _scaffoldKey,
      endDrawer: new DrawNav(),
        appBar: AppBar(
          title: Text('New Journal Entry'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings),
          onPressed: (){_scaffoldKey.currentState.openEndDrawer();},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: (Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        ori = value;
                      });
                    },
                    validator: (val) => ori.isEmpty ? 'enter Title' : null,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Body',
                      enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        body = value;
                      });
                    },
                    validator: (val) => body.isEmpty ? 'enter Body' : null,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: InputDecoration(
                      labelText: 'Rating',
                      enabledBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                      focusedBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.blue)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        rating = value;
                      });
                    },
                    validator: (val) => rating.isEmpty ? 'enter rating' : null,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).popAndPushNamed('Home');
                        },
                      ),
                      RaisedButton(
                        child: Text('Save'),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            var journalObject = Journal();

                            journalObject.title = ori;
                            journalObject.body = body;
                            journalObject.rating = rating;
                            journalObject.date = time;

                            var journalService = JournalService();
                            var result =
                                await journalService.saveJournal(journalObject);

                            print(result);
                            Navigator.of(context).pushNamed('Home');
                          }
                        },
                      )
                    ],
                  )
                ],
              )),
            ),
          ),
        ));
  }
}
