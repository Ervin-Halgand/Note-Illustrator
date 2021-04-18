import 'package:flutter/material.dart';

class NoteManager extends StatefulWidget {
  @override
  _NoteManagerState createState() => _NoteManagerState();
}

class _NoteManagerState extends State<NoteManager> {
  DateTime date =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () => {})
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Center(
              child: Text(
            "Create Note",
            style: Theme.of(context).textTheme.headline1,
          ))),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
              style: Theme.of(context).textTheme.headline2,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Title',
                  hintStyle: Theme.of(context).textTheme.headline2),
            ),
            Text(
              "${date.day.toString()}-${date.month.toString()}-${date.year.toString()}",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Expanded(
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                },
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 99,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
