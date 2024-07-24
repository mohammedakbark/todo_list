import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/model/event_model.dart';
import 'package:todo_app/utils/const_colors.dart';
import 'package:todo_app/utils/helper.dart';

class AddEvent extends StatelessWidget {
  AddEvent({super.key});

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context, listen: false);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Scaffold(
          body: Column(
            children: [
              customeTextField('Title', controller.titleController),
              const SizedBox(
                height: 20,
              ),
              Consumer<Controller>(builder: (context, _controller, _) {
                return customeTextField('Date', _controller.dateController,
                    sufixWidget: IconButton(
                        onPressed: () async {
                          await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2050))
                              .then((value) => _controller.getDate(value!));
                        },
                        icon: const Icon(Icons.calendar_month)));
              }),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: Helper.w(context) * .4,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          backgroundColor: ConstColor.black),
                      onPressed: () async {
                        if (controller.dateController.text.isNotEmpty &&
                            controller.titleController.text.isNotEmpty) {
                          EventModel model = EventModel(
                              dueDate: controller.dateController.text,
                              isDone: false,
                              title: controller.titleController.text);
                          List<EventModel> list = await controller.readTasks();
                          list.add(model);
                          await controller.writeTasks(list);
                        } else {
                          log('-------enter the value-----');
                        }
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.add,
                            color: ConstColor.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Add',
                            style: TextStyle(
                              color: ConstColor.white,
                            ),
                          )
                        ],
                      )),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget customeTextField(String hintText, TextEditingController controller,
      {Widget? sufixWidget}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: ConstColor.lightGrey,
          suffixIcon: sufixWidget,
          hintText: hintText),
    );
  }
}
