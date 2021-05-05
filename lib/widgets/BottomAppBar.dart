import 'package:flutter/material.dart';
import 'package:note_illustrator/constants/bottomAppBar.dart';
import 'package:note_illustrator/routes/router.dart' as router;

class BottomAppBarWidget extends StatelessWidget {
  const BottomAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                iconSize: kIconSize,
                icon: Icon(
                  Icons.dashboard,
                  color: kIconColor,
                ),
                onPressed: () =>
                    {Navigator.pushNamed(context, router.routesDashBoardPage)}),
            IconButton(
                iconSize: kIconSize,
                icon: Icon(
                  Icons.image,
                  color: kIconColor,
                ),
                onPressed: () =>
                    {Navigator.pushNamed(context, router.routesGalleryPage)}),
            IconButton(
                iconSize: kIconSize + 25,
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () =>
                    {Navigator.pushNamed(context, router.routesCreateNote)}),
            IconButton(
                iconSize: kIconSize,
                icon: Icon(Icons.calendar_today, color: kIconColor),
                onPressed: () =>
                    {Navigator.pushNamed(context, router.routesHabitPage)}),
            IconButton(
                iconSize: kIconSize,
                icon: Icon(
                  Icons.person,
                  color: Color(0xff5F6368),
                ),
                onPressed: () =>
                    {Navigator.pushNamed(context, router.routesSettingPage)}),
          ],
        ),
      ),
    );
  }
}
