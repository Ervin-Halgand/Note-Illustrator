import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBarWidget(),
        body: Center(child: Text('Setting Page')));
  }
}
