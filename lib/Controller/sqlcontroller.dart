import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Sqlcontroller extends GetxController {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await copyasset();
    return _db;
  }

  copyasset() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "raj.db");
    bool dbExists = await File(path).exists();

    if (!dbExists) {
      // Copy from asset
      print("start");
      ByteData data = await rootBundle.load("assets/sqlappuse.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
      // print('file create done');
    }

    var theDb = await databaseFactory.openDatabase(path);
    return theDb;
  }
}
