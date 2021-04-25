import 'package:flutter/material.dart';

class DialogPhoto extends StatefulWidget {
  Function getImageFromCamera;
  Function getImageFromGallery;
  DialogPhoto({key, this.getImageFromCamera, this.getImageFromGallery});

  @override
  _DialogPhotoState createState() => _DialogPhotoState();
}

class _DialogPhotoState extends State<DialogPhoto> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 130,
        child: SizedBox.expand(
            child: Column(
          mainAxisAlignment: MainAxisAlignment
              .spaceEvenly, //Center Column contents vertically,
          children: [
            GestureDetector(
              onTap: () => widget.getImageFromCamera(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Column contents vertically,
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(Icons.camera_alt, size: 40),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text("Camera", style: Theme.of(context).textTheme.headline3)
                ],
              ),
            ),
            GestureDetector(
              onTap: () => widget.getImageFromGallery(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, size: 40),
                  SizedBox(width: 15),
                  Text(
                    "Gallery",
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
            ),
          ],
        )),
        margin: EdgeInsets.only(left: 0, right: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
