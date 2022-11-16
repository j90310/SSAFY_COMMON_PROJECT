import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:piece_of_cake/models/palette.dart';
import 'package:piece_of_cake/party/buy/buy_detail_guest.dart';
import 'package:piece_of_cake/party/buy/buy_detail_host.dart';
import 'package:piece_of_cake/party/dlv/dlv_detail_guest.dart';
import 'package:piece_of_cake/party/dlv/dlv_detail_host.dart';
import 'package:piece_of_cake/party/pie/pie_detail_guest.dart';
import 'package:piece_of_cake/party/pie/pie_detail_host.dart';
import 'package:piece_of_cake/vo.dart';
import 'package:provider/provider.dart';
import 'package:piece_of_cake/models/kakao_login_model.dart';
import 'package:piece_of_cake/models/party_model.dart';
import 'package:piece_of_cake/notice.dart';
import 'package:piece_of_cake/search.dart';
import 'package:piece_of_cake/widget.dart';

class BookmarkList extends StatefulWidget {
  const BookmarkList({Key? key}) : super(key: key);

  @override
  State<BookmarkList> createState() => _BookmarkListState();
}

class _BookmarkListState extends State<BookmarkList> {
  List<Party> partyList = [];
  List<PartyResVO> partyResVOList = [];
  List<int> bookmarkList = [];
  List<Party> bookmarkPartyList = [];
  List<PartyResVO> bookmarkPartyResVOList = [];

  void setList(kakaoUserProvider, partyProvider) async {
    await partyProvider.fetchPartyList();
    partyResVOList = partyProvider.partyResVOList;
    await partyProvider.fetchBookmarkPartyList(kakaoUserProvider.userResVO.userSeq);
    bookmarkPartyResVOList = partyProvider.bookmarkPartyResVOList;
    partyProvider.fetchBookmarkList(kakaoUserProvider.userResVO.userSeq);
    bookmarkList = partyProvider.bookmarkList;
    List<Party> list = [];
    for (PartyResVO partyResVO in partyResVOList) {
      await kakaoUserProvider.setCurrentPartyWriter(partyResVO.userSeq);
      UserResVO userResVO = kakaoUserProvider.currentPartyWriter;
      var party = Party(
          partySeq: partyResVO.partySeq,
          userResVO: userResVO,
          partyCode: partyResVO.partyCode,
          partyTitle: partyResVO.partyTitle,
          partyContent: partyResVO.partyContent,
          partyBookmarkCount: partyResVO.partyBookmarkCount,
          partyRegDt: partyResVO.partyRegDt,
          partyUpdDt: partyResVO.partyUpdDt,
          partyRdvDt: partyResVO.partyRdvDt,
          partyRdvLat: partyResVO.partyRdvLat,
          partyRdvLng: partyResVO.partyRdvLng,
          partyMemberNumTotal: partyResVO.partyMemberNumTotal,
          partyMemberNumCurrent: partyResVO.partyMemberNumCurrent,
          partyAddr: partyResVO.partyAddr,
          partyAddrDetail: partyResVO.partyAddrDetail,
          partyStatus: partyResVO.partyStatus,
          itemLink: partyResVO.itemLink,
          totalAmount: partyResVO.totalAmount,
          partyMainImageUrl: partyResVO.partyMainImageUrl
      );
      // partyList.add(party);
      list.add(party);
    }
    partyList = list;
    list = [];
    for (PartyResVO partyResVO in bookmarkPartyResVOList) {
      await kakaoUserProvider.setCurrentPartyWriter(partyResVO.userSeq);
      UserResVO userResVO = kakaoUserProvider.currentPartyWriter;
      var party = Party(
          partySeq: partyResVO.partySeq,
          userResVO: userResVO,
          partyCode: partyResVO.partyCode,
          partyTitle: partyResVO.partyTitle,
          partyContent: partyResVO.partyContent,
          partyBookmarkCount: partyResVO.partyBookmarkCount,
          partyRegDt: partyResVO.partyRegDt,
          partyUpdDt: partyResVO.partyUpdDt,
          partyRdvDt: partyResVO.partyRdvDt,
          partyRdvLat: partyResVO.partyRdvLat,
          partyRdvLng: partyResVO.partyRdvLng,
          partyMemberNumTotal: partyResVO.partyMemberNumTotal,
          partyMemberNumCurrent: partyResVO.partyMemberNumCurrent,
          partyAddr: partyResVO.partyAddr,
          partyAddrDetail: partyResVO.partyAddrDetail,
          partyStatus: partyResVO.partyStatus,
          itemLink: partyResVO.itemLink,
          totalAmount: partyResVO.totalAmount,
          partyMainImageUrl: partyResVO.partyMainImageUrl
      );
      // bookmarkPartyList.add(party);
      list.add(party);
    }
    bookmarkPartyList = list;

    if (mounted) {
      setState(() {});
    }
  }

