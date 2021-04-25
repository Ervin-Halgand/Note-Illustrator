import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class RecordListView extends StatefulWidget {
  final List<dynamic> records;
  final Function removeAt;
  const RecordListView({Key key, this.records, this.removeAt})
      : super(key: key);

  @override
  _RecordListViewState createState() => _RecordListViewState();
}

class _RecordListViewState extends State<RecordListView> {
  int _totalDuration;
  int _currentDuration;
  double _completedPercentage = 0.0;
  bool _isPlaying = false;
  int _selectedIndex = -1;
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.records.length,
      shrinkWrap: true,
      reverse: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            _onPlay(filePath: widget.records.elementAt(i), index: i);
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        _selectedIndex == i ? Colors.cyan[100] : Colors.cyan[50],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Text('${widget.records.length - i}'),
                        SizedBox(width: 10),
                        SizedBox(
                          width: 50,
                          child: LinearProgressIndicator(
                            minHeight: 2,
                            backgroundColor: Colors.black,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                            value:
                                _selectedIndex == i ? _completedPercentage : 0,
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                            child: Icon(
                              Icons.highlight_remove_outlined,
                              size: 20,
                            ),
                            onTap: () async {
                              final file = File(widget.records.elementAt(i));
                              widget.removeAt(i);
                              await file.delete();
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _onPlay({@required String filePath, @required int index}) async {
    if (!_isPlaying) {
      audioPlayer.play(filePath, isLocal: true);
      setState(() {
        _selectedIndex = index;
        _completedPercentage = 0.0;
        _isPlaying = true;
      });
      audioPlayer.onPlayerCompletion.listen((_) {
        setState(() {
          _selectedIndex = null;
          _isPlaying = false;
          _completedPercentage = 0.0;
        });
      });
      audioPlayer.onDurationChanged.listen((duration) {
        setState(() {
          _totalDuration = duration.inMicroseconds;
        });
      });
      audioPlayer.onAudioPositionChanged.listen((duration) {
        setState(() {
          _currentDuration = duration.inMicroseconds;
          _completedPercentage =
              _currentDuration.toDouble() / _totalDuration.toDouble();
        });
      });
    } else {
      setState(() {
        audioPlayer.stop();
        _selectedIndex = null;
        _isPlaying = false;
        _completedPercentage = 0.0;
      });
    }
  }

  String _getDateFromFilePatah({@required String filePath}) {
    String fromEpoch = filePath.substring(
        filePath.lastIndexOf('/') + 1, filePath.lastIndexOf('.'));

    DateTime recordedDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(fromEpoch));
    int year = recordedDate.year;
    int month = recordedDate.month;
    int day = recordedDate.day;

    return ('$year-$month-$day');
  }
}
