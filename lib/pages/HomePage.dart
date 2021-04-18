import 'package:flutter/material.dart';
import 'package:note_illustrator/routes/router.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final String assetName = 'assets/homePage.svg';
final Widget svg = SvgPicture.asset(assetName, semanticsLabel: 'File Logo');

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: RichText(
              text: TextSpan(
                text: 'Welcome to',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
                children: <TextSpan>[
                  TextSpan(
                      text: ' Note Illustrator',
                      style: TextStyle(color: Color(0xff29c0e7))),
                  TextSpan(
                    text: ' !',
                  )
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
            child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                assetName,
                placeholderBuilder: (context) => CircularProgressIndicator(),
                height: 261.0,
              ),
            ),
            // Text('Username *',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Color(0xfff08f1c),
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold)),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 80)),
                    child: Form(
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: () {
                        Form.of(primaryFocus.context).save();
                      },
                      child: TextFormField(
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Username *',
                          labelStyle: TextStyle(
                              color: Color(0xfff08f1c),
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      onSaved: (String value) {
                        print('Value for field saved as "$value"');
                      },
                      validator: (String value) {
                        return (value != null && value.isNotEmpty && value != "")
                            ? null
                            : 'Please enter some text.';
                      },
                    )))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    primary: Color(0xff29c0e7)),
                onPressed: () =>
                    Navigator.pushNamed(context, routesDashBoardPage),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Next Page',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
