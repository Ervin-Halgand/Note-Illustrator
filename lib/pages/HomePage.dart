import 'package:flutter/material.dart';
import 'package:note_illustrator/routes/router.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("First page")),
        body: Center(
            child: FloatingActionButton(
          child: Text('Next'),
          onPressed: () => Navigator.pushNamed(context, routesDashBoardPage),
        )));
  }
}
