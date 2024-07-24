import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/model/event_model.dart';

class Controller with ChangeNotifier {
  int pageIndex = 0;

  void changeIndex(selctedIndex) {
    pageIndex = selctedIndex;
    notifyListeners();
  }

  final titleController = TextEditingController();
  final dateController = TextEditingController();

  getDate(DateTime dateTime) {
    dateController.text = dateTime.toString();
    notifyListeners();
  }
//--------------------------------------------------

  Future<File> writeData(EventModel eventModel) async {
    final event = EventModel.fromjson(eventModel.toJson());
    String json = jsonEncode(event);
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/${'note1'}.txt');
    print('//Done//');
    return file.writeAsString(json);
  }

  Future<String> readData() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/note1.txt');
      String text = await file.readAsString();

      print(text);
      return text;
    } catch (e) {
      return 'Error: $e';
    }
  }
}
