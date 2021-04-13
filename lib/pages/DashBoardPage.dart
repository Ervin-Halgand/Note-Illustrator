import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBarWidget(),
        body: Center(child: Text('Dashboard Page')));
  }
}
