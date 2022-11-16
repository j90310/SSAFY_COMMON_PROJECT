import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/kakao_login_model.dart';
import '../models/palette.dart';
import '../notice.dart';
import 'chat_route.dart';
import 'package:intl/intl.dart';



class ChatRoomListParty extends StatefulWidget {
  final int partySeq;

  const ChatRoomListParty({Key? key, required this.partySeq}) : super(key: key);


  @override
  State<ChatRoomListParty> createState() => _ChatRoomListPartyState();
}

class _ChatRoomListPartyState extends State<ChatRoomListParty> {


  @override
  Widget build(BuildContext context) {
    var kakaoUserProvider = Provider.of<KakaoLoginModel>(context);
    final Query<Map<String, dynamic>> _chats = FirebaseFirestore.instance.collection('chats').where("partyseq", isEqualTo: widget.partySeq);
    var palette = Provider.of<Palette>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅방',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: palette.createMaterialColor(Color(0xff8581E1)),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
        stream: _chats.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot){
          print(streamSnapshot);
          if(streamSnapshot.hasData){
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                var toDateTime = documentSnapshot['last_message_at'].toDate();
                return InkWell(
                    splashColor: palette.createMaterialColor(Color(0xffD1ADE6)),
                    highlightColor: palette.createMaterialColor(Color(0xffD1ADE6)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatRoute(chatId: documentSnapshot['chatroomName'])),
                      );
                    },
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(width: 1.0, color: palette.createMaterialColor(Color(0xff8581E1))),
                          )
                      ),
                      child: Row(
                        children: [
                          Flexible(flex: 3,
                            child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: SizedBox(
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        // imageUrl: documentSnapshot['profileImage'],
                                        imageUrl: kakaoUserProvider.userResVO!.userKakaoLoginId.toString() == documentSnapshot['guestSeq']
                                            ? documentSnapshot['hostProfileImage'] : documentSnapshot['guestProfileImage'],
                                        placeholder: (context, url) => new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) => new Icon(Icons.error, size: 100,),
                                      ),
                                    )
                                )
                            ),
                          ),
                          Flexible(flex: 10,child: Container(
                              margin: EdgeInsets.only(left:10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(documentSnapshot['guestNickname'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,),),
                                        Text(documentSnapshot['last_text'], style: TextStyle(fontSize: 15, overflow: TextOverflow.ellipsis, color: Colors.black54)),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(DateFormat.yMMMd().format(toDateTime), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: palette.createMaterialColor(Color(0xff8581E1)))),
                                        Text(DateFormat.jm().format(toDateTime), style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: palette.createMaterialColor(Color(0xff8581E1)))),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                          ),
                          )
                        ],
                      ),
                    )
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
