import 'dart:io';
import 'package:flutter/material.dart';
import 'package:note_illustrator/routes/router.dart' as router;
import 'package:image_picker/image_picker.dart';
import 'package:note_illustrator/models/UserInfoModel.dart';
import 'package:note_illustrator/services/DataBase.dart';

class UserAppBarWidget extends StatefulWidget {
  bool saveEditable = true;
  UserInfoModel updatedUser;
  UserAppBarWidget({
    this.saveEditable,
    this.updatedUser,
  });
  @override
  _UserAppBarWidget createState() => _UserAppBarWidget();
}

class _UserAppBarWidget extends State<UserAppBarWidget> {
  UserInfoModel user;

  void initState() {
    super.initState();
    () async {
      final dbUser = await DataBase().user();
      print(dbUser);
      setState(() {
        user = dbUser;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.saveEditable)
      return AppBar(
        leading: new IconButton(
          icon: new Icon(
            Icons.save,
            size: 35,
          ),
          onPressed: () => {
            DataBase().updateUser(user),
            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(Duration(seconds: 2), () {
                    Navigator.of(context).pop(true);
                  });
                  return AlertDialog(
                    backgroundColor: Theme.of(context).primaryColor,
                    title: Center(child: Text('Updated')),
                  );
                })
          },
        ),
        title: Align(
            alignment: Alignment.topRight,
            child: user != null ? Text(user.userName) : Text("")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
                // color: Theme.of(context).cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  child: (user != null
                      ? (user.image.length > 0
                          ? ClipOval(
                              child: Image.file(
                                File(user.image),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : SizedBox())
                      : SizedBox()),
                ),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
    else
      return AppBar(
        automaticallyImplyLeading: false,
        title: Align(
            alignment: Alignment.topRight,
            child: user != null ? Text(user.userName) : Text("")),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  child: (user != null
                      ? (user.image.length > 0
                          ? ClipOval(
                              child: Image.file(
                                File(user.image),
                                fit: BoxFit.cover,
                                width: 120,
                                height: 120,
                              ),
                            )
                          : SizedBox())
                      : SizedBox()),
                ),
              ),
            ),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      );
  }
}
