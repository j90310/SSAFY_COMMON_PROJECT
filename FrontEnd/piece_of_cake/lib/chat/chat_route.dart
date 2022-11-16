import 'package:piece_of_cake/chat/widget/chat_messages.dart';
import 'package:piece_of_cake/chat/widget/compose_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../notice.dart';

class ChatRoute extends StatelessWidget {

  final String chatId;

  ChatRoute({required this.chatId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('채팅방'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notice()),
                  );
                },
                icon: Icon(Icons.notifications)
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(child: ChatMessages(chatId: this.chatId)),
            ComposeMessage(chatId: this.chatId),
          ],
        ),
      );
  }
}
