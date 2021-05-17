import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_illustrator/models/UserInfoModel.dart';
import 'package:note_illustrator/services/DataBase.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:note_illustrator/widgets/UserAppBar.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  UserInfoModel user;
  final picker = ImagePicker();

  Future<void> getImageFromCamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedImage == null) return;
      user.image = pickedImage.path;
    });
  }

  Future<void> getImageFromGallery() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage == null) return;
      user.image = pickedImage.path;
    });
  }

  @override
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
    return Scaffold(
        appBar: AppBar(
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
                  }),
                  setState(() => user.userName = user.userName)
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
        ),
        bottomNavigationBar: BottomAppBarWidget(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1.0, color: Colors.black)),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: GestureDetector(
                        onTap: () => getImageFromGallery(),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor),
                          child: Center(
                            child: Text("Picture from Gallerie"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        onChanged: (value) => {user.userName = value },
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Color(0xfff08f1c),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: GestureDetector(
                        onTap: () => getImageFromCamera(),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.black),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Picture From Camera'),
                              Icon(
                                Icons.camera_alt,
                                size: 35,
                                color: Colors.black54,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
