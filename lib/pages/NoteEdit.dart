import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_illustrator/components/ImageListView.dart';
import 'package:note_illustrator/components/RecordListView.dart';
import 'package:note_illustrator/constants/appConstant.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/services/AudioRecorder.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/widgets/DialogColor.dart';
import 'package:note_illustrator/widgets/DialogPhoto.dart';

class NoteEditor extends StatefulWidget {
  NotesModel note;
  bool isDeletable = true;
  bool titleEditable = true;
  bool isHabit = false;
  NoteEditor(
      {Key key,
      @required this.note,
      this.isDeletable,
      this.titleEditable,
      @required this.isHabit})
      : super(key: key);
  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  AudioRecorder recorder = AudioRecorder();
  AudioPlayer audioPlayer = AudioPlayer();
  NotesModel note = NotesModel(audioRecords: [], images: [], color: "#ffffff");
  Directory appDirectory;
  Color colorMic = Colors.blue;
  final focusNodeHandler = [FocusNode(), FocusNode()];
  final picker = ImagePicker();
  String test = "ttet";

  @override
  void initState() {
    super.initState();
    note = widget.note;
  }

  void editNote() {
    widget.isHabit
        ? DataBase().updateHabitNote(note)
        : DataBase().updateNote(note);
  }

  Future<void> getImageFromCamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage == null) return;
      note.images.add(pickedImage.path);
    });
    Navigator.pop(context);
  }

  Future<void> getImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage == null) return;
      note.images.add(pickedImage.path);
    });
    Navigator.pop(context);
  }

  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String title;
  String timestamp;
  String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                editNote();
                Navigator.pop(context);
              }),
          actions: [
            widget.isDeletable
                ? IconButton(
                    iconSize: 30,
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                    onPressed: () => {
                          DataBase().deleteNote(note.id),
                          Navigator.pop(context)
                        })
                : Text('')
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                heroTag: "btn1",
                elevation: 1.0,
                child: new Icon(
                  Icons.camera_alt,
                  size: 35,
                ),
                onPressed: () => showGeneralDialog(
                      barrierLabel: "Label",
                      barrierDismissible: true,
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionDuration: Duration(milliseconds: 300),
                      context: context,
                      pageBuilder: (context, anim1, anim2) => DialogPhoto(
                          getImageFromCamera: getImageFromCamera,
                          getImageFromGallery: getImageFromGallery),
                      transitionBuilder: (context, anim1, anim2, child) {
                        return SlideTransition(
                          position:
                              Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                  .animate(anim1),
                          child: child,
                        );
                      },
                    )),
            SizedBox(width: 10),
            Container(
              child: FloatingActionButton(
                  heroTag: "btn2",
                  backgroundColor:
                      recorder.isRecording == true ? Colors.red : Colors.blue,
                  elevation: 1.0,
                  child: new Icon(Icons.mic_rounded, size: 35),
                  onPressed: () => {
                        FlutterAudioRecorder.hasPermissions
                            .then((hasPermision) {
                          if (!hasPermision) return;
                          recorder.hasPermission = true;
                          recorder.currentStatus = RecordingStatus.Initialized;
                        }),
                        recorder.onRecordButtonPressed(
                            (bool isRecording, newRecordPath) => {
                                  if (newRecordPath.toString().length > 0)
                                    note.audioRecords.add(newRecordPath),
                                  setState(() {
                                    recorder.isRecording = isRecording;
                                  })
                                })
                      }),
            ),
            SizedBox(width: 10),
            Container(
              child: FloatingActionButton(
                  heroTag: "btn3",
                  backgroundColor: Colors.blue,
                  elevation: 1.0,
                  child: new Icon(Icons.color_lens_outlined, size: 35),
                  onPressed: () => showGeneralDialog(
                        barrierLabel: "Label",
                        barrierDismissible: true,
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionDuration: Duration(milliseconds: 300),
                        context: context,
                        pageBuilder: (context, anim1, anim2) => DialogColor(
                          callBack: (color) => {
                            setState(() {
                              note.color = color;
                            })
                          },
                        ),
                        transitionBuilder: (context, anim1, anim2, child) {
                          return SlideTransition(
                            position:
                                Tween(begin: Offset(0, 1), end: Offset(0, 0))
                                    .animate(anim1),
                            child: child,
                          );
                        },
                      )),
            )
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      backgroundColor: HexColor(note.color),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            widget.titleEditable
                ? TextFormField(
                    initialValue: note.title,
                    onEditingComplete: () => focusNodeHandler[1].requestFocus(),
                    maxLines: 1,
                    focusNode: focusNodeHandler[0],
                    onChanged: (val) {
                      setState(() => note.title = val);
                    },
                    style: Theme.of(context).textTheme.headline2,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Title',
                        hintStyle: Theme.of(context).textTheme.headline2),
                  )
                : Text(note.title,
                    style: Theme.of(context).textTheme.headline2),
            TextFormField(
              initialValue: note.description,
              focusNode: focusNodeHandler[1],
              maxLines: null,
              onChanged: (val) {
                setState(() => note.description = val);
              },
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 10),
            RecordListView(
              records: note.audioRecords,
              removeAt: (i) => setState(() => note.audioRecords.removeAt(i)),
            ),
            SizedBox(height: 10),
            ImageListView(
              images: note.images,
              removeAt: (index) => setState(() => note.images.removeAt(index)),
              reorder: (oldIndex, newIndex) => {
                setState(() {
                  if (oldIndex < newIndex) newIndex -= 1;
                  final String image = note.images.removeAt(oldIndex);
                  note.images.insert(newIndex, image);
                })
              },
            )
          ],
        ),
      ),
    );
  }
}
