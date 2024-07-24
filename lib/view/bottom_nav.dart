import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/utils/const_colors.dart';
import 'package:todo_app/view/pages/add_event.dart';
import 'package:todo_app/view/pages/event_view.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  List<Widget> pages = [ AddEvent(), EventView()];
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return Scaffold(
      body: pages[controller.pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: ConstColor.black,
        unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: ConstColor.grey),
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 22, color: ConstColor.black),
        currentIndex: controller.pageIndex,
        onTap: controller.changeIndex,
        items: const [
          BottomNavigationBarItem(
            label: 'Add',
            icon: Text(""),
          ),
          BottomNavigationBarItem(icon: Text(""), label: 'Event')
        ],
      ),
    );
  }
}
