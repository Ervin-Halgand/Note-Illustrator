import 'package:flutter/material.dart';
import 'package:note_illustrator/pages/DashBoardPage.dart';
import 'package:note_illustrator/pages/GalleryPage.dart';
import 'package:note_illustrator/pages/HabitPage.dart';
import 'package:note_illustrator/pages/HomePage.dart';
import 'package:note_illustrator/pages/SettingPage.dart';

const routesHomePage = '/';
const routesSettingPage = '/setting';
const routesGalleryPage = '/gallery';
const routesDashBoardPage = '/dashboard';
const routesHabitPage = '/habit';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routesHomePage:
      return PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomePage(),
        transitionDuration: Duration(seconds: 0),
      );
    case routesDashBoardPage:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => DashBoardPage(),
          transitionDuration: Duration(seconds: 0));
    case routesGalleryPage:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => GalleryPage(),
          transitionDuration: Duration(seconds: 0));
    case routesSettingPage:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SettingPage(),
          transitionDuration: Duration(seconds: 0));
    case routesHabitPage:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HabitPage(),
          transitionDuration: Duration(seconds: 0));
    default:
      return PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomePage(),
          transitionDuration: Duration(seconds: 0));
  }
}
