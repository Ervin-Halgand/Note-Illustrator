import 'package:flutter/material.dart';
import 'package:note_illustrator/themes/Theme.dart';
import 'pages/HomePage.dart';
import 'routes/router.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Note Illustrator',
      home: HomePage(),
      initialRoute: router.routesHomePage,
      onGenerateRoute: router.generateRoute,
    );
  }
}
