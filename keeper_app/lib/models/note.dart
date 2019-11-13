import 'package:keeper_app/utils/databse_helper.dart';

class Note {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._description]);

  Note.withId(this._id, this._title, this._date, this._priority,
      [this._description]);

  int get id => _id;

  int get priority => _priority;

  String get date => _date;

  String get description => _description;

  String get title => _title;

  set priority(int value) {
    if (value == 1 || value == 2 || value == 3) {
      this._priority = value;
    }
  }

  set date(String value) {
    _date = value;
  }

  set description(String value) {
    if (value.length <= 255) {
      this._description = value;
    }
  }

  set title(String value) {
    if (value.length <= 255) {
      this._title = value;
    }
  }

  //convert to map

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id == null) {
      map[DataBaseHelper.colId] = _id;
    }
    map[DataBaseHelper.colTitle] = _title;
    map[DataBaseHelper.colDescription] = _description;
    map[DataBaseHelper.colDate] = _date;
    map[DataBaseHelper.colPriority] = _priority;
    return map;
  }

  Note.fromMapToObject(Map<String, dynamic> map) {

    this._id = map[DataBaseHelper.colId];
    this._title = map[DataBaseHelper.colTitle];
    this._description = map[DataBaseHelper.colDescription];
    this._date = map[DataBaseHelper.colDate];
    this._priority = map[DataBaseHelper.colPriority];
  }

  //priority text
  String getPriorityText() {
    switch (_priority) {
      case 1:
        return "High";
      case 2:
        return "Medium";
      case 3:
        return "Low";
    }
  }

  //priority int
  void updatePriorityInt(String priority) {
    switch (priority) {
      case "High":
        _priority = 1;
        break;

      case "Medium":
        _priority = 2;
        break;
      case "Low":
        _priority = 3;
        break;
    }
  }
}
