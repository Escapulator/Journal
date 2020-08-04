import 'package:flutter/material.dart';
import 'package:journal/Screens/ViewNote.dart';
import 'package:journal/Service/Journal_Service.dart';
import 'package:journal/Model/Journal.dart';
import 'package:journal/main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  JournalService journalService;

  List<Journal> _journalist = List<Journal>();

  @override
  initState() {
    super.initState();
    getjournal();
  }

  getjournal() async {
    journalService = JournalService();
    _journalist = List<Journal>();

    var joruna = await journalService.readJournal();

    joruna.forEach((journals) {
      setState(() {
        var model = Journal();
        model.id = journals['id'];
        model.title = journals['title'];
        model.body = journals['body'];
        model.rating = journals['rating'];
        model.date = journals['date'];
        _journalist.add(model);
      });
    });
  }
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    //final post = Provider.of<List<Journal>>(context);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: new DrawNav(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('AddNote');
        },
      ),
      appBar: AppBar(
        title: Text('Journal Entries'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings),
          onPressed: (){_scaffoldKey.currentState.openEndDrawer();},)
        ],
        
      ),
      body: (_journalist.length > 0) ?
      ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              _journalist[index].title ?? 'No title',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(_journalist[index].body, maxLines: 3,),
            onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewNote(
                                journal: _journalist[index],
                              )));
                    },
            trailing: Text(_journalist[index].date.toString()),
          );
        },
        itemCount: _journalist.length,
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 2,
          thickness: 2,
        ),
      ) :
      Center(child: Icon(Icons.note, size: 90),)
    );
  }
}
