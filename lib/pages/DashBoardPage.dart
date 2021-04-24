import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
// import 'package:flappy_search_bar/flappy_search_bar.dart';
import '../widgets/Notes.dart';
// import './NoteManager.dart';
import './ShowNote.dart';
import '../widgets/NotesPage.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

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
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Center(
              child: noteHeading.length > 0
                  ? ShowNote()
                  : Center(child: Text("Add Notes...")),
            ),
            Center(
              child: Text('It\'s rainy here'),
            ),
          ],
        ),
      ),
      // body: SafeArea(
      //   // child: Center(child: NotesPage())
      //   child: noteHeading.length > 0
      //       ? ShowNote()
      //       : Center(child: Text("Add Notes...")),
      // ),
    );
  }
}
