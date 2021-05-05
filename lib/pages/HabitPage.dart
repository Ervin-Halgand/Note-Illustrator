import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';

class HabitPage extends StatefulWidget {
  @override
  _HabitPageState createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarWidget(),
      // body: Center(child: NotesPage()));
      body: Center(
        child: Text('Habit Page'),
      ),
    );
  }
}
