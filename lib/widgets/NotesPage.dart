import 'package:flutter/material.dart';

final List<String> noteDescription = [];
final List<String> noteHeading = [];
final List<String> noteDate = [];
TextEditingController noteHeadingController = new TextEditingController();
TextEditingController noteDescriptionController = new TextEditingController();
FocusNode textSecondFocusNode = new FocusNode();

int notesHeaderMaxLenth = 2500;
int notesDescriptionMaxLines = 1000;
// int notesDescriptionMaxLenth;
String deletedNoteHeading = "";
String deletedNoteDescription = "";

List<Color> noteColor = [
  Color(0xffe5d4a7),
  Color(0xffa7e5de),
  Color(0xfface5a7),
  Color(0xffa7bce5),
  Color(0xffe6afa6),
  Color(0xff9683ec),
  Color(0xfff88e55),
  Color(0xff7ce220),
  Color(0xffc72c48),
  Color(0xff0086f3),
];

List<Color> noteMarginColor = [
  Color(0xffe5d4a7),
  Color(0xffa7e5de),
  Color(0xfface5a7),
  Color(0xffa7bce5),
  Colors.indigo[300],
  Color(0xffe5d4a7),
  Colors.yellow[300],
  Colors.brown[300],
  Colors.teal[300],
  Colors.purple[300],
];
