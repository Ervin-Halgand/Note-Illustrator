import 'dart:convert';

class NotesModel {
  int id;
  List<dynamic> audioRecords = [];
  List<dynamic> images = [];
  String title = "";
  String description = "";

  NotesModel(
      {this.id,
      this.title,
      this.description,
      this.audioRecords,
      this.images});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'audioRecords': jsonEncode(audioRecords),
      'images': jsonEncode(images)
    };
  }
}
