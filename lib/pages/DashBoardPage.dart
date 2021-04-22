import 'package:flutter/material.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import '../widgets/Notes.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			bottomNavigationBar: BottomAppBarWidget(),
			// body: Center(child: Text('hello')));
			body: Center(child: NotesPage()));
		// 	body: Center(
		// 		child: Column(
		// 			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
		// 			children: [
		// 				SearchBar(),
		// 				NotesPage()
		// 			// Expanded(
		// 			// child: Padding(
		// 			//   padding: const EdgeInsets.all(20.0),
		// 			//   child: SearchBar(),)
		// 			// child: NotesPage()
		// 			// )
		// 			]
		// 			// )
		// 			//  NotePages()
		// 			)),
		// );
	}
}
