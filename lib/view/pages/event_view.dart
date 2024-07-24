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
          body: Column(
        children: [
          Text('Past Events'),
          Consumer<Controller>(builder: (context, controller, child) {
            return FutureBuilder(
                future: controller.pastTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final data = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: data!.isEmpty
                        ? const Center(
                            child: Text('No Events'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(10),
                              color: ConstColor.lightGrey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].title),
                                  Text(data[index].dueDate.toString())
                                ],
                              ),
                            ),
                          ),
                  );
                });
          }),
          Text('Upcoming Events'),
          Consumer<Controller>(builder: (context, controller, child) {
            return FutureBuilder(
                future: controller.upcomingTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final data = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: data!.isEmpty
                        ? const Center(
                            child: Text('No Events'),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: const EdgeInsets.all(10),
                              color: ConstColor.lightGrey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].title),
                                  Text(data[index].dueDate.toString())
                                ],
                              ),
                            ),
                          ),
                  );
                });
          }),
        ],
      )),
    );
  }
}
