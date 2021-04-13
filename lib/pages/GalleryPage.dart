import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBarWidget(),
        body: Center(child: Text('Gallery Page')));
  }
}
