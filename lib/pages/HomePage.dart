import 'package:flutter/material.dart';
import 'package:note_illustrator/routes/router.dart';
import 'package:note_illustrator/widgets/BottomAppBar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  bool _btnEnabled = false;
  String filesHomePage = 'assets/homePage.svg';
  late Widget svg;

  getSvg() {
    svg = SvgPicture.asset(filesHomePage, semanticsLabel: 'File Logo');
  }

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
                      style: TextStyle(color: Theme.of(context).primaryColor)),
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
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  filesHomePage,
                  placeholderBuilder: (context) => CircularProgressIndicator(),
                  height: 280.0,
                ),
              ),
            ),
            // Text('Username *',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Color(0xfff08f1c),
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold)),
            Expanded(
                child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: ConstrainedBox(
                    constraints: BoxConstraints.tight(const Size(200, 80)),
                    child: Form(
                        key: _formKey,
                        onChanged: () {
                          Form.of(primaryFocus!.context!)!.save();
                        },
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  color: Color(0xfff08f1c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          onSaved: (String? value) {
                            print('Value for field saved as "$value"');
                          },
                          validator: (String? value) {
                            if (value != null &&
                                value.isNotEmpty &&
                                value != "") {
                              setState(() {
                                _btnEnabled = true;
                              });
                              return (null);
                            } else
                              return ('Please enter some text.');
                          },
                        ))),
              ),
            )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                          primary: Theme.of(context).primaryColor),
                      onPressed: () => _formKey.currentState!.validate()
                          ? Navigator.pushNamed(context, routesDashBoardPage)
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          8.0,
                          15.0,
                          8.0,
                          15.0,
                        ),
                        child: Text(
                          'Next Page',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
