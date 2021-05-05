import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_illustrator/components/ImageListView.dart';
import 'package:note_illustrator/components/RecordListView.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/services/AudioRecorder.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/widgets/DialogPhoto.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/NotesPage.dart';

class NoteManager extends StatefulWidget {
  NotesModel note;
  NoteManager({Key key, this.note}) : super(key: key);
  @override
  _NoteManagerState createState() => _NoteManagerState();
}

// final List<String> noteDescription = [];
// final List<String> noteHeading = [];

// TextEditingController noteHeadingController = new TextEditingController();
// TextEditingController noteDescriptionController = new TextEditingController();

class _NoteManagerState extends State<NoteManager> {
  AudioRecorder recorder = AudioRecorder();
  AudioPlayer audioPlayer = AudioPlayer();
  NotesModel note = NotesModel(audioRecords: [], images: []);
  Directory appDirectory;
  Color colorMic = Colors.blue;
  final focusNodeHandler = [FocusNode(), FocusNode()];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) note = widget.note;
    FlutterAudioRecorder.hasPermissions.then((hasPermision) {
      if (!hasPermision) return;
      recorder.hasPermission = true;
      recorder.currentStatus = RecordingStatus.Initialized;
    });
  }

  void saveNote() {
    DataBase().insertNotes(note);
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
          actions: [
            IconButton(
                iconSize: 35,
                icon: Icon(
                  Icons.save,
                  color: Colors.black,
                ),
                onPressed: () => {
                      timestamp =
                          "${date.day.toString()}-${date.month.toString()}-${date.year.toString()}",
                      setState(() {
                        noteHeading.add(title);
                        noteDescription.add(description);
                        noteDate.add(timestamp);
                      }),
                      print(noteHeading),
                      saveNote,
                      Navigator.pop(context)
                    })
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Center(
              child: Text(
            "Create Note",
            style: Theme.of(context).textTheme.headline1,
          ))),
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
                        recorder.onRecordButtonPressed(
                            (bool isRecording, newRecordPath) => {
                                  if (newRecordPath.toString().length > 0)
                                    note.audioRecords.add(newRecordPath),
                                  setState(() {
                                    recorder.isRecording = isRecording;
                                  })
                                })
                      }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              maxLines: 1,
              onSubmitted: (v) => focusNodeHandler[1].requestFocus(),
              focusNode: focusNodeHandler[0],
              onChanged: (val) {
                setState(() => note.title = val);
              },
              style: Theme.of(context).textTheme.headline2,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.headline2),
            ),
            TextField(
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
              removeAt: (i) => {setState(() => note.audioRecords.removeAt(i))},
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
