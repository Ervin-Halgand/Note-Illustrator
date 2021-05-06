import 'dart:convert';

class NotesModel {
  int id;
  List<dynamic> audioRecords = [];
  List<dynamic> images = [];
  String title = "";
  String description = "";
  String timestamp = "";

  NotesModel(
      {this.id,
      this.timestamp,
      this.title,
      this.description,
      this.audioRecords,
      this.images
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestamp': timestamp,
      'title': title,
      'description': description,
      'audioRecords': jsonEncode(audioRecords),
      'images': jsonEncode(images)
    };
  }
}
