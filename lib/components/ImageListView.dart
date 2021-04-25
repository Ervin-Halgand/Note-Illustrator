import 'dart:io';

import 'package:flutter/material.dart';
import 'package:note_illustrator/pages/FullScreenImage.dart';

class ImageListView extends StatefulWidget {
  final List<dynamic> images;
  final Function removeAt;
  final Function reorder;
  const ImageListView({Key key, this.images, this.removeAt, this.reorder})
      : super(key: key);
  @override
  _ImageListViewState createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.images.length * 125.0,
        child: ReorderableListView.builder(
            onReorder: (oldIndex, newIndex) =>
                widget.reorder(oldIndex, newIndex),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: ValueKey(widget.images[index]),
                onDismissed: (dir) => widget.removeAt(index),
                background: Container(color: Colors.red[100]),
                child: Container(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return FullScreenImage(
                        imagePath: File(widget.images[index]),
                      );
                    })),
                    child: Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      height: 120,
                      child: ClipRRect(
                        child: FittedBox(
                          child: Image.file(File(widget.images[index])),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
