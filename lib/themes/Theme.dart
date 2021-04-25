import 'package:flutter/material.dart';
import 'package:note_illustrator/constants/appConstant.dart';
import 'package:note_illustrator/constants/bottomAppBar.dart';

final ThemeData theme = ThemeData(
    primaryColor: kPrimaryColor,
    textTheme: TextTheme(
        headline1: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.w900, color: Colors.black),
        headline2: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.black),
            headline3: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.w900, color: Colors.black),
        subtitle1: TextStyle(
            fontSize: 12.0, fontWeight: FontWeight.bold, color: kIconColor),
        bodyText1: TextStyle(
            fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.black)));
