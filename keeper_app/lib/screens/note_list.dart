import 'package:flutter/material.dart';
import 'package:keeper_app/screens/NoteDetail.dart';
import 'package:keeper_app/models/note.dart';
import 'package:keeper_app/utils/databse_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteList();
  }
}

class _NoteList extends State<NoteList> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();

  int count = 0;
  List<Note> _notesList;

  @override
  Widget build(BuildContext context) {
    if (_notesList == null) {
      _notesList = List<Note>();
      _updateNotesList();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Notes"),
        ),
        body: getNoteListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateNote(Note('', '', 3, ''), "Add Note");
          },
          tooltip: 'Create a new note',
          child: Icon(Icons.add),
        ));
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        debugPrint('${this._notesList[position].title} ${this._notesList[position].description} ${this._notesList[position].date} ${this._notesList[position].priority}');
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this._notesList[position].priority),
              child: getPriorityIcon(this._notesList[position].priority),
            ),

            title: Text(this._notesList[position].title ?? "", style: titleStyle,),

            subtitle: Text(this._notesList[position].description ?? ""),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, _notesList[position]);
                _updateNotesList();
              },
            ),


            onTap: () {
              debugPrint("ListTile Tapped");
              navigateNote(this._notesList[position],'Edit Note');
            },

          ),
        );
      },
    );
  }

/*
  ListView getNoteListView(BuildContext buildContext) {
    TextStyle textStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(_notesList[position].priority),
              child: getPriorityIcon(_notesList[position].priority),
            ),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                _delete(context, _notesList[position]);
                _updateNotesList();
              },
            ),
            title: Text(
              _notesList[position].title,
              style: textStyle,
            ),
            subtitle: Text(_notesList[position].description),
            onTap: () {
              navigateNote(_notesList[position], "Edit Note");
            },
          ),
        );
      },
    ).build(buildContext);
  }
*/

  void navigateNote(Note note, String screenTitle) async {
    bool success =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetails(note, screenTitle);
    }));

    if (success) {
      _updateNotesList();
    }
  }

  //priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.yellow;
    }
  }

  //priority color
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
      case 2:
        return Icon(Icons.keyboard_arrow_right);
      case 3:
        return Icon(Icons.skip_next);
    }
  }

  //delete note
  void _delete(BuildContext context, Note note) async {
    var result = await dataBaseHelper.deleteNote(note);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
    }
  }

  // show snack bar message
  void _showSnackBar(BuildContext context, String message) {
    var snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _updateNotesList() {
    final Future<Database> db = dataBaseHelper.initializeDataBase();

    db.then((database) {
      Future<List<Note>> notesListFuture = dataBaseHelper.getNotesList();
      notesListFuture.then((notesList) {
        debugPrint("saveNote ${notesList.length}");
        setState(() {
          this._notesList = notesList;
          this.count = notesList.length;
        });
      });
    });
  }
}
