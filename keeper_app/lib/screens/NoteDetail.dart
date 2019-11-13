import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keeper_app/models/note.dart';
import 'package:keeper_app/utils/databse_helper.dart';
import 'package:sqflite/sqflite.dart';

class NoteDetails extends StatefulWidget {
  final String screenTitle;
  final Note _note;

  NoteDetails(this._note, this.screenTitle);

  @override
  State<StatefulWidget> createState() {
    return _NoteDetails(_note, screenTitle);
  }
}

class _NoteDetails extends State<NoteDetails> {
  DataBaseHelper dataBaseHelper = DataBaseHelper();
  double minPadding = 5;

  var _formKey = GlobalKey<FormState>();

  TextEditingController titleControler = TextEditingController();
  TextEditingController contentControler = TextEditingController();

  var _priority = ["High", "Medium", "Low"];

  String screenTitle;

  Note _note;

  _NoteDetails(this._note, this.screenTitle) {}

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleControler.text = _note.title;
    contentControler.text = _note.description;

    return WillPopScope(
      onWillPop: () {
        //control things when user want to move back from the current screen like backpressed
        moveToLastScreen();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              }),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(minPadding * 5),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: DropdownButton<String>(
                      items: _priority.map((String text) {
                        return DropdownMenuItem<String>(
                          value: text,
                          child: Text(text),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          _note.updatePriorityInt(newValue);
                        });
                      },
                      style: textStyle,
                      value: _note.getPriorityText(),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: minPadding, bottom: minPadding),
                    child: TextFormField(
                      controller: titleControler,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter title';
                        } else
                          return "";
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 13,
                          ),
                          labelStyle: textStyle,
                          labelText: "Title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      style: textStyle,
                      onChanged: (String input) {
                        _note.title = titleControler.text;
                      },

                      /*onSubmitted: (String userInput) {
                        setState(() {
                          principleAmount = userInput;
                        });
                      },*/
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: minPadding * 5, bottom: minPadding),
                    child: TextFormField(
                      controller: contentControler,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter description';
                        } else
                          return "";
                      },
                      decoration: InputDecoration(
                          errorStyle: TextStyle(
                            fontSize: 13,
                          ),
                          labelStyle: textStyle,
                          labelText: "Content",
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5))),
                      style: textStyle,
                      onChanged: (String input) {
                        _note.description = contentControler.text;
                      },
                      /*onSubmitted: (String userInput) {
                        setState(() {
                          principleAmount = userInput;
                        });
                      },*/
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: minPadding * 15, bottom: minPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  "Save",
                                  textScaleFactor: 1.2,
                                ),
                                onPressed: saveNote)),
                        Container(
                          width: 10,
                          child: null,
                        ),
                        Expanded(
                            child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                textColor: Theme.of(context).primaryColorLight,
                                child: Text(
                                  "Delete",
                                  textScaleFactor: 1.2,
                                ),
                                onPressed: delete))
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void saveNote() async {
    moveToLastScreen();

    debugPrint("saveNote");
//    _note.title = titleControler.text;
//    _note.description = contentControler.text;
    _note.date = DateFormat.yMMMMd().format(DateTime.now());
    debugPrint('database ${_note.title} ${_note.description} ${_note.date} ${_note.priority}');
    int result;
    if (_note.id == null) {
      result = await dataBaseHelper.insertNote(_note);
    } else {
      result = await dataBaseHelper.updateNote(_note);
    }

    if (result != 0) {
      _showAlertDialog("Save", "Saved Successfully");
    } else {
      _showAlertDialog("Save", "Save Failed.");
    }
  }

  void delete() async {
    moveToLastScreen();
    if (_note.id == null) {
      _showAlertDialog("Delete", "No note deleted.");
      return;
    } else {
      var result = await dataBaseHelper.deleteNote(_note);
      if (result != 0) {
        _showAlertDialog("Delete", "Deleted Successfully");
      } else {
        _showAlertDialog("Delete", "Delete Failed.");
      }
    }

    /*setState(() {
      _currentSelected = '';
    });*/
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
