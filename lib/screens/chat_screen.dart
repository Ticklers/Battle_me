import 'package:battle_me/scoped_models/main_scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:battle_me/enums/MessageSenderEnum.dart';
import 'package:battle_me/models/chats.dart';
import 'package:battle_me/models/message.dart';
import 'package:battle_me/widgets/chat/bottom_textfield_chat.dart';
import 'package:battle_me/widgets/chat/message_received_chat.dart';
import 'package:battle_me/widgets/chat/message_sent_chat.dart';
import 'package:battle_me/widgets/chat/top_appbar_chat.dart';

class ChatPage extends StatefulWidget {
  final Chats chats;
  final MainModel model;

  const ChatPage({Key key, this.chats, this.model}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Widget> _columnMessages = [Container()];
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _buildMessages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        TopAppBarChat(
          chats: widget.chats,
        ),
        Expanded(
          child: ListView(
            controller: _scrollController,
            reverse: true,
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: _columnMessages,
              ),
            ],
          ),
        ),
        BottomTextFieldChat(
          onPressed: _sendMessage,
        )
      ],
    );
  }

  _buildMessages() {
    List<Widget> listWidgets = [
      Padding(
        padding: const EdgeInsets.only(bottom: 30, top: 10),
        child: Center(
          child: Text(
            widget.chats.messages.length > 0
                ? "Last messages"
                : "No message yet",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      )
    ];

    if (widget.chats.messages.isNotEmpty) {
      int index = 0;
      widget.chats.messages.forEach((message) {
        if (message.userId != 'rishabh') {
          listWidgets.add(MessageReceivedChat(
            urlPhoto: widget.chats.urlPhotoUser,
            message: message,
            firstMessage: index == 0,
            lastMessage: index == widget.chats.messages.length - 1,
          ));
        } else {
          listWidgets.add(MessageSentChat(
            message: message,
            firstMessage: index == 0,
            lastMessage: index == widget.chats.messages.length - 1,
          ));
        }

        index++;
      });
    }

    setState(() {
      _columnMessages = listWidgets;
    });
  }

  _sendMessage(String message) {
    setState(() {
      _columnMessages.add(MessageSentChat(
        message: Message(
          message: message,
          // messageSenderEnum: MessageSenderEnum.USER,
          time: "00:11",
          mediaLink: "mediaLink",
          userId: "rishabhuserid",
          username: "Rishabh",
        ),
        firstMessage: false,
        lastMessage: false,
      ));
    });

    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }
}
