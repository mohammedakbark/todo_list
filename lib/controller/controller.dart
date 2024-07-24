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

 Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
    Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/event.json');
  }

 Future<List<EventModel>> readTasks() async {
    try {
      final file = await _localFile;
      if (!await file.exists()) {
        return [];
      }
      final contents = await file.readAsString();
      List<dynamic> jsonList = jsonDecode(contents);
      return jsonList.map((json) => EventModel.fromjson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<File> writeTasks(List<EventModel> events) async {
    final file = await _localFile;
    String jsonString = jsonEncode(events.map((task) => task.toJson()).toList());
    return file.writeAsString(jsonString);
  }


















  // Future<File> writeData(EventModel eventModel) async {
  //   String json = jsonEncode(eventModel);
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final File file = File('${directory.path}/note1.txt');
  //   print('//Done//');
  //   return file.writeAsString(json);
  // }

  // Future<String> readData() async {
  //   try {
  //     final Directory directory = await getApplicationDocumentsDirectory();
  //     final File file = File('${directory.path}/note1.txt');
  //     String text = await file.readAsString();

  //     print(text);
  //     return text;
  //   } catch (e) {
  //     return 'Error: $e';
  //   }
  // }


}
