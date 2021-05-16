import 'package:flutter/material.dart';
import 'package:note_illustrator/constants/appConstant.dart';
import 'package:note_illustrator/pages/NoteEdit.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/widgets/NoteList.dart';
import 'package:note_illustrator/widgets/NotesPage.dart';
import 'package:note_illustrator/widgets/UserAppBar.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key key}) : super(key: key);
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: noteWidget()),
    );
  }

  Future getNoteDetails() async {
    List<NotesModel> noteList = await DataBase().notes();
    return noteList;
  }

  Widget noteWidget() {
    return FutureBuilder(
      builder: (context, note) {
        if (note.connectionState == ConnectionState.none &&
            note.hasData == null) {
          return Container();
        }
        if (note.data != null && !note.data.isEmpty)
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(note.data.length, (index) {
              return Center(
                child: NoteListWidget(note: note.data[index], index: index),
              );
            }),
          );
        else
          return Center(child: Text("Add Notes..."));
      },
      future: getNoteDetails(),
    );
  }
}
