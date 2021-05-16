import 'dart:convert';

class NotesModel {
  int id;
  List<dynamic> audioRecords = [];
  List<dynamic> images = [];
  String title = "";
  String description = "";
  String timestamp = "";
  String color = "";

  NotesModel(
      {this.id,
      this.timestamp,
      this.title,
      this.description,
      this.audioRecords,
      this.images,
      this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'title': title,
      'description': description,
      'audioRecords': jsonEncode(audioRecords),
      'images': jsonEncode(images),
      'color': color
    };
  }
}
