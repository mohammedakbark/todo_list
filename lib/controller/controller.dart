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

  clearController() {
    titleController.clear();
    dateController.clear();
    pageIndex = 1;
    notifyListeners();
  }

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
    return File('$path/events.json');
  }

  Future<List<EventModel>> _readTasks() async {
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

  Future<File> _writeTasks(List<EventModel> events) async {
    final file = await _localFile;
    String jsonString = jsonEncode(events.map((e) => e.toJson()).toList());
    log(jsonString);
    return file.writeAsString(jsonString);
  }

  //----------------------------------------------

  List<EventModel> _events = [];

  _getAllEvets() async {
    _events = [];

    _events = await _readTasks();
  }

  addEvent(EventModel model) async {
    await _getAllEvets();
    _events.add(model);
    await _writeTasks(_events);
  }

  Future<List<EventModel>> upcomingTasks() async {
    await _getAllEvets();
    DateTime now = DateTime.now();
    return _events
        .where((task) => DateTime.parse(task.dueDate).isAfter(now))
        .toList();
  }

  Future<List<EventModel>> pastTasks() async {
    await _getAllEvets();
    DateTime now = DateTime.now();
    return _events
        .where((task) => DateTime.parse(task.dueDate).isBefore(now))
        .toList();
  }
}
