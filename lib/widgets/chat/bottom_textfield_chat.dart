import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class BottomTextFieldChat extends StatefulWidget {
  final Function onPressed;

  const BottomTextFieldChat({Key key, this.onPressed}) : super(key: key);

  @override
  _BottomTextFieldChatState createState() => _BottomTextFieldChatState();
}

class _BottomTextFieldChatState extends State<BottomTextFieldChat> {
  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 3, 5, 3),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: message,
                cursorColor: Colors.blue,
                style: TextStyle(color: Colors.white70),
                decoration: InputDecoration.collapsed(
                  hintStyle: TextStyle(color: Colors.white60),
                  hintText: "Send a message",
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(12, 0, 4, 0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _onPressed,
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressed() {
    widget.onPressed(message.text);
    message.text = "";
  }
}
