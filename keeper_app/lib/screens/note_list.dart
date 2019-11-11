import 'package:flutter/material.dart';
import 'package:keeper_app/screens/NoteDetail.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteList();
  }
}

class _NoteList extends State<NoteList> {
  var count = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
        ),
        body: getNoteListView(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            createNote("Add Note");
          },
          tooltip: 'Create a new note',
          child: Icon(Icons.add),
        ));
  }

  ListView getNoteListView(BuildContext buildContext) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    ListView.builder(
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            trailing: Icon(Icons.delete, color: Colors.grey),
            title: Text("title"
                ""),
            subtitle: Text("sub title"),
            onTap: () {
              createNote("Edit Note");
            },
          ),
        );
      },
      itemCount: count,
    ).build(buildContext);
  }

  void createNote(String screenTitle) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(screenTitle);
    }));
  }
}
