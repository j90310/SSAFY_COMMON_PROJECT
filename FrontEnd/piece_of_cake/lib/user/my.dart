import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:piece_of_cake/models/kakao_login_model.dart';
import 'package:piece_of_cake/models/palette.dart';
import 'package:provider/provider.dart';
import '../models/party_model.dart';
import '../notice.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../party/buy/buy_detail_guest.dart';
import '../party/buy/buy_detail_host.dart';
import '../party/dlv/dlv_detail_guest.dart';
import '../party/dlv/dlv_detail_host.dart';
import '../party/pie/pie_detail_guest.dart';
import '../party/pie/pie_detail_host.dart';
import '../vo.dart';

class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  List<Party> partyList = [];
  List<PartyResVO> partyResVOList = [];
  List<int> bookmarkList = [];
  List<Party> bookmarkPartyList = [];
  List<PartyResVO> bookmarkPartyResVOList = [];
  List<Party> partyGuestList = [];
  List<PartyResVO> partyResVOGuestList = [];
  List<Party> partyHostList = [];
  List<PartyResVO> partyResVOHostList = [];

  void setList(kakaoUserProvider, partyProvider) async {
    await partyProvider.fetchPartyList();
    partyResVOList = partyProvider.partyResVOList;
    await partyProvider.fetchBookmarkPartyList(kakaoUserProvider.userResVO.userSeq);
    bookmarkPartyResVOList = partyProvider.bookmarkPartyResVOList;
    partyProvider.fetchBookmarkList(kakaoUserProvider.userResVO.userSeq);
    bookmarkList = partyProvider.bookmarkList;
    await partyProvider.fetchPartyGuestList(kakaoUserProvider.userResVO.userSeq);
    partyResVOGuestList = partyProvider.partyResVOGuestList;
    await partyProvider.fetchPartyHostList(kakaoUserProvider.userResVO.userSeq);
    partyResVOHostList = partyProvider.partyResVOHostList;
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
    list = [];
    for (PartyResVO partyResVO in partyResVOGuestList) {
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
      // partyGuestList.add(party);
      list.add(party);
    }
    partyGuestList = list;
    list = [];
    for (PartyResVO partyResVO in partyResVOHostList) {
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
      // partyHostList.add(party);
      list.add(party);
    }
    partyHostList = list;

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

  Widget _iconWidget() {
    return Icon(
      Icons.local_fire_department,
      size: 25,
      color: Colors.amberAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final kakaoUserProvider = Provider.of<KakaoLoginModel>(context, listen: false);
    final partyProvider = Provider.of<PartyModel>(context, listen: false);
    final palette = Provider.of<Palette>(context);
    setList(kakaoUserProvider, partyProvider);
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset("assets/images/garlands.png"),
          Container(
            decoration: BoxDecoration(
              // color: palette.createMaterialColor(Color(0xffFBB6CB)),
              borderRadius: BorderRadius.circular(20),
              // border: Border.all(
              //   width: 3,
              //   color: palette.createMaterialColor(Color(0xff8581E1)),
              // )
            ),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:15),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(kakaoUserProvider.user?.kakaoAccount?.profile?.nickname ?? '',
                        style: TextStyle(
                          // fontFamily: 'DungGeunMo',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // color: palette.createMaterialColor(Color(0xff764624)),
                          color: Colors.grey,
                        ),
                      ),
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.transparent,
                        child: SizedBox(
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: kakaoUserProvider.user?.kakaoAccount?.profile?.profileImageUrl ?? '',
                              placeholder: (context, url) => new CircularProgressIndicator(),
                              errorWidget: (context, url, error) => new Icon(Icons.error, size: 100,),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // color: palette.createMaterialColor(Color(0xffFFF3DA)),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 3,
                        color: palette.createMaterialColor(Color(0xff8581E1)),
                      )
                    ),
                    margin: EdgeInsets.all(20),
                    child: Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                '당신은...',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          // Text(
                          //   '당신은 ...',
                          //   style: TextStyle(fontSize: 15),
                          // ),
                          Container(
                            margin: EdgeInsets.all(5),
                          ),
                          SfLinearGauge(
                            markerPointers: <LinearWidgetPointer>[
                              LinearWidgetPointer(
                                value: kakaoUserProvider.userResVO!.userRating==null ? 50 : kakaoUserProvider.userResVO!.userRating,
                                // child: _iconWidget(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red,
                                        blurRadius: 6.0,
                                      ),
                                    ]
                                  ),
                                  height: 50,
                                  child: _iconWidget(),
                                ),
                              )
                            ],
                              // markerPointers: [
                              //   // todo: rating point => value
                              //   LinearShapePointer(
                              //     value: kakaoUserProvider.userResVO!.userRating==null ? 50 : kakaoUserProvider.userResVO!.userRating,
                              //     height: 25,
                              //     width: 20,
                              //     color: palette.createMaterialColor(Color(0xff8581E1)),
                              //   )
                              // ],
                            showTicks: false,
                            axisTrackStyle: const LinearAxisTrackStyle(
                              thickness: 10,
                              gradient: LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0.1, 0.5],
                                tileMode: TileMode.clamp
                              )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8),
                          ),
                          // >=70 위대한 갯츠비
                          // >=30 아모르 파티너
                          // 뉴비 환영
                          // 시작은 50점
                          // todo: user.rating -> 삼항연산자
                          Text(
                            '${kakaoUserProvider.userResVO!.userRating>=70 ? '위대한 갯츠비' : kakaoUserProvider.userResVO!.userRating>=30 ? '아모르 파티너' : '뉴비 환영'}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ]),
            ),

          Container(
            padding: EdgeInsets.fromLTRB(30, 10, 10, 0),
            child: Text(
              "파티 참여 내역",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.grey
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          // 파티 참여 내역
          for (var party in partyGuestList)
            InkWell(
              // splashColor: Colors.deepPurpleAccent,
              splashColor: palette.createMaterialColor(Color(0xffEAF6BD)),
              hoverColor: Colors.pink,
              highlightColor: Colors.amber,
              child: Container(
                height: 146,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                              // '${party.partyTitle.length >= 10 ? party.partyTitle.substring(0, 10).padRight(3, '.') : party.partyTitle}',
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
            ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 40, 10, 0),
            child: Text(
              "파티 개설 내역",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ),
          // 파티 개설 내역
          for (var party in partyHostList)
            InkWell(
              // splashColor: Colors.deepPurpleAccent,
              splashColor: palette.createMaterialColor(Color(0xffEAF6BD)),
              hoverColor: Colors.pink,
              highlightColor: Colors.amber,
              child: Container(
                height: 146,
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
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
                                // '${party.partyTitle.length >= 10 ? party.partyTitle.substring(0, 10).padRight(3, '.') : party.partyTitle}',
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
            ),
          Container(
            margin: EdgeInsets.all(50),
            alignment: Alignment.topCenter,
            child: Text(
              'Piece Of Cake',
              style: TextStyle(
                color: Colors.grey

              ),
            ),
          ),
          ],
      ),
    );
  }
}