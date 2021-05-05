import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import '../widgets/NotesPage.dart';

class ShowNote extends StatefulWidget {
  @override
  _ShowNoteState createState() => _ShowNoteState();
}

class _ShowNoteState extends State<ShowNote> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: Center(child: Text('Show me your notes !')));
    return Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: new ListView.builder(
            itemCount: noteHeading.length,
            itemBuilder: (context, int index) {
              return Padding(
                  padding: const EdgeInsets.only(bottom: 5.5),
                  child: new Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      setState(() {
                        deletedNoteHeading = noteHeading[index];
                        deletedNoteDescription = noteDescription[index];
                        noteHeading.removeAt(index);
                        noteDescription.removeAt(index);
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            backgroundColor: Colors.purple,
                            content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  new Text(
                                    "Note Deleted",
                                    style: TextStyle(),
                                  ),
                                  deletedNoteHeading != ""
                                      ? GestureDetector(
                                          onTap: () {
                                            print("undo");
                                            setState(() {
                                              if (deletedNoteHeading != "") {
                                                noteHeading
                                                    .add(deletedNoteHeading);
                                                noteDescription.add(
                                                    deletedNoteDescription);
                                              }
                                              deletedNoteHeading = "";
                                              deletedNoteDescription = "";
                                            });
                                          },
                                          child: new Text(
                                            "Undo",
                                            style: TextStyle(),
                                          ))
                                      : SizedBox(),
                                ])));
                      });
                    },
                    background: ClipRRect(
                        borderRadius: BorderRadius.circular(5.5),
                        child: Container(
                            color: Colors.green,
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ]))))),
                    secondaryBackground: ClipRRect(
                        borderRadius: BorderRadius.circular(5.5),
                        child: Container(
                            color: Colors.red,
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ]))))),
                    child: noteList(index),
                  ));
            }));
  }

  Widget noteList(int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.5),
        child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: noteColor[(index % noteColor.length).floor()],
              borderRadius: BorderRadius.circular(5.5),
            ),
            height: 100,
            child: Center(
                child: Row(children: [
              new Container(
                color:
                    noteMarginColor[(index % noteMarginColor.length).floor()],
                width: 3.5,
                height: double.infinity,
              ),
              Flexible(
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                child: Text(noteHeading[index],
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.00,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ))),
                            SizedBox(
                              height: 2.5,
                            ),
                            Flexible(
                                child: Container(
                                    height: double.infinity,
                                    child: Text("${(noteDescription[index])}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.00,
                                          color: Colors.black,
                                        )))),
                            SizedBox(
                              height: 2.5,
                            ),
                            Flexible(
                                child: Container(
                                    height: double.infinity,
                                    child: Text("${(noteDate[index])}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15.00,
                                          color: Colors.black,
                                        ))))
                          ])))
            ]))));
  }
}