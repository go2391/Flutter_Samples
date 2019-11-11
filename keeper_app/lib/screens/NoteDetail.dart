import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  String screenTitle;

  NoteDetails(this.screenTitle);

  @override
  State<StatefulWidget> createState() {
    return _NoteDetails(screenTitle);
  }
}

class _NoteDetails extends State<NoteDetails> {
  double minPadding = 5;

  var _formKey = GlobalKey<FormState>();

  TextEditingController titleControler = TextEditingController();
  TextEditingController contentControler = TextEditingController();

  var _priority = ["High", "Medium", "Low"];

  String _currentSelected = "High";

  String screenTitle;

  _NoteDetails(this.screenTitle);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
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
                          this._currentSelected = newValue ?? "";
                        });
                      },
                      value: _currentSelected,
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
                        }
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
                        }
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
                                  "Calculate",
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
                                  "Reset",
                                  textScaleFactor: 1.2,
                                ),
                                onPressed: deleteNote))
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  void saveNote() {}

  void deleteNote() {}

  void moveToLastScreen() {
    Navigator.pop(context);
  }
}
