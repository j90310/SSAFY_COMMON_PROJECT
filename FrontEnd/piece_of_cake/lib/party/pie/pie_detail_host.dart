import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:piece_of_cake/chat/chatroom_party_route.dart';
import 'package:piece_of_cake/party/buy/buy_create.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:piece_of_cake/party/pie/pie_modify.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../models/kakao_login_model.dart';
import '../../models/palette.dart';
import '../../models/party_model.dart';
import '../../vo.dart';

class PieDetailHost extends StatefulWidget {
  Party party;
  PieDetailHost({Key? key, required this.party}) : super(key: key);

  @override
  State<PieDetailHost> createState() => _PieDetailHostState();
}

class _PieDetailHostState extends State<PieDetailHost> {
  int activeIndex = 0;

  final List<String> sins = [
    '부정적인 태도',
    '자리비움',
    '의도적으로 적에게 죽어줌',
    '욕설',
    '혐오발언',
  ];
  String? selectedValue;

  final formKey = GlobalKey<FormState>();

  var urlImages = [];
  List<int> partySeqListGuest = [];
  List<PartyResVO> partyResVOGuestList = [];
  List<int> bookmarkList = [];

  void setList(kakaoUserProvider, partyProvider) async {
    await partyProvider
        .fetchBookmarkPartyList(kakaoUserProvider.userResVO.userSeq);
    partyProvider.fetchBookmarkList(kakaoUserProvider.userResVO.userSeq);
    bookmarkList = partyProvider.bookmarkList;
    await partyProvider
        .fetchPartyGuestList(kakaoUserProvider.userResVO.userSeq);
    partyResVOGuestList = partyProvider.partyResVOGuestList;
    await partyProvider.fetchPartyPhotoList(widget.party.partySeq);
    urlImages = partyProvider.partyPhotoFileUrlList;
    List<int> list = [];
    for (PartyResVO partyResVO in partyResVOGuestList) {
      list.add(partyResVO.partySeq);
    }
    partySeqListGuest = list;
    if (mounted) {
      setState(() {});
    }
  }

  void cancelParty(kakaoUserProvider, partyProvider, partySeq) async {
    await partyProvider.cancelParty(partySeq);
    if (mounted) {
      setState(() {});
    }
  }

  void setPartySuccess(kakaoUserProvider, partyProvider, partySeq) async {
    await partyProvider.doneParty(partySeq);
    if (mounted) {
      setState(() {});
    }
  }

  void loadSetState() async {
    if (mounted) {
      setState(() {});
    }
  }

  void setParty(kakaoUserProvider, int partySeq) async {
    final response = await http.get(
      Uri.parse('http://i7e203.p.ssafy.io:9090/party/${partySeq}'),
    );
    if (response.statusCode==200) {
      PartyResVO partyResVO = PartyResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      widget.party = Party(
          partySeq: partyResVO.partySeq,
          userResVO: kakaoUserProvider.userResVO,
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
    } else {
      throw Exception('Failed to load detail party');
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            imageUrl: widget.party.partyMainImageUrl,
            placeholder: (context, url) => new CircularProgressIndicator(),
            errorWidget: (context, url, error) => new Icon(
              Icons.error,
              size: 100,
            ),
            fit: BoxFit.cover,
            width: 180,
            height: 180,
          ),
        ),
      );

  // Widget buildIndicator() => AnimatedSmoothIndicator(
  //     activeIndex: activeIndex,
  //     count: urlImages.length,
  //     effect: JumpingDotEffect(
  //       dotWidth: 20,
  //       dotHeight: 20,
  //     ));

