import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/models/NotesModel.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:note_illustrator/widgets/NotesPage.dart';
import 'dart:developer' as developer;

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key key}) : super(key: key);
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0.00,
        flexibleSpace: SafeArea(
          child: TabBar(
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                text: "Notes",
              ),
              Tab(
                text: "To Do",
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child:
            SearchBar(onSearch: (null), onItemFound: (null),),
        //     TabBarView(
        //   controller: _tabController,
        //   children: <Widget>[
        //     Center(child: noteWidget()),
        //     Center(
        //       child: Text('It\'s rainy here'),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  Future getNoteDetails() async {
    List<NotesModel> noteList = await DataBase().notes();
    return noteList;
  }

  Widget noteWidget() {
    return FutureBuilder(
      builder: (context, note) {
        if (note.connectionState == ConnectionState.none &&
            note.hasData == null) {
          return Container();
        }
        if (note.data != null && !note.data.isEmpty)
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: List.generate(note.data.length, (index) {
              return Center(
                child: noteList(note.data[index], index),
              );
            }),
          );
        else
          return Center(child: Text("Add Notes..."));
      },
      future: getNoteDetails(),
    );
  }

  Widget noteList(NotesModel note, int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(5.5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: InkWell(
            onTap: () {
              print('Card tapped.');
            },
            child: Container(
                width: 160,
                height: 191,
                decoration: BoxDecoration(
                  color: noteColor[(index % noteColor.length).floor()],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                    child: Row(children: [
                  Flexible(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 10),
                          child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                    child: Text(note.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 20.00,
                                          color: Color(0xff7e7e7e),
                                          fontWeight: FontWeight.w500,
                                        ))),
                                SizedBox(
                                  height: 2.5,
                                ),
                                Flexible(
                                    flex: 2,
                                    child: Container(
                                        height: double.infinity,
                                        child: Text(note.description,
                                            maxLines: 5,
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
                                        child: Text(note.timestamp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12.00,
                                              color: Colors.black,
                                            ))))
                              ])))
                ]))),
          ),
        ));
  }
}
