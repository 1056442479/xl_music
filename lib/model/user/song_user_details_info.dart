// To parse this JSON data, do
//
//     final songUserDetailsModel = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/user/song_user_model.dart';

SongUserDetailsModel songUserDetailsModelFromJson(String str) => SongUserDetailsModel.fromJson(json.decode(str));

String songUserDetailsModelToJson(SongUserDetailsModel data) => json.encode(data.toJson());

class SongUserDetailsModel {
  SongUserDetailsModel({
    required this.videoCount,
      this.vipRights,
      this.identify,
      required this.artist,
    required  this.blacklist,
    required  this.preferShow,
    required  this.showPriMsg,
    required   this.secondaryExpertIdentiy,
    required  this.eventCount,
    required  this.user,
  });

  int videoCount;
  VipRights ? vipRights;
  Identify ? identify;
  Artist artist;
  bool blacklist;
  int preferShow;
  bool showPriMsg;
  List<SecondaryExpertIdentiy> secondaryExpertIdentiy;
  int ? eventCount;
  User ? user;

  factory SongUserDetailsModel.fromJson(Map<String, dynamic> json) => SongUserDetailsModel(
    videoCount:  json["videoCount"],
    vipRights: json["vipRights"]==null?null: VipRights.fromJson(json["vipRights"]),
    identify:json["identify"]==null?null:Identify.fromJson(json["identify"]),
    artist: Artist.fromJson(json["artist"]),
    blacklist: json["blacklist"] == null ? null : json["blacklist"],
    preferShow: json["preferShow"] == null ? null : json["preferShow"],
    showPriMsg: json["showPriMsg"] == null ? null : json["showPriMsg"],
    secondaryExpertIdentiy: List<SecondaryExpertIdentiy>.from(json["secondaryExpertIdentiy"].map((x) => SecondaryExpertIdentiy.fromJson(x))),
    eventCount: json["eventCount"] == null ? null : json["eventCount"],
    user: json["user"]==null?null: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "videoCount": videoCount == null ? null : videoCount,
    "vipRights": vipRights == null ? null : vipRights!.toJson(),
    "identify": identify == null ? null : identify!.toJson(),
    "artist": artist == null ? null : artist.toJson(),
    "blacklist": blacklist == null ? null : blacklist,
    "preferShow": preferShow == null ? null : preferShow,
    "showPriMsg": showPriMsg == null ? null : showPriMsg,
    "secondaryExpertIdentiy": secondaryExpertIdentiy == null ? null : List<dynamic>.from(secondaryExpertIdentiy.map((x) => x.toJson())),
    "eventCount": eventCount == null ? null : eventCount,
    "user": user == null ? null : user!.toJson(),
  };
}



class Identify {
  Identify({
      this.imageUrl,
     this.imageDesc,
    required   this.actionUrl,
  });

  String ? imageUrl;
  String ? imageDesc;
  String actionUrl;

  factory Identify.fromJson(Map<String, dynamic> json) => Identify(
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    imageDesc: json["imageDesc"] == null ? null : json["imageDesc"],
    actionUrl: json["actionUrl"] == null ? null : json["actionUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl == null ? null : imageUrl,
    "imageDesc": imageDesc == null ? null : imageDesc,
    "actionUrl": actionUrl == null ? null : actionUrl,
  };
}

class SecondaryExpertIdentiy {
  SecondaryExpertIdentiy({
    this.expertIdentiyId,
    this.expertIdentiyName,
    this.expertIdentiyCount,
  });

  int ? expertIdentiyId;
  String ? expertIdentiyName;
  int ? expertIdentiyCount;

  factory SecondaryExpertIdentiy.fromJson(Map<String, dynamic> json) => SecondaryExpertIdentiy(
    expertIdentiyId: json["expertIdentiyId"] == null ? null : json["expertIdentiyId"],
    expertIdentiyName: json["expertIdentiyName"] == null ? null : json["expertIdentiyName"],
    expertIdentiyCount: json["expertIdentiyCount"] == null ? null : json["expertIdentiyCount"],
  );

  Map<String, dynamic> toJson() => {
    "expertIdentiyId": expertIdentiyId == null ? null : expertIdentiyId,
    "expertIdentiyName": expertIdentiyName == null ? null : expertIdentiyName,
    "expertIdentiyCount": expertIdentiyCount == null ? null : expertIdentiyCount,
  };
}

class User {
  User({
    required this.backgroundUrl,
    required  this.birthday,
    required this.detailDescription,
    required this.authenticated,
    required  this.gender,
    required   this.city,
      this.signature,
    required  this.description,
    this.remarkName,
    required   this.shortUserName,
    required   this.accountStatus,
    required   this.locationStatus,
    required   this.avatarImgId,
    required   this.defaultAvatar,
    required  this.province,
    required this.nickname,
    this.expertTags,
    required  this.djStatus,
    required this.avatarUrl,
    required  this.accountType,
    required  this.authStatus,
    required  this.vipType,
    required  this.userName,
    required this.followed,
    required  this.userId,
    required this.lastLoginIp,
    required  this.lastLoginTime,
    required  this.authenticationTypes,
    required this.mutual,
    required this.createTime,
    required  this.anchor,
    this.authority,
    this.backgroundImgId,
    this.userType,
    this.experts,
    this.avatarDetail,
  });

