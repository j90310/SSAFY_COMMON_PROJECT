import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:piece_of_cake/models/kakao_login_model.dart';
import 'package:piece_of_cake/models/palette.dart';
import 'package:piece_of_cake/models/party_model.dart';
import 'package:piece_of_cake/party/buy/buy_detail_guest.dart';
import 'package:piece_of_cake/party/buy/buy_detail_host.dart';
import 'package:piece_of_cake/party/buy/buy_party_list.dart';
import 'package:piece_of_cake/party/dlv/dlv_detail_guest.dart';
import 'package:piece_of_cake/party/dlv/dlv_detail_host.dart';
import 'package:piece_of_cake/party/dlv/dlv_party_list.dart';
import 'package:piece_of_cake/party/party_list.dart';
import 'package:piece_of_cake/party/pie/pie_detail_guest.dart';
import 'package:piece_of_cake/party/pie/pie_detail_host.dart';
import 'package:piece_of_cake/party/pie/pie_party_list.dart';
import 'package:piece_of_cake/vo.dart';
import 'package:piece_of_cake/widgets/map_setting.dart';
import 'package:provider/provider.dart';
import 'user/my.dart';
import 'party/pie/pie_create.dart';
import 'party/bookmark/bookmark_list.dart';
import './notice.dart';
import './search.dart';
import 'package:piece_of_cake/widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Party> partyList = [];
  List<PartyResVO> partyResVOList = [];
  List<Party> piePartyList = [];
  List<PartyResVO> piePartyResVOList = [];
  List<Party> buyPartyList = [];
  List<PartyResVO> buyPartyResVOList = [];
  List<Party> dlvPartyList = [];
  List<PartyResVO> dlvPartyResVOList = [];
  List<int> bookmarkList = [];
  List<Party> bookmarkPartyList = [];
  List<PartyResVO> bookmarkPartyResVOList = [];
  List<Party> latestPartyList = [];
  List<PartyResVO> latestPartyResVOList = [];

  void setList(kakaoUserProvider, partyProvider) async {
    await partyProvider.fetchPartyList();
    partyResVOList = partyProvider.partyResVOList;
    await partyProvider.fetchPiePartyList();
    piePartyResVOList = partyProvider.buyPartyResVOList;
    await partyProvider.fetchBuyPartyList();
    buyPartyResVOList = partyProvider.buyPartyResVOList;
    await partyProvider.fetchDlvPartyList();
    dlvPartyResVOList = partyProvider.buyPartyResVOList;
    await partyProvider.fetchBookmarkPartyList(kakaoUserProvider.userResVO.userSeq);
    bookmarkPartyResVOList = partyProvider.bookmarkPartyResVOList;
    partyProvider.fetchBookmarkList(kakaoUserProvider.userResVO.userSeq);
    bookmarkList = partyProvider.bookmarkList;
    await partyProvider.fetchLatestPartyList();
    latestPartyResVOList = partyProvider.latestPartyResVOList;
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
    for (PartyResVO partyResVO in piePartyResVOList) {
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
    piePartyList = list;
    list = [];
    for (PartyResVO partyResVO in buyPartyResVOList) {
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
    buyPartyList = list;
    list = [];
    for (PartyResVO partyResVO in dlvPartyResVOList) {
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
    dlvPartyList = list;
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
    for (PartyResVO partyResVO in latestPartyResVOList) {
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
      // latestPartyList.add(party);
      list.add(party);
    }
    latestPartyList = list;

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

  LatLng _center = LatLng(45.521563, -122.677433);
  // String userAddress = '';
  void _setUserLatLng(kakaoUserProvider, BuildContext context, LatLng center) async {
    _center = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapSetting()),
    );
    kakaoUserProvider.userResVO.userLat = _center.latitude.toString();
    kakaoUserProvider.userResVO.userLng = _center.longitude.toString();
    // final Uri getAddress = Uri.parse(
    //     'https://maps.googleapis.com/maps/api/geocode/json?latlng=$Lat,$Lng&key=AIzaSyBdf3QkB2KbMDzdfPXYxoBBfyFSk_fxBqk&language=ko');
    // final response = await http.get(getAddress);
    UserReqVO userReqVO = UserReqVO(
      userEmail: kakaoUserProvider.userResVO.userEmail,
      userPhone: kakaoUserProvider.userResVO.userPhone,
      userNickname: kakaoUserProvider.userResVO.userNickname,
      userImage: kakaoUserProvider.userResVO.userImage,
      userRating: kakaoUserProvider.userResVO.userRating,
      userLat: _center.latitude.toString(),
      userLng: _center.longitude.toString(),
      userKakaoLoginId: kakaoUserProvider.userResVO.userKakaoLoginId,
    );
    final response = await http.put(
      Uri.parse('http://i7e203.p.ssafy.io:9090/user'),
      // Uri.parse('http://10.0.2.2:9090/user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userReqVO),
    );
    if (response.statusCode==200) {
      kakaoUserProvider.setUser(UserResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));

    } else {
      throw Exception('Failed to update user latlng.');
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var kakaoUserProvider = Provider.of<KakaoLoginModel>(context);
    var partyProvider = Provider.of<PartyModel>(context);
    var palette = Provider.of<Palette>(context);
    setList(kakaoUserProvider, partyProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${kakaoUserProvider.userResVO!.userNickname}님',
          style: TextStyle(
            color: palette.createMaterialColor(Color(0xff8581E1)),
            // color: Colors.grey,
            fontSize: 15
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _setUserLatLng(kakaoUserProvider, context, _center);
              },
              icon: Icon(Icons.my_location)
          ),
          // IconButton(
          //     onPressed: () {
          //       showSearch(context: context, delegate: customSearch()
          //       );
          //     },
          //     icon: Icon(Icons.search)),
        ]
      ),
      body: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                children: [
                  Text('최신 파티',
                    style: TextStyle(
                      fontSize:20,
                      fontWeight: FontWeight.bold,
                      // color: palette.createMaterialColor(Color(0xff8581E1)),
                      color: palette.createMaterialColor(Color(0xff5b5b5b)),
                      // fontFamily: 'DungGeunMo',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:10),
                    height: 300,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var party in latestPartyList)
                          buildCard(kakaoUserProvider, party, palette),
                          SizedBox(width:12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(10)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PartyList()),
                      );
                    },
                    child: Text(
                      '전체',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: palette.createMaterialColor(Color(0xffFF9EB1))
                    ),
                  ),

                ),
                SizedBox(
                  height: 50,
                  width: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PiePartyList()),
                      );
                    },
                    child: Text(
                      '소분',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: palette.createMaterialColor(Color(0xffFFF3DA))
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyPartyList()),
                      );
                    },
                    child: Text(
                      '공구',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: palette.createMaterialColor(Color(0xffEAF6BD))
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 70,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DlvPartyList()),
                      );
                    },
                    child: Text(
                      '배달',
                      style: TextStyle(
                          fontSize: 16
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: palette.createMaterialColor(Color(0xffCCF5FC))
                    ),
                  ),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.all(60)
            ),
          ]
      ),
    );
  }
  Widget buildCard(kakaoUserProvider, Party party, palette) => InkWell(
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
    child: Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
      width: 200,
      // height: 300,
      child: Column(
        children: [
          Container(
            height: 230,
            // width: 200,
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
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
                ),
                SizedBox(height: 10),
                Text(
                  '${party.partyTitle}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                ),
                SizedBox(height: 10,),
                Text(
                  '${int.parse(party.totalAmount)==0 ? 0 : (int.parse(party.totalAmount)/party.partyMemberNumTotal).ceil()}원',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
                ),
              ],
            )
          ),
      // child: Column(
      //   children: [
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(20),
      //       child: CachedNetworkImage(
      //         imageUrl: party.partyMainImageUrl,
      //         placeholder: (context, url) => new CircularProgressIndicator(),
      //         errorWidget: (context, url, error) => new Icon(Icons.error, size: 100,),
      //         fit: BoxFit.fill,
      //         width: 180,
      //         height: 180,
      //       ),
      //     ),
      //     SizedBox(height: 10),
      //     Text(
      //       '${party.partyTitle}',
      //       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
      //     ),
      //     SizedBox(height: 10,),
      //     Text(
      //       '${int.parse(party.totalAmount)==0 ? 0 : (int.parse(party.totalAmount)/party.partyMemberNumTotal).ceil()}원',
      //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, overflow: TextOverflow.ellipsis),
      //     ),
        ],
      ),
    ),
  );
}
