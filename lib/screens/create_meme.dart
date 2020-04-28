import 'package:flutter/material.dart';

class CreateMeme extends StatefulWidget {
  @override
  _CreateMemeState createState() => _CreateMemeState();
}

class _CreateMemeState extends State<CreateMeme> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Create Meme'),
          bottomOpacity: 0.4,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: () {
                  print('Clicked');
                },
                color: Theme.of(context).buttonColor,
                textColor: Theme.of(context).accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.white24),
                ),
                splashColor: Colors.lightGreen,
                child: Text('Upload'),
              ),
            )
          ],
        ),
        body: Container());
  }
}