  late UserResVO writer;
  Future setCurrentPartyWriter(int userSeq) async {
    // print('[KakaoLoginModel] setCurrentPartyWriter(int userSeq) called');
    final response = await http.get(
        Uri.parse('http://i7e203.p.ssafy.io:9090/user/${userSeq}')
    );
    if (response.statusCode==200) {
      UserResVO userResVO = UserResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      writer = userResVO;
      // print('${_currentPartyWriter!.userNickname}');
    } else {
      throw Exception('Failed to load current party writer.');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('bookmark list');
    final kakaoUserProvider = Provider.of<KakaoLoginModel>(context, listen: false);
    final partyProvider = Provider.of<PartyModel>(context, listen: false);
    final palette = Provider.of<Palette>(context);
    setList(kakaoUserProvider, partyProvider);
    return Scaffold(
      appBar: AppBar(
        title: new Center(
          child: new Text(
            '당신의 위시 리스트',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: palette.createMaterialColor(Color(0xff8581E1)),
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
          // title: Text(
          //   '당신의 위시리스트',
          //   style: TextStyle(
          //   ),
          // ),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => Notice()),
          //         );
          //       },
          //       icon: Icon(Icons.notifications)
          //   ),
          //   IconButton(
          //       onPressed: () {
          //         showSearch(context: context, delegate: customSearch()
          //         );
          //       },
          //       icon: Icon(Icons.search))
          // ]
      ),
      body: ListView(
        children: [
          for (var party in bookmarkPartyList)
            InkWell(
              splashColor: Colors.deepPurpleAccent,
              hoverColor: Colors.pink,
              highlightColor: Colors.amber,
              child: Container(
                height: 146,
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: palette.createMaterialColor(Color(0xffCCF5FC)),
                    border: Border.all(
                      // color: Colors.pink,
                      // color: palette.createMaterialColor(Color(0xffD1ADE6)),
                      color: party.partyCode=='001' ?
                      palette.createMaterialColor(Color(0xffFFF3DA)) :
                      party.partyCode=='002' ?
                      palette.createMaterialColor(Color(0xffEAF6BD)) :
                      palette.createMaterialColor(Color(0xffCCF5FC))
                      ,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: party.partyMainImageUrl,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error, size: 100,),
                          fit: BoxFit.cover,
                          width: 180,
                          height: 180,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    flex: 6,
                    child: Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              party.partyTitle.length >= 10 ?
                                (party.partyTitle.substring(0, 10).contains('\n') ?
                                party.partyTitle.substring(0, party.partyTitle.indexOf('\n', 0)) :
                              '${party.partyTitle.substring(0, 10)}...') :
                              (party.partyTitle.contains('\n') ?
                                party.partyTitle.substring(0, party.partyTitle.indexOf('\n', 0)) :
                                party.partyTitle),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              )
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            // '${party.partyAddr.length >= 10 ? party.partyAddr.substring(0, 10).padRight(3, '.') : party.partyAddr}',
                            party.partyAddr.length >= 10 ?
                            (party.partyAddr.substring(0, 10).contains('\n') ?
                            party.partyAddr.substring(0, party.partyAddr.indexOf('\n', 0)) :
                            '${party.partyAddr.substring(0, 10)}...') :
                            (party.partyAddr.contains('\n') ?
                            party.partyAddr.substring(0, party.partyAddr.indexOf('\n', 0)) :
                            party.partyAddr),
                            style: TextStyle(
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            party.partyContent.length >= 10 ?
                            (party.partyContent.substring(0, 10).contains('\n') ?
                            party.partyContent.substring(0, party.partyContent.indexOf('\n', 0)) :
                            '${party.partyContent.substring(0, 10)}...') :
                            (party.partyContent.contains('\n') ?
                            party.partyContent.substring(0, party.partyContent.indexOf('\n', 0)) :
                            party.partyContent),
                            style: TextStyle(
                              fontSize: 15,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              LikeButton(
                                onTap: (bool isLiked) async {
                                  var bookmarkReqVO = BookmarkReqVO(
                                    userSeq: kakaoUserProvider.userResVO!.userSeq,
                                    partySeq: party.partySeq,
                                  );
                                  if (isLiked) {
                                    // todo: delete bookmark
                                    await partyProvider.deleteBookmark(bookmarkReqVO);
                                  } else {
                                    // todo: insert bookmark
                                    await partyProvider.insertBookmark(bookmarkReqVO);
                                  }
                                  bookmarkPartyResVOList = partyProvider.bookmarkPartyResVOList;
                                  bookmarkList = partyProvider.bookmarkList;
                                  setState(() {});
                                },
                                bubblesSize: 0,
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    bookmarkList.contains(party.partySeq) ? Icons.favorite : Icons.favorite_border,
                                    // color: Colors.deepPurpleAccent,
                                    color: palette.createMaterialColor(Color(0xffFF9EB1)),
                                    size: 20,
                                  );
                                },
                                isLiked: bookmarkList.contains(party.partySeq) ? true : false,
                                likeCount: party.partyBookmarkCount,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                  ],
                ),
              ),
              onTap: () async {
                // kakaoUserProvider.setCurrentPartyWriter(party.userResVO.userSeq);
                // var writer = kakaoUserProvider.currentPartyWriter;
                await setCurrentPartyWriter(party.userResVO.userSeq);
                switch (party.partyCode) {
                  case '001':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                      kakaoUserProvider.userResVO!.userSeq==party.userResVO.userSeq ?
                      PieDetailHost(party: party,) :
                      PieDetailGuest(party: party, writer: writer,),
                      ),
                    );
                    break;
                  case '002':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                      kakaoUserProvider.userResVO!.userSeq==party.userResVO.userSeq ?
                      BuyDetailHost(party: party,) :
                      BuyDetailGuest(party: party, writer: writer,),
                      ),
                    );
                    break;
                  case '003':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                      kakaoUserProvider.userResVO!.userSeq==party.userResVO.userSeq ?
                      DlvDetailHost(party: party,) :
                      DlvDetailGuest(party: party, writer: writer,),
                      ),
                    );
                    break;
                }
              },
            )
        ],
      ),
    );
  }
}