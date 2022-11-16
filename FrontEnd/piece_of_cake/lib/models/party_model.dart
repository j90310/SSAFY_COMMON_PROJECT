import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:piece_of_cake/vo.dart';

class PartyModel with ChangeNotifier {
  List<PartyResVO> _partyResVOList = [];
  List<PartyResVO> get partyResVOList => _partyResVOList;
  List<PartyResVO> _piePartyResVOList = [];
  List<PartyResVO> get piePartyResVOList => _piePartyResVOList;
  List<PartyResVO> _buyPartyResVOList = [];
  List<PartyResVO> get buyPartyResVOList => _buyPartyResVOList;
  List<PartyResVO> _dlvPartyResVOList = [];
  List<PartyResVO> get dlvPartyResVOList => _dlvPartyResVOList;
  List<PartyResVO> _latestPartyResVOList = [];
  List<PartyResVO> get latestPartyResVOList => _latestPartyResVOList;
  List<PartyResVO> _bookmarkPartyResVOList = [];  // bookmark list의 party들 목록
  List<PartyResVO> get bookmarkPartyResVOList => _bookmarkPartyResVOList;
  List<int> _bookmarkList = [];
  List<int> get bookmarkList => _bookmarkList;
  List<PartyResVO> _partyGuestList = [];
  List<PartyResVO> get partyResVOGuestList => _partyGuestList;
  List<PartyResVO> _partyHostList = [];
  List<PartyResVO> get partyResVOHostList => _partyHostList;
  // List<String> _partyPhotoFileUrlList = [];
  // List<String> get partyPhotoFileUrlList => _partyPhotoFileUrlList;
  var _partyPhotoFileUrlList = [];
  List get partyPhotoFileUrlList => _partyPhotoFileUrlList;
  PartyResVO? _currentParty;
  PartyResVO? get currentParty => _currentParty;

  Future fetchPartyList() async {
    final response = await
    http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/party'));
    if (response.statusCode==200) {
      this._partyResVOList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchPartyList() this._partyList: ${this._partyResVOList}');
    }else {
      throw Exception('Failed to load party list.');
    }
    // notifyListeners();
  }

  Future fetchPiePartyList() async {
    final response = await
    http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/party/pie'));
    if (response.statusCode==200) {
      this._piePartyResVOList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchPartyList() this._partyList: ${this._partyResVOList}');
    }else {
      throw Exception('Failed to load pie party list.');
    }
    // notifyListeners();
  }

  Future fetchBuyPartyList() async {
    final response = await
    http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/party/buy'));
    if (response.statusCode==200) {
      this._buyPartyResVOList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchPartyList() this._partyList: ${this._partyResVOList}');
    }else {
      throw Exception('Failed to load buy party list.');
    }
    // notifyListeners();
  }

  Future fetchDlvPartyList() async {
    final response = await
    http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/party/dlv'));
    if (response.statusCode==200) {
      this._dlvPartyResVOList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchPartyList() this._partyList: ${this._partyResVOList}');
    }else {
      throw Exception('Failed to load dlv party list.');
    }
    // notifyListeners();
  }

  Future fetchLatestPartyList() async {
    final response = await http.get(
        Uri.parse('http://i7e203.p.ssafy.io:9090/latest-party')
    );
    if (response.statusCode==200) {
      this._latestPartyResVOList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchLatestPartyList() this._latestPartyList: ${this._latestPartyResVOList}');
    }else {
      throw Exception('Failed to laod latest party list.');
    }
    // notifyListeners()
  }

  Future fetchPartyGuestList(int userSeq) async {
    // print('[PartyModel] fetchPartyGuestList()');
    final response = await http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/party/guest/${userSeq}'));
    // print('response.statusCode: ${response.statusCode}');
    if (response.statusCode==200) {
      this._partyGuestList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchPartyGuestList() this._partyGuestList: ${this._partyGuestList}');
    } else {
      throw Exception('Failed to load party guest list.');
    }
    // notifyListeners();기
  }

  Future fetchPartyHostList(int userSeq) async {
    // print('[PartyModel] fetchPartyHostList()');
    final response = await http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/party/host/${userSeq}'));
    // print('response.statusCode: ${response.statusCode}');
    if (response.statusCode==200) {
      this._partyHostList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchPartyHostList() this._partyHostList: ${this._partyHostList}');
    } else {
      throw Exception('Failed to load party host list.');
    }
    // notifyListeners();
  }
  
