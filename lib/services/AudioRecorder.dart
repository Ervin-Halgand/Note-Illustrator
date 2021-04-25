import 'dart:io';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class AudioRecorder {
  RecordingStatus currentStatus = RecordingStatus.Unset;
  FlutterAudioRecorder _audioRecorder;
  bool hasPermission = false;
  bool isRecording = false;

  void _initRecorder() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath = appDirectory.path +
        '/' +
        DateTime.now().millisecondsSinceEpoch.toString() +
        '.aac';
    _audioRecorder =
        FlutterAudioRecorder(filePath, audioFormat: AudioFormat.AAC);
    await _audioRecorder.initialized;
  }

  Future<void> onRecordButtonPressed(Function callBack) async {
    switch (currentStatus) {
      case RecordingStatus.Initialized:
        await _recordVoice(callBack);
        break;

      case RecordingStatus.Recording:
        await _stopRecording(callBack);
        currentStatus = RecordingStatus.Stopped;
        break;

      case RecordingStatus.Stopped:
        await _recordVoice(callBack);
        break;
    }
  }

  void _startRecording(Function callBack) async {
    callBack(true, "");
    await _audioRecorder.start();
  }

  void _stopRecording(Function callBack) async {
    final recorded = await _audioRecorder.stop();
    print(recorded.path);
    callBack(false, recorded.path);
  }

  Future<void> _recordVoice(Function callBack) async {
    if (hasPermission) {
      await _initRecorder();
      await _startRecording(callBack);
      currentStatus = RecordingStatus.Recording;
    }
    /* else {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please allow recording from settings.'),
      ));
    } */
  }
}
