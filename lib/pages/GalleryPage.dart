import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_illustrator/components/ImageListView.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:note_illustrator/pages/FullScreenImage.dart';
import 'package:note_illustrator/widgets/UserAppBar.dart';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

Future getImages() async {
  List<String> imageList = await DataBase().images();
  return imageList;
}

class _GalleryPageState extends State<GalleryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: UserAppBarWidget(saveEditable: false),
        ),
        bottomNavigationBar: BottomAppBarWidget(),
        body: SafeArea(child: Center(child: imageWidget(context))));
  }

  Widget imageWidget(BuildContext context) {
    return FutureBuilder(
      builder: (context, note) {
        if (note.connectionState == ConnectionState.none &&
            note.hasData == null) {
          return Container();
        }
        if (note.data != null && !note.data.isEmpty) {
          return new StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: note.data.length,
            itemBuilder: (BuildContext context, int index) => new Card(
              color: Colors.transparent,
              elevation: 0,
              child: GestureDetector(
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FullScreenImage(
                    imagePath: File(note.data[index]),
                  );
                })),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.file(
                      File(note.data[index]),
                    ),
                  ),
                ),
              ),
            ),
            staggeredTileBuilder: (int index) {
              var n = index;
              if (index >= 10) n = index % 10;
              if (n % 7 == 0) return new StaggeredTile.count(2, 2);
              return new StaggeredTile.count(1, 1);
            },
            padding: const EdgeInsets.all(4),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          );
        } else
          return Center(child: Text("Add images..."));
      },
      future: getImages(),
    );
  }
}
