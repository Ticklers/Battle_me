import 'package:battle_me/helpers/dimensions.dart';
import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

Widget body(MainModel model) {
  print(model.chatHistory);
  return Container(
    height: 400,
    child: ListView.builder(
      itemCount: model.chatHistory.length,
      padding: EdgeInsets.symmetric(horizontal: 5),
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(
              model.chatHistory[index]['text'],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ); // Add Card
      },
    ),
  );
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return body(model);
    });
  }
}
