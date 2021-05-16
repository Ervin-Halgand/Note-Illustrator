import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_illustrator/constants/appConstant.dart';
import 'package:note_illustrator/pages/NoteEdit.dart';
import 'package:note_illustrator/routes/router.dart' as router;
import 'package:image_picker/image_picker.dart';
import 'package:note_illustrator/models/UserInfoModel.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/services/DataBase.dart';

class NoteListWidget extends StatefulWidget {
  NotesModel note;
  int index;
  NoteListWidget({
    this.note,
    this.index,
  });
  @override
  _NoteListWidget createState() => _NoteListWidget();
}

class _NoteListWidget extends State<NoteListWidget> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NoteEditor(
                        note: widget.note,
                        isDeletable: true,
                        titleEditable: true,
                        isHabit: false)),
              );
            },
            child: Container(
                width: 160,
                height: 191,
                decoration: BoxDecoration(
                  color: HexColor(widget.note.color),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Row(children: [
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    child: Text(widget.note.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20.00,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ))),
                                SizedBox(
                                  height: 2.5,
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                        height: double.infinity,
                                        child: Text(widget.note.description,
                                            maxLines: 5,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 15.00,
                                              color: Colors.black,
                                            )))),
                                SizedBox(
                                  height: 2.5,
                                ),
                                Flexible(
                                    child: Container(
                                        height: double.infinity,
                                        child: Text(widget.note.timestamp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.00,
                                              color: Colors.black,
                                            ))))
                              ])))
                ]))),
          ),
        ));
  }
}