  String backgroundUrl;
  int ? birthday;
  String detailDescription;
  bool authenticated;
  int ? gender;
  int ? city;
  String ? signature;
  String description;
  dynamic remarkName;
  String shortUserName;
  int ? accountStatus;
  int ? locationStatus;
  double avatarImgId;
  bool defaultAvatar;
  int ? province;
  String nickname;
  dynamic expertTags;
  int ? djStatus;
  String avatarUrl;
  int ? accountType;
  int ? authStatus;
  int ? vipType;
  String userName;
  bool followed;
  int ? userId;
  String lastLoginIp;
  int ? lastLoginTime;
  int ? authenticationTypes;
  bool mutual;
  int ? createTime;
  bool anchor;
  int ? authority;
  double ? backgroundImgId;
  int ? userType;
  dynamic experts;
  AvatarDetail ? avatarDetail;

  factory User.fromJson(Map<String, dynamic> json) => User(
    backgroundUrl: json["backgroundUrl"] == null ? null : json["backgroundUrl"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    detailDescription: json["detailDescription"] == null ? null : json["detailDescription"],
    authenticated: json["authenticated"] == null ? null : json["authenticated"],
    gender: json["gender"] == null ? null : json["gender"],
    city: json["city"] == null ? null : json["city"],
    signature: json["signature"] == null ? null : json["signature"],
    description: json["description"] == null ? null : json["description"],
    remarkName: json["remarkName"]==null?null: json["remarkName"],
    shortUserName: json["shortUserName"] == null ? null : json["shortUserName"],
    accountStatus: json["accountStatus"] == null ? null : json["accountStatus"],
    locationStatus: json["locationStatus"] == null ? null : json["locationStatus"],
    avatarImgId: json["avatarImgId"] == null ? null : json["avatarImgId"].toDouble(),
    defaultAvatar: json["defaultAvatar"] == null ? null : json["defaultAvatar"],
    province: json["province"] == null ? null : json["province"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    expertTags: json["expertTags"]==null?null:json["expertTags"],
    djStatus: json["djStatus"] == null ? null : json["djStatus"],
    avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    accountType: json["accountType"] == null ? null : json["accountType"],
    authStatus: json["authStatus"] == null ? null : json["authStatus"],
    vipType: json["vipType"] == null ? null : json["vipType"],
    userName: json["userName"] == null ? null : json["userName"],
    followed: json["followed"] == null ? null : json["followed"],
    userId: json["userId"] == null ? null : json["userId"],
    lastLoginIp: json["lastLoginIP"] == null ? null : json["lastLoginIP"],
    lastLoginTime: json["lastLoginTime"] == null ? null : json["lastLoginTime"],
    authenticationTypes: json["authenticationTypes"] == null ? null : json["authenticationTypes"],
    mutual: json["mutual"] == null ? null : json["mutual"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    anchor: json["anchor"] == null ? null : json["anchor"],
    authority: json["authority"] == null ? null : json["authority"],
    backgroundImgId: json["backgroundImgId"] == null ? null : json["backgroundImgId"].toDouble(),
    userType: json["userType"] == null ? null : json["userType"],
    experts: json["experts"] ==null?null:json["experts"],
    avatarDetail: json["avatarDetail"] == null ? null : AvatarDetail.fromJson(json["avatarDetail"]),
  );

  Map<String, dynamic> toJson() => {
    "backgroundUrl": backgroundUrl == null ? null : backgroundUrl,
    "birthday": birthday == null ? null : birthday,
    "detailDescription": detailDescription == null ? null : detailDescription,
    "authenticated": authenticated == null ? null : authenticated,
    "gender": gender == null ? null : gender,
    "city": city == null ? null : city,
    "signature": signature == null ? null : signature,
    "description": description == null ? null : description,
    "remarkName": remarkName==null?null:remarkName,
    "shortUserName": shortUserName == null ? null : shortUserName,
    "accountStatus": accountStatus == null ? null : accountStatus,
    "locationStatus": locationStatus == null ? null : locationStatus,
    "avatarImgId": avatarImgId == null ? null : avatarImgId,
    "defaultAvatar": defaultAvatar == null ? null : defaultAvatar,
    "province": province == null ? null : province,
    "nickname": nickname == null ? null : nickname,
    "expertTags": expertTags==null? null:expertTags,
    "djStatus": djStatus == null ? null : djStatus,
    "avatarUrl": avatarUrl == null ? null : avatarUrl,
    "accountType": accountType == null ? null : accountType,
    "authStatus": authStatus == null ? null : authStatus,
    "vipType": vipType == null ? null : vipType,
    "userName": userName == null ? null : userName,
    "followed": followed == null ? null : followed,
    "userId": userId == null ? null : userId,
    "lastLoginIP": lastLoginIp == null ? null : lastLoginIp,
    "lastLoginTime": lastLoginTime == null ? null : lastLoginTime,
    "authenticationTypes": authenticationTypes == null ? null : authenticationTypes,
    "mutual": mutual == null ? null : mutual,
    "createTime": createTime == null ? null : createTime,
    "anchor": anchor == null ? null : anchor,
    "authority": authority == null ? null : authority,
    "backgroundImgId": backgroundImgId == null ? null : backgroundImgId,
    "userType": userType == null ? null : userType,
    "experts": experts ==null?null:experts,
    "avatarDetail": avatarDetail == null ? null : avatarDetail!.toJson(),
  };
}

class AvatarDetail {
  AvatarDetail({
    this.userType,
    this.identityLevel,
    this.identityIconUrl,
  });

  int ? userType;
  int ? identityLevel;
  String ? identityIconUrl;

  factory AvatarDetail.fromJson(Map<String, dynamic> json) => AvatarDetail(
    userType: json["userType"] == null ? null : json["userType"],
    identityLevel: json["identityLevel"] == null ? null : json["identityLevel"],
    identityIconUrl: json["identityIconUrl"] == null ? null : json["identityIconUrl"],
  );

  Map<String, dynamic> toJson() => {
    "userType": userType == null ? null : userType,
    "identityLevel": identityLevel == null ? null : identityLevel,
    "identityIconUrl": identityIconUrl == null ? null : identityIconUrl,
  };
}

class VipRights {
  VipRights({
    this.rightsInfoDetailDtoList,
    this.oldProtocol,
    this.redVipAnnualCount,
    this.redVipLevel,
    this.now,
  });

  List<RightsInfoDetailDtoList> ? rightsInfoDetailDtoList;
  bool ? oldProtocol;
  int ? redVipAnnualCount;
  int ? redVipLevel;
  int ? now;

  factory VipRights.fromJson(Map<String, dynamic> json) => VipRights(
    rightsInfoDetailDtoList: json["rightsInfoDetailDtoList"] == null ? null : List<RightsInfoDetailDtoList>.from(json["rightsInfoDetailDtoList"].map((x) => RightsInfoDetailDtoList.fromJson(x))),
    oldProtocol: json["oldProtocol"] == null ? null : json["oldProtocol"],
    redVipAnnualCount: json["redVipAnnualCount"] == null ? null : json["redVipAnnualCount"],
    redVipLevel: json["redVipLevel"] == null ? null : json["redVipLevel"],
    now: json["now"] == null ? null : json["now"],
  );

  Map<String, dynamic> toJson() => {
    "rightsInfoDetailDtoList": rightsInfoDetailDtoList == null ? null : List<dynamic>.from(rightsInfoDetailDtoList!.map((x) => x.toJson())),
    "oldProtocol": oldProtocol == null ? null : oldProtocol,
    "redVipAnnualCount": redVipAnnualCount == null ? null : redVipAnnualCount,
    "redVipLevel": redVipLevel == null ? null : redVipLevel,
    "now": now == null ? null : now,
  };
}

class RightsInfoDetailDtoList {
  RightsInfoDetailDtoList({
    this.vipCode,
    this.expireTime,
    this.iconUrl,
    this.dynamicIconUrl,
    this.vipLevel,
    this.signIap,
    this.sign,
    this.signIapDeduct,
    this.signDeduct,
  });

  int ? vipCode;
  int ? expireTime;
  dynamic iconUrl;
  dynamic dynamicIconUrl;
  int ? vipLevel;
  bool ? signIap;
  bool ? sign;
  bool ? signIapDeduct;
  bool ? signDeduct;

  factory RightsInfoDetailDtoList.fromJson(Map<String, dynamic> json) => RightsInfoDetailDtoList(
    vipCode: json["vipCode"] == null ? null : json["vipCode"],
    expireTime: json["expireTime"] == null ? null : json["expireTime"],
    iconUrl: json["iconUrl"]==null?null:json["iconUrl"],
    dynamicIconUrl: json["dynamicIconUrl"]==null?null:json["dynamicIconUrl"],
    vipLevel: json["vipLevel"] == null ? null : json["vipLevel"],
    signIap: json["signIap"] == null ? null : json["signIap"],
    sign: json["sign"] == null ? null : json["sign"],
    signIapDeduct: json["signIapDeduct"] == null ? null : json["signIapDeduct"],
    signDeduct: json["signDeduct"] == null ? null : json["signDeduct"],
  );

  Map<String, dynamic> toJson() => {
    "vipCode": vipCode == null ? null : vipCode,
    "expireTime": expireTime == null ? null : expireTime,
    "iconUrl": iconUrl ==null?null:iconUrl,
    "dynamicIconUrl": dynamicIconUrl,
    "vipLevel": vipLevel == null ? null : vipLevel,
    "signIap": signIap == null ? null : signIap,
    "sign": sign == null ? null : sign,
    "signIapDeduct": signIapDeduct == null ? null : signIapDeduct,
    "signDeduct": signDeduct == null ? null : signDeduct,
  };
}