  Future insertMyParty(int partySeq, int userSeq) async {
    MyPartyReqVO myPartyReqVO = MyPartyReqVO(
        userSeq: userSeq,
        partySeq: partySeq,
        myPartyRole: "guest"
    );
    final response = await http.post(
      Uri.parse('http://i7e203.p.ssafy.io:9090/my-party'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(myPartyReqVO),
    );
    if (response.statusCode==200) {
      // 할 거 없 ?
    }else {
      throw Exception('Failed to insert my party.');
    }
    // notifyListeners();
  }

  Future deleteMyParty(int partySeq, int userSeq) async {
    MyPartyReqVO myPartyReqVO = MyPartyReqVO(
      userSeq: userSeq,
      partySeq: partySeq,
      myPartyRole: "guest"
    );
    final response = await http.delete(
      Uri.parse('http://i7e203.p.ssafy.io:9090/my-party'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(myPartyReqVO),
    );
    if (response.statusCode==200) {
      // 할 거 없 ?
    }else {
      throw Exception('Failed to delete my party.');
    }
    // notifyListeners();
  }

  Future fetchDetailParty(int partySeq) async {
    final response =  await http.get(
      Uri.parse('http://i7e203.p.ssafy.io:9090/party/${partySeq}'),
    );
    if (response.statusCode==200) {
      _currentParty = PartyResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load deteail party');
    }
  }

  Future cancelParty(int partySeq) async {
    final response = await http.delete(
      Uri.parse('http://i7e203.p.ssafy.io:9090/party/${partySeq}'),
    );
    print('[PartyModel] cancelParty() response.statusCode: ${response.statusCode}');
    if (response.statusCode==200 ){
      // 할 거 없 ?
    } else {
      throw Exception('Failed to delete party.');
    }
  }

  Future doneParty(int partySeq) async {
    final response = await http.post(
      Uri.parse('http://i7e203.p.ssafy.io:9090/party/${partySeq}'),
    );
    if (response.statusCode==200) {
      var result = jsonDecode(utf8.decode(response.bodyBytes));
      print('[PartyModel] doneParty() result: ${result}');
    } else {
      throw Exception('Failed to process party done.');
    }
    // notifyListeners();
  }

  Future fetchBookmarkPartyList(userSeq) async {
    final response = await http.get(Uri.parse('http://i7e203.p.ssafy.io:9090/bookmark/${userSeq}'));
    if (response.statusCode==200) {
      this._bookmarkPartyResVOList = (jsonDecode(utf8.decode(response.bodyBytes)) as List)
          .map((e) => PartyResVO.fromJson(e))
          .toList();
      // print('[PartyModel] fetchBookmarkPartyList() this._bookmarkPartyList: ${this._bookmarkPartyResVOList}');
    }else {
      throw Exception('Failed to load bookmark party list');
    }
    // notifyListeners();
  }

  void fetchBookmarkList(userSeq) {
    this._bookmarkList = _bookmarkPartyResVOList
        .map((e) => e.partySeq)
        .toList();
    // notifyListeners();
  }

  Future detailBookmark(BookmarkReqVO bookmarkReqVO) async {
    final response = await http.get(
        Uri.parse('http://i7e203.p.ssafy.io:9090/party/${bookmarkReqVO.partySeq}')
    );
    if (response.statusCode==200) {
      PartyResVO party = PartyResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      _currentParty = party;
    }else {
      throw Exception('Failed to load detail bookmark.');
    }
    // notifyListeners();
  }

  Future insertBookmark(BookmarkReqVO bookmarkReqVO) async {
    // print('[PartyModel] insertBookmark()');
    // print('bookmarkReqVO: ${bookmarkReqVO}');
    // print('bookmarkReqVO.toJson(): ${bookmarkReqVO.toJson()}');
    // print('jsonEncode(bookmarkReqVO): ${jsonEncode(bookmarkReqVO)}');
    final response = await http.post(
      Uri.parse('http://i7e203.p.ssafy.io:9090/bookmark'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bookmarkReqVO),
    );
    // print('response.body: ${response.body}');
    if (response.statusCode==200) {
      await fetchPartyList();
      await fetchBookmarkPartyList(bookmarkReqVO.userSeq);
      fetchBookmarkList(bookmarkReqVO.userSeq);
    } else {
      throw Exception('Failed to insert bookmark.');
    }
    // notifyListeners();
  }

  Future deleteBookmark(BookmarkReqVO bookmarkReqVO) async {
    // print('[PartyModel] deleteBookmark()');
    // print('bookmarkReqVO: ${bookmarkReqVO}');
    // print('bookmarkReqVO.toJson(): ${bookmarkReqVO.toJson()}');
    // print('jsonEncode(bookmarkReqVO): ${jsonEncode(bookmarkReqVO)}');
    final response = await http.delete(
      Uri.parse('http://i7e203.p.ssafy.io:9090/bookmark'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(bookmarkReqVO),
    );
    // print('response.body: ${response.body}');
    if (response.statusCode==200) {
      await fetchPartyList();
      await fetchBookmarkPartyList(bookmarkReqVO.userSeq);
      fetchBookmarkList(bookmarkReqVO.userSeq);
      // print('_bookmarkList: ${_bookmarkList}');
    } else {
      throw Exception('Failed to delete bookmark');
    }
    // notifyListeners();
  }

  Future afterBookmark(BookmarkReqVO bookmarkReqVO) async {
    await fetchPartyList();
    await fetchBookmarkPartyList(bookmarkReqVO.userSeq);
    fetchBookmarkList(bookmarkReqVO.userSeq);
    // notifyListeners();
  }

  Future fetchPartyPhotoList(int partySeq) async {
    final response = await http.get(
      Uri.parse('http://i7e203.p.ssafy.io:9090/photo/${partySeq}'),
    );
    if (response.statusCode==200) {
      this._partyPhotoFileUrlList = jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to load party photo list');
    }
    // notifyListeners();
  }

// Future createParty(partyReqVO,) async {
//   print('[PartyModel] createParty(partyReqVO, userSeq) called');
//   print('partyReqVO: ${partyReqVO}');
//   final response = await http.post(
//     Uri.parse('http://i7e203.p.ssafy.io:9090/party'),
//     headers: <String, String> {
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(partyReqVO),
//   );
//   print('response.statusCode: ${response.statusCode}');
//   if (response.statusCode==200) {
//     PartyResVO party = PartyResVO.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
//     _currentParty = party;
//     print('!!!!!!!!!![PartyModel] createParty() _currentParty: ${_currentParty}');
//     // print('!!!!!!!!!!this._currentParty.userResVO: ${this._currentParty!.userResVO}');
//   }else {
//     throw Exception('Failed to load detail party.');
//   }
// }
}