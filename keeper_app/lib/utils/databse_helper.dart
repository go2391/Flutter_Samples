import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:keeper_app/models/note.dart';

class DataBaseHelper {

  static DataBaseHelper _dataBaseHelper;

  factory DataBaseHelper()
  {
    if(_dataBaseHelper == null)
      {
        _dataBaseHelper = DataBaseHelper._createInstance();
      }
//    return__dataBaseHelper;
  }

  static DataBaseHelper _createInstance() {

  }

}
