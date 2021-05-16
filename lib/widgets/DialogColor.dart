import 'package:flutter/material.dart';
import 'package:note_illustrator/constants/appConstant.dart';

class DialogColor extends StatefulWidget {
  Function callBack;

  DialogColor({@required this.callBack});

  @override
  _DialogColorState createState() => _DialogColorState();
}

class _DialogColorState extends State<DialogColor> {
  final List<String> colors = [
    "#ffffff",
    "#e28585",
    "#e2e285",
    "#85e2d6",
    "#85e2a1",
    "#a6e285",
    "#e29885",
    "#e285b2",
    "#85c0e2",
    "#e28585",
    "#a885e2",
    "#e2bf85"
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (BuildContext context, int index) => Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () => widget.callBack(colors[index]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: HexColor(colors[index]),
                          border: Border.all(width: 3, color: Colors.black),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 60,
                      ),
                    ),
                  ),
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
