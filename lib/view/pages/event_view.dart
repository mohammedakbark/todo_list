import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/model/event_model.dart';
import 'package:todo_app/utils/const_colors.dart';

class EventView extends StatelessWidget {
  EventView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Consumer<Controller>(builder: (context, controller, child) {
        return FutureBuilder(
            future: controller.readData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // final event = EventModel.fromjson(eventModel.toJson());
              // String json = jsonEncode(event);

              final data = jsonDecode(snapshot.data!);
              final event = EventModel.fromjson(data);
              print(data.toString());

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => Container(
                    padding: EdgeInsets.all(10),
                    color: ConstColor.lightGrey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(event.title), Text(event.dueDate)],
                    ),
                  ),
                ),
              );
            });
      })),
    );
  }
}