  Widget build(BuildContext context) {
    var kakaoUserProvider = Provider.of<KakaoLoginModel>(context);
    var partyProvider = Provider.of<PartyModel>(context);
    var palette = Provider.of<Palette>(context);
    setList(kakaoUserProvider, partyProvider);
    setParty(kakaoUserProvider, widget.party.partySeq);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '소분 파티',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: palette.createMaterialColor(Color(0xff8581E1)),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PieModify(
                          party: widget.party,
                        )),
              );
            },
          ),
        ],
      ),
      body: Container(
          child: ListView(
        children: [
          Column(
            children: [
              Container(margin: EdgeInsets.all(10)),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 400,
                        enableInfiniteScroll: false,
                        // viewportFraction: 1,
                        autoPlay: false,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = urlImages[index];

                        return buildImage(urlImage, index);
                      },
                    ),
                    const SizedBox(height: 32),
                    // buildIndicator(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl: kakaoUserProvider
                                                .user
                                                ?.kakaoAccount
                                                ?.profile
                                                ?.profileImageUrl ??
                                            '',
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Icon(
                                          Icons.error,
                                          size: 100,
                                        ),
                                      ),
                                    ),
                                  )),
                              Text(
                                ' ${widget.party.userResVO.userNickname}',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.person, size: 40),
                              Text(
                                  '${widget.party.partyMemberNumCurrent}/${widget.party.partyMemberNumTotal}',
                                  style: TextStyle(fontSize: 25))
                            ],
                          )
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${widget.party.partyRegDt[0]}/' +
                            '${widget.party.partyRegDt[1]}/' +
                            '${widget.party.partyRegDt[2]} ' +
                            '${widget.party.partyRegDt[3]}:' +
                            '${widget.party.partyRegDt[4]}:' +
                            '${widget.party.partyRegDt[5]}')
                      ],
                    ),
                    Text(
                      '${widget.party.partyTitle}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(margin: EdgeInsets.all(10)),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${(int.parse(widget.party.totalAmount) / widget.party.partyMemberNumTotal).ceil()}원',
                                    style: TextStyle(fontSize: 20)),
                                Text('1인 금액', style: TextStyle(fontSize: 20)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${widget.party.totalAmount}원',
                                    style: TextStyle(fontSize: 20)),
                                Text('총 금액', style: TextStyle(fontSize: 20)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(margin: EdgeInsets.all(10)),
                    Container(
                      // decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Colors.black,
                      //       width: 1,
                      //     ),
                      //     borderRadius: BorderRadius.circular(10)
                      // ),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '${widget.party.partyContent}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          )),
                    ),
                    Container(margin: EdgeInsets.all(10)),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                '만남 장소',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w200),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Text(
                                '${widget.party.partyAddr}\n${widget.party.partyAddrDetail}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w100),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Container(
                                    // todo: map
                                    ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Container(
                    height: 70,
                    margin: EdgeInsets.only(bottom: 7),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatRoomListParty(
                                  partySeq: widget.party.partySeq)),
                        );
                      },
                      icon: Icon(
                        Icons.question_answer,
                        size: 35,
                      ),
                    )),
              ),
              Flexible(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          width: 135.0,
                          height: 60.0,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                            child: OutlinedButton(
                              onPressed: () {
                                // todo: host가 파티 취소를 누르면 파티 삭제
                                if (widget.party.partyMemberNumCurrent !=
                                    widget.party.partyMemberNumTotal) {
                                  cancelParty(kakaoUserProvider, partyProvider,
                                      widget.party.partySeq);
                                  Navigator.pop(context);
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                side: BorderSide(
                                  width: 5.0,
                                  color: widget.party.partyMemberNumCurrent ==
                                          widget.party.partyMemberNumTotal
                                      ? Colors.grey
                                      : Colors.cyan,
                                ),
                              ),
                              child: Text(
                                widget.party.partyMemberNumCurrent ==
                                        widget.party.partyMemberNumTotal
                                    ? '취소 불가'
                                    : '파티 취소',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      Container(
                          width: 135.0,
                          height: 60.0,
                          margin: EdgeInsets.symmetric(vertical: 3.0),
                          child: SizedBox.expand(
                            child: ElevatedButton(
                              onPressed: () {
                                // todo: host가 파티 완료를 누르면
                                if (widget.party.partyMemberNumCurrent ==
                                    widget.party.partyMemberNumTotal) {
                                  setPartySuccess(kakaoUserProvider,
                                      partyProvider, widget.party.partySeq);
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25))),
                                primary: widget.party.partyStatus==2 ?
                                Colors.grey :
                                (partySeqListGuest.contains(widget.party.partySeq) ?
                                Colors.cyan :
                                Colors.pink),
                                // partySeqListGuest
                                //         .contains(widget.party.partySeq)
                                //     ? (widget.party.partyStatus == 2
                                //         ? Colors.grey
                                //         : Colors.cyan)
                                //     : Colors.pink,
                              ),
                              // todo: 파티 참여 / 참여 취소 (모집중일때만 가능)
                              child: Text(
                                widget.party.partyStatus==2 ?
                                '파티 성사' :
                                (partySeqListGuest.contains(widget.party.partySeq) ?
                                '참여 취소' :
                                '파티 참여'),
                                // ? (widget.party.partyStatus == 2
                                //     ? '파티 성사'
                                //     : '참여 취소')
                                // : '파티 참여',
                                // child: Text(widget.party.partyStatus==2 ? ( partySeqListGuest.contains(widget.party.partySeq) ?  '파티 성사' : '참여 취소') : '파티 참여',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ],
                  ))
            ],
          )),
    );
  }
}
