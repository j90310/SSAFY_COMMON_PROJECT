import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:piece_of_cake/main.dart';
import 'package:piece_of_cake/models/kakao_login_model.dart';
import 'package:piece_of_cake/vo.dart';
import 'package:piece_of_cake/widgets/image_upload_widget.dart';
import 'package:piece_of_cake/widgets/map_setting.dart';
import 'package:provider/provider.dart';
// import 'package:piece_of_cake/widgets/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// GlobalKey<_ImageUploadState> globalKey = GlobalKey();
// GlobalKey<_MapSettingState> mapKey = GlobalKey();
GlobalKey<_DlvModifyState> dlvModifyKey = GlobalKey();

class ReturnValue {
  String? result;
  ReturnValue({this.result});
}

class Arguments {
  LatLng center;
  ReturnValue? returnValue;
  Arguments({this.center: const LatLng(0.0, 0.0), this.returnValue});
}

class DlvModify extends StatefulWidget {
  final Party party;
  const DlvModify({Key? key, required this.party}) : super(key: key);

  @override
  State<DlvModify> createState() => _DlvModifyState();
}

class _DlvModifyState extends State<DlvModify> {
  final formKey = GlobalKey<FormState>();
  String? itemLink = '';
  String? name = '';
  String? content = '';
  String? totalAmount = '';
  int memberNumTotal = 2;
  int? memberNumCurrent = 1;
  String? addr = '';
  String? addrDetail = '';

  createParty(var kakaoUserProvider) {
    insertParty(kakaoUserProvider);
  }

  // setValue() {
  //   this.itemLink = widget.party.itemLink;
  //   this.name = widget.party.partyTitle;
  //   this.content = widget.party.partyContent;
  //   this.totalAmount = widget.party.totalAmount;
  //   this.memberNumTotal = widget.party.partyMemberNumTotal;
  //   this.memberNumCurrent = widget.party.partyMemberNumCurrent;
  //   this.addr = widget.party.partyAddr;
  //   this.addrDetail = widget.party.partyAddrDetail;
  // }

