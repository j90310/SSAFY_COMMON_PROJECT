import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:provider/provider.dart';

import '../../models/kakao_login_model.dart';

class ComposeMessage extends StatefulWidget {
  final database = FirebaseFirestore.instance;
  final String chatId;

  ComposeMessage({required this.chatId});

  @override
  _ComposeMessageState createState() => _ComposeMessageState();
}

class _ComposeMessageState extends State<ComposeMessage> {
  String _message = '';
  final _messageController = TextEditingController();
  User? user;

  void _sendMessage() async {
    if (_message.trim().isEmpty) return;

    try {
      user = await UserApi.instance.me();

      final userData = await widget.database.collection('users').doc("kakao:" + user!.id.toString()).get();
      await widget.database.collection('chats/${widget.chatId}/messages').add({
        'uid': user!.id.toString(),
        'text': _messageController.text,
        'created_at': Timestamp.now(),
        'username': userData['username'],
      });
      await widget.database.collection('chats').doc(widget.chatId).set({
        'last_text': _messageController.text,
        'last_message_at': Timestamp.now(),
      }, SetOptions(merge: true));
      _messageController.clear();
      setState(() => _message = '');
    } on FirebaseException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message ?? '')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 4.0),
            blurRadius: 6.0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 0,
          bottom: 20,
          left: 10,
          right: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(labelText: 'message'),
                onChanged: (value) {
                  setState(() => _message = value);
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send_rounded),
              onPressed: _message.trim().isEmpty ? null : _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
