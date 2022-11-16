import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:piece_of_cake/chat/widget/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/kakao_login_model.dart';

class ChatMessages extends StatelessWidget {
  final String chatId;
  final _database = FirebaseFirestore.instance;
  User? user;

  ChatMessages({required this.chatId});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _database
            .collection('chats/$chatId/messages')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (
          builderContext,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          final data = snapshot.data;
          final count = data != null ? data.docs.length : 0;
          return count > 0 && data != null && snapshot.connectionState != ConnectionState.waiting
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  reverse: true,
                  itemCount: count,
                  itemBuilder: (builderContext, index) {
                    final text = data.docs[index].get('text');
                    final uid = data.docs[index].get('uid');
                    final username = data.docs[index].get('username');
                    final currentUid = Provider.of<KakaoLoginModel>(context).user?.id.toString() ?? '';
                    return MessageBubble(
                      messageText: text,
                      ownMessage: uid == currentUid,
                      username: username,
                      key: ValueKey(data.docs[index].id),
                    );
                  },
                )
              : Center(child: Text(''));
        },
      );
}