  Future insertParty(var kakaoUserProvider) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }
    PartyResVO partyResVO = PartyResVO(
        partyRdvDt: widget.party.partyRdvDt,
        partyRegDt: widget.party.partyRegDt,
        partyUpdDt: widget.party.partyUpdDt,
        partySeq: widget.party.partySeq,
        itemLink: this.itemLink == '' ? widget.party.itemLink : this.itemLink!,
        partyAddr: this.addr!,
        partyAddrDetail: this.addrDetail!,
        partyStatus: 1,
        partyBookmarkCount: 0,
        partyCode: '003',
        partyContent:
            this.content == '' ? widget.party.partyContent : this.content!,
        partyMemberNumCurrent: memberNumCurrent!,
        partyMemberNumTotal: widget.party.partyMemberNumTotal,
        partyRdvLat: this._center.latitude.toString(),
        partyRdvLng: this._center.longitude.toString(),
        partyTitle: this.name == '' ? widget.party.partyTitle : this.name!,
        totalAmount: this.totalAmount == ''
            ? widget.party.totalAmount
            : this.totalAmount!,
        partyMainImageUrl: widget.party.partyMainImageUrl,
        userSeq: kakaoUserProvider.userResVO!.userSeq);

    // print(partyResVO.itemLink);
    // print(partyResVO.partyTitle);
    // print(partyResVO.totalAmount);
    // print(partyResVO.partyMemberNumTotal);
    // print(partyResVO.partyContent);
    final response = await http.patch(
      Uri.parse('http://i7e203.p.ssafy.io:9090/party/${widget.party.partySeq}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(partyResVO),
    );
    print('response.body: ${response.body}');
    //print(Party.fromJson(jsonDecode(utf8.decode(response.bodyBytes))));
    // print(response.body.substring(response.body.indexOf("partySeq") + 10, response.body.indexOf("userSeq") - 2));
    // int partySeq = int.parse(response.body.substring(
    //     response.body.indexOf("partySeq") + 10,
    //     response.body.indexOf("userSeq") - 2));
    // imageKey.currentState?.addImage(partySeq);
  }

  // late GoogleMapController mapController;

  LatLng _center = LatLng(45.521563, -122.677433);

  String Rdv_Address = '주소 적힐곳';

  List<Marker> _markers = [];

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  // int setRdvValue(LatLng center) {
  //   this._center = center;
  //   print(center);
  //   return 1;
  // }

  void _setRdvPoint(BuildContext context, LatLng center) async {
    print('testRdv');
    _center = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapSetting()),
    );
    //setState(() {});
    var Lat = _center.latitude;
    var Lng = _center.longitude;
    // _center = LatLng(Lat, Lng);
    final Uri getAddress = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$Lat,$Lng&key=AIzaSyBdf3QkB2KbMDzdfPXYxoBBfyFSk_fxBqk&language=ko');
    final response = await http.get(getAddress);
    Rdv_Address = jsonDecode(response.body)['results'][0]['formatted_address'];
    List<String> splitAddr = Rdv_Address.split(' ');
    addrDetail = splitAddr[splitAddr.length - 1];
    splitAddr.removeAt(0);
    String address = '';
    for (int i = 0; i < splitAddr.length; i++) {
      address += '${splitAddr[i]}';
      if (i != splitAddr.length - 1) address += ' ';
    }
    ;
    addr = address;
    // mapController.animateCamera(CameraUpdate.newCameraPosition(
    //     CameraPosition(target: _center, zoom: 15.0)));
    // _markers = [];
    // _markers.add(Marker(markerId: MarkerId("1"), position: _center));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final kakaoUserProvider =
        Provider.of<KakaoLoginModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('DlvModify'),
        actions: [
          IconButton(
              onPressed: () {
                createParty(kakaoUserProvider);
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.amber),
                          borderRadius: BorderRadius.circular((15))),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                          onSaved: (val) {
                            setState(() {
                              itemLink = val as String;
                            });
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              itemLink = val as String;
                              return "배달업체링크";
                            }
                            itemLink = val as String;
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.amber),
                          borderRadius: BorderRadius.circular((15))),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                          onSaved: (val) {
                            setState(() {
                              name = val as String;
                            });
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              name = val as String;
                              return "제목";
                            }
                            name = val as String;
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.amber),
                          borderRadius: BorderRadius.circular((15))),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '',
                            suffixText: '원',
                          ),
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 20),
                          onSaved: (val) {
                            setState(() {
                              totalAmount = val as String;
                            });
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              totalAmount = val as String;
                              return "총 금액";
                            }
                            totalAmount = val as String;
                            return null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.amber),
                          borderRadius: BorderRadius.circular((15))),
                      child: SizedBox(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.always,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '',
                            ),
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 20),
                            onSaved: (val) {
                              setState(() {
                                content = val as String;
                              });
                            },
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                content = val as String;
                                return "내용";
                              }
                              content = val as String;
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.amber),
                borderRadius: BorderRadius.circular((15))),
            // height: 40,
            child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.party.partyAddr,
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.amber),
                borderRadius: BorderRadius.circular((15))),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                child: Text('랑데뷰 포인트 설정'),
                onPressed: () {
                  _setRdvPoint(context, _center);
                },
              ),
            ),
          ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          //   child: Wrap(children: [
          //     SizedBox(
          //       width: 200,
          //       height: 200,
          //       child: GoogleMap(
          //         markers: Set.from(_markers),
          //         myLocationEnabled: true,
          //         myLocationButtonEnabled: false,
          //         mapType: MapType.normal,
          //         onMapCreated: _onMapCreated,
          //         initialCameraPosition: CameraPosition(
          //           target: _center,
          //           zoom: 11.0,
          //         ),
          //       ),
          //     ),
          //   ]),
          // ),
        ],
      ),
    );
  }
}
