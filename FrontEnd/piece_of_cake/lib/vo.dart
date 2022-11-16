class MyPartyReqVO {
  int userSeq;
  int partySeq;
  String myPartyRole;
  MyPartyReqVO({
    required this.userSeq,
    required this.partySeq,
    required this.myPartyRole,
  });
  factory MyPartyReqVO.fromJson(Map<String, dynamic> json) {
    return MyPartyReqVO(
        userSeq: json['userSeq'],
        partySeq: json['partySeq'],
        myPartyRole: json['myPartyRole']);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userSeq'] = this.userSeq;
    data['partySeq'] = this.partySeq;
    data['myPartyRole'] = this.myPartyRole;
    return data;
  }
}

class ImageUploadReqVO {
  int? photoSeq;
  String fileName;
  String fileUrl;
  int partySeq;

  ImageUploadReqVO({
    this.photoSeq,
    required this.fileName,
    required this.fileUrl,
    required this.partySeq,
  });

  factory ImageUploadReqVO.fromJson(Map<String, dynamic> json) {
    return ImageUploadReqVO(
      // photoSeq: json['photoSeq'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
      partySeq: json['partySeq'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['photoSeq'] = this.photoSeq;
    data['fileName'] = this.fileName;
    data['fileUrl'] = this.fileUrl;
    data['partySeq'] = this.partySeq;
    return data;
  }
}

class ReceiptUploadReqVO {
  int? photoSeq;
  String fileName;
  String fileUrl;
  int partySeq;

  ReceiptUploadReqVO({
    this.photoSeq,
    required this.fileName,
    required this.fileUrl,
    required this.partySeq,
  });

  factory ReceiptUploadReqVO.fromJson(Map<String, dynamic> json) {
    return ReceiptUploadReqVO(
      // photoSeq: json['photoSeq'],
      fileName: json['fileName'],
      fileUrl: json['fileUrl'],
      partySeq: json['partySeq'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['photoSeq'] = this.photoSeq;
    data['fileName'] = this.fileName;
    data['fileUrl'] = this.fileUrl;
    data['partySeq'] = this.partySeq;
    return data;
  }
}

class BookmarkReqVO {
  int userSeq;
  int partySeq;

  BookmarkReqVO({
    required this.userSeq,
    required this.partySeq,
  });

  factory BookmarkReqVO.fromJson(Map<String, dynamic> json) {
    return BookmarkReqVO(
      userSeq: json['userSeq'],
      partySeq: json['partySeq'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userSeq'] = this.userSeq;
    data['partySeq'] = this.partySeq;
    return data;
  }
}

class PartyReqVO {
  int? partySeq;
  int userSeq;
  String partyCode;
  String partyTitle;
  String partyContent;
  int partyBookmarkCount;
  List<dynamic>? partyRegDt;
  List<dynamic>? partyUpdDt;
  List<dynamic>? partyRdvDt;
  String partyRdvLat;
  String partyRdvLng;
  int partyMemberNumTotal;
  int partyMemberNumCurrent;
  String partyAddr;
  String partyAddrDetail;
  int partyStatus;
  String itemLink;
  String totalAmount;
  String partyMainImageUrl;
  PartyReqVO(
      {this.partySeq,
      required this.userSeq,
      required this.partyCode,
      required this.partyTitle,
      required this.partyContent,
      required this.partyBookmarkCount,
      this.partyRegDt,
      this.partyUpdDt,
      this.partyRdvDt,
      required this.partyRdvLat,
      required this.partyRdvLng,
      required this.partyMemberNumTotal,
      required this.partyMemberNumCurrent,
      required this.partyAddr,
      required this.partyAddrDetail,
      required this.partyStatus,
      required this.itemLink,
      required this.totalAmount,
      required this.partyMainImageUrl});

  factory PartyReqVO.fromJson(Map<String, dynamic> json) {
    return PartyReqVO(
      // partySeq: json['partySeq'],
      userSeq: json['userSeq'],
      partyCode: json['partyCode'],
      partyTitle: json['partyTitle'],
      partyContent: json['partyContent'],
      partyBookmarkCount: json['partyBookmarkCount'],
      // partyRegDt: json['partyRegDt'],
      // partyUpdDt: json['partyUpdDt'],
      // partyRdvDt: json['partyRdvDt'],
      partyRdvLat: json['partyRdvLat'],
      partyRdvLng: json['partyRdvLng'],
      partyMemberNumTotal: json['partyMemberNumTotal'],
      partyMemberNumCurrent: json['partyMemberNumCurrent'],
      partyAddr: json['partyAddr'],
      partyAddrDetail: json['partyAddrDetail'],
      partyStatus: json['partyStatus'],
      itemLink: json['itemLink'],
      totalAmount: json['totalAmount'],
      partyMainImageUrl: json['partyMainImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['partySeq'] = this.partySeq;
    data['userSeq'] = this.userSeq;
    data['partyCode'] = this.partyCode;
    data['partyTitle'] = this.partyTitle;
    data['partyContent'] = this.partyContent;
    data['partyBookmarkCount'] = this.partyBookmarkCount;
    // data['partyRegDt'] = this.partyRegDt;
    // data['partyUpdDt'] = this.partyUpdDt;
    // data['partyRdvDt'] = this.partyRdvDt;
    data['partyRdvLat'] = this.partyRdvLat;
    data['partyRdvLng'] = this.partyRdvLng;
    data['partyMemberNumTotal'] = this.partyMemberNumTotal;
    data['partyMemberNumCurrent'] = this.partyMemberNumCurrent;
    data['partyAddr'] = this.partyAddr;
    data['partyAddrDetail'] = this.partyAddrDetail;
    data['partyStatus'] = this.partyStatus;
    data['itemLink'] = this.itemLink;
    data['totalAmount'] = this.totalAmount;
    data['partyMainImageUrl'] = this.partyMainImageUrl;
    return data;
  }
}

class PartyResVO {
  int partySeq;
  int userSeq;
  // UserResVO userResVO;
  String partyCode;
  String partyTitle;
  String partyContent;
  int partyBookmarkCount;
  List<dynamic> partyRegDt;
  List<dynamic> partyUpdDt;
  List<dynamic> partyRdvDt;
  String partyRdvLat;
  String partyRdvLng;
  int partyMemberNumTotal;
  int partyMemberNumCurrent;
  String partyAddr;
  String partyAddrDetail;
  int partyStatus;
  String itemLink;
  String totalAmount;
  String partyMainImageUrl;
  PartyResVO({
    required this.partySeq,
    required this.userSeq,
    // required this.userResVO,
    required this.partyCode,
    required this.partyTitle,
    required this.partyContent,
    required this.partyBookmarkCount,
    required this.partyRegDt,
    required this.partyUpdDt,
    required this.partyRdvDt,
    required this.partyRdvLat,
    required this.partyRdvLng,
    required this.partyMemberNumTotal,
    required this.partyMemberNumCurrent,
    required this.partyAddr,
    required this.partyAddrDetail,
    required this.partyStatus,
    required this.itemLink,
    required this.totalAmount,
    required this.partyMainImageUrl,
  });

  factory PartyResVO.fromJson(Map<String, dynamic> json) {
    return PartyResVO(
      partySeq: json['partySeq'],
      userSeq: json['userSeq'],
      // userResVO: UserResVO.fromJson(json['userResVO']),
      partyCode: json['partyCode'],
      partyTitle: json['partyTitle'],
      partyContent: json['partyContent'],
      partyBookmarkCount: json['partyBookmarkCount'],
      partyRegDt: json['partyRegDt'],
      partyUpdDt: json['partyUpdDt'],
      partyRdvDt: json['partyRdvDt'],
      partyRdvLat: json['partyRdvLat'],
      partyRdvLng: json['partyRdvLng'],
      partyMemberNumTotal: json['partyMemberNumTotal'],
      partyMemberNumCurrent: json['partyMemberNumCurrent'],
      partyAddr: json['partyAddr'],
      partyAddrDetail: json['partyAddrDetail'],
      partyStatus: json['partyStatus'],
      itemLink: json['itemLink'],
      totalAmount: json['totalAmount'],
      partyMainImageUrl: json['partyMainImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partySeq'] = this.partySeq;
    data['userSeq'] = this.userSeq;
    // data['userResVO'] = this.userResVO.toJson();
    data['partyCode'] = this.partyCode;
    data['partyTitle'] = this.partyTitle;
    data['partyContent'] = this.partyContent;
    data['partyBookmarkCount'] = this.partyBookmarkCount;
    data['partyRegDt'] = this.partyRegDt;
    data['partyUpdDt'] = this.partyUpdDt;
    data['partyRdvDt'] = this.partyRdvDt;
    data['partyRdvLat'] = this.partyRdvLat;
    data['partyRdvLng'] = this.partyRdvLng;
    data['partyMemberNumTotal'] = this.partyMemberNumTotal;
    data['partyMemberNumCurrent'] = this.partyMemberNumCurrent;
    data['partyAddr'] = this.partyAddr;
    data['partyAddrDetail'] = this.partyAddrDetail;
    data['partyStatus'] = this.partyStatus;
    data['itemLink'] = this.itemLink;
    data['totalAmount'] = this.totalAmount;
    data['partyMainImageUrl'] = this.partyMainImageUrl;
    return data;
  }
}

class Party {
  int partySeq;
  UserResVO userResVO;
  String partyCode;
  String partyTitle;
  String partyContent;
  int partyBookmarkCount;
  List<dynamic> partyRegDt;
  List<dynamic> partyUpdDt;
  List<dynamic> partyRdvDt;
  String partyRdvLat;
  String partyRdvLng;
  int partyMemberNumTotal;
  int partyMemberNumCurrent;
  String partyAddr;
  String partyAddrDetail;
  int partyStatus;
  String itemLink;
  String totalAmount;
  String partyMainImageUrl;
  Party({
    required this.partySeq,
    required this.userResVO,
    required this.partyCode,
    required this.partyTitle,
    required this.partyContent,
    required this.partyBookmarkCount,
    required this.partyRegDt,
    required this.partyUpdDt,
    required this.partyRdvDt,
    required this.partyRdvLat,
    required this.partyRdvLng,
    required this.partyMemberNumTotal,
    required this.partyMemberNumCurrent,
    required this.partyAddr,
    required this.partyAddrDetail,
    required this.partyStatus,
    required this.itemLink,
    required this.totalAmount,
    required this.partyMainImageUrl,
  });
  factory Party.fromJson(Map<String, dynamic> json) {
    return Party(
      partySeq: json['partySeq'],
      userResVO: json['userResVo'],
      partyCode: json['partyCode'],
      partyTitle: json['partyTitle'],
      partyContent: json['partyContent'],
      partyBookmarkCount: json['partyBookmarkCount'],
      partyRegDt: json['partyRegDt'],
      partyUpdDt: json['partyUpdDt'],
      partyRdvDt: json['partyRdvDt'],
      partyRdvLat: json['partyRdvLat'],
      partyRdvLng: json['partyRdvLng'],
      partyMemberNumTotal: json['partyMemberNumTotal'],
      partyMemberNumCurrent: json['partyMemberNumCurrent'],
      partyAddr: json['partyAddr'],
      partyAddrDetail: json['partyAddrDetail'],
      partyStatus: json['partyStatus'],
      itemLink: json['partyItemLink'],
      totalAmount: json['partyTotalAmount'],
      partyMainImageUrl: json['partyMainImageUrl'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partySeq'] = this.partySeq;
    data['userResVO'] = this.userResVO;
    data['partyCode'] = this.partyCode;
    data['partyTitle'] = this.partyTitle;
    data['partyContent'] = this.partyContent;
    data['partyBookmarkCount'] = this.partyBookmarkCount;
    data['partyRegDt'] = this.partyRegDt;
    data['partyRdvDt'] = this.partyRdvDt;
    data['partyRdvLat'] = this.partyRdvLat;
    data['partyRdvLng'] = this.partyRdvLng;
    data['partyMemberNumCurrent'] = this.partyMemberNumCurrent;
    data['partyMemberNumTotal'] = this.partyMemberNumTotal;
    data['partyAddr'] = this.partyAddr;
    data['partyAddrDetail'] = this.partyAddrDetail;
    data['partyStatus'] = this.partyStatus;
    data['itemLink'] = this.itemLink;
    data['partyMainImageUrl'] = this.partyMainImageUrl;
    return data;
  }
}

class UserReqVO {
  String userEmail;
  String userPhone;
  String userNickname;
  String userImage;
  String? userPassword;
  double userRating;
  String? userLat;
  String? userLng;
  String? userAccount;
  String? userKakaoLoginId;
  UserReqVO({
    required this.userEmail,
    required this.userPhone,
    required this.userNickname,
    required this.userImage,
    this.userPassword,
    required this.userRating,
    this.userLat,
    this.userLng,
    this.userAccount,
    this.userKakaoLoginId,
  });
  factory UserReqVO.fromJson(Map<String, dynamic> json) {
    return UserReqVO(
      userEmail: json['userEmail'],
      userPhone: json['userPhone'],
      userNickname: json['userNickname'],
      userImage: json['userImage'],
      userRating: json['userRating'],
      userKakaoLoginId: json['userKakaoLoginId']
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userEmail'] = this.userEmail;
    data['userPhone'] = this.userPhone;
    data['userNickname'] = this.userNickname;
    data['userImage'] = this.userImage;
    data['userPassword'] = this.userPassword;
    data['userRating'] = this.userRating;
    data['userLat'] = this.userLat;
    data['userLng'] = this.userLng;
    data['userAccount'] = this.userAccount;
    data['userKakaoLoginId'] = this.userKakaoLoginId;
    return data;
  }
}

class UserResVO {
  int userSeq;
  String userEmail;
  String userPhone;
  String userNickname;
  String userImage;
  String? userPassword;
  double userRating;
  String? userLat;
  String? userLng;
  String? userAccount;
  String? userKakaoLoginId;
  UserResVO({
    required this.userSeq,
    required this.userEmail,
    required this.userPhone,
    required this.userNickname,
    required this.userImage,
    this.userPassword,
    required this.userRating,
    this.userLat,
    this.userLng,
    this.userAccount,
    this.userKakaoLoginId,
  });
  factory UserResVO.fromJson(Map<String, dynamic> json) {
    return UserResVO(
      userSeq: json['userSeq'],
      userEmail: json['userEmail'],
      userPhone: json['userPhone'],
      userNickname: json['userNickname'],
      userImage: json['userImage'],
      userRating: json['userRating'],
      userKakaoLoginId: json['userKakaoLoginId'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userSeq'] = this.userSeq;
    data['userEmail'] = this.userEmail;
    data['userPhone'] = this.userPhone;
    data['userNickname'] = this.userNickname;
    data['userImage'] = this.userImage;
    data['userPassword'] = this.userPassword;
    data['userRating'] = this.userRating;
    data['userLat'] = this.userLat;
    data['userLng'] = this.userLng;
    data['userAccount'] = this.userAccount;
    data['userKakaoLoginId'] = this.userKakaoLoginId;
    return data;
  }
}

// class User {
//   int userSeq;
//   String userEmail;
//   String userPhone;
//   String userNickname;
//   String userPassword;
//   String userImage;
//   int userRating;
//   String userLat;
//   String userLng;
//   String userAccount;
//
//   User({
//     required this.userSeq,
//     required this.userEmail,
//     required this.userPhone,
//     required this.userNickname,
//     required this.userPassword,
//     required this.userImage,
//     required this.userRating,
//     required this.userLat,
//     required this.userLng,
//     required this.userAccount,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userSeq: json['userSeq'],
//       userEmail: json['userEmail'],
//       userPhone: json['userPhone'],
//       userNickname: json['userNickname'],
//       userPassword: json['userPassword'],
//       userImage: json['userImage'],
//       userRating: json['userRating'],
//       userLat: json['userLat'],
//       userLng: json['userLng'],
//       userAccount: json['userAccount'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userSeq'] = this.userSeq;
//     data['userEmail'] = this.userEmail;
//     data['userPhone'] = this.userPhone;
//     data['userNickname'] = this.userNickname;
//     data['userPassword'] = this.userPassword;
//     data['userImage'] = this.userImage;
//     data['userRating'] = this.userRating;
//     data['userLat'] = this.userLat;
//     data['userLng'] = this.userLng;
//     data['userAccount'] = this.userAccount;
//     return data;
//   }
// }

