import 'package:flutter/material.dart';
import 'package:battle_me/models/message.dart';

class MessageSentChat extends StatelessWidget {
  final Message message;
  final bool firstMessage;
  final bool lastMessage;

  const MessageSentChat({
    Key key,
    this.message,
    this.firstMessage = true,
    this.lastMessage = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          5, firstMessage ? 20 : 5, 5, lastMessage ? 20 : 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(fontSize: 12, color: Colors.grey[400]),
          ),
          SizedBox(
            width: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  message.message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
