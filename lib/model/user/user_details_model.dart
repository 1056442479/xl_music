// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserDetails userDetailsFromJson(String str) => UserDetails.fromJson(json.decode(str));

String userDetailsToJson(UserDetails data) => json.encode(data.toJson());

class UserDetails {
  UserDetails({
     this.identify,
    required this.level,
    required this.listenSongs,
    required this.userPoint,
    required this.mobileSign,
    required this.pcSign,
    required this.profile,
    required this.peopleCanSeeMyPlayRecord,
    required this.bindings,
    required this.adValid,
    required this.code,
    required this.newUser,
    required this.recallUser,
    required this.createTime,
    required this.createDays,
     this.profileVillageInfo,
  });

  Identify ? identify;
  int level;
  int listenSongs;
  UserPoint userPoint;
  bool mobileSign;
  bool pcSign;
  Profile profile;
  bool peopleCanSeeMyPlayRecord;
  List<Binding> bindings;
  bool adValid;
  int code;
  bool newUser;
  bool recallUser;
  int createTime;
  int createDays;
  ProfileVillageInfo ? profileVillageInfo;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
    identify: json["identify"] == null ? null : Identify.fromJson(json["identify"]),
    level: json["level"] == null ? null : json["level"],
    listenSongs: json["listenSongs"] == null ? null : json["listenSongs"],
    userPoint: UserPoint.fromJson(json["userPoint"]),
    mobileSign: json["mobileSign"] == null ? null : json["mobileSign"],
    pcSign: json["pcSign"] == null ? null : json["pcSign"],
    profile: Profile.fromJson(json["profile"]),
    peopleCanSeeMyPlayRecord: json["peopleCanSeeMyPlayRecord"] == null ? null : json["peopleCanSeeMyPlayRecord"],
    bindings:  List<Binding>.from(json["bindings"].map((x) => Binding.fromJson(x))),
    adValid: json["adValid"] == null ? null : json["adValid"],
    code: json["code"] == null ? null : json["code"],
    newUser: json["newUser"] == null ? null : json["newUser"],
    recallUser: json["recallUser"] == null ? null : json["recallUser"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    createDays: json["createDays"] == null ? null : json["createDays"],
    profileVillageInfo:json["profileVillageInfo"]==null?null: ProfileVillageInfo.fromJson(json["profileVillageInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "identify": identify == null ? null : identify!.toJson(),
    "level": level == null ? null : level,
    "listenSongs": listenSongs == null ? null : listenSongs,
    "userPoint": userPoint == null ? null : userPoint.toJson(),
    "mobileSign": mobileSign == null ? null : mobileSign,
    "pcSign": pcSign == null ? null : pcSign,
    "profile": profile == null ? null : profile.toJson(),
    "peopleCanSeeMyPlayRecord": peopleCanSeeMyPlayRecord == null ? null : peopleCanSeeMyPlayRecord,
    "bindings": bindings == null ? null : List<dynamic>.from(bindings.map((x) => x.toJson())),
    "adValid": adValid == null ? null : adValid,
    "code": code == null ? null : code,
    "newUser": newUser == null ? null : newUser,
    "recallUser": recallUser == null ? null : recallUser,
    "createTime": createTime == null ? null : createTime,
    "createDays": createDays == null ? null : createDays,
    "profileVillageInfo": profileVillageInfo == null ? null : profileVillageInfo!.toJson(),
  };
}

class Binding {
  Binding({
    required this.refreshTime,
    required this.tokenJsonStr,
    required this.expiresIn,
    required this.bindingTime,
    required this.expired,
    required this.url,
    required this.userId,
    required this.id,
    required this.type,
  });

  int refreshTime;
  dynamic tokenJsonStr;
  int expiresIn;
  int bindingTime;
  bool expired;
  String url;
  int userId;
  int id;
  int type;

  factory Binding.fromJson(Map<String, dynamic> json) => Binding(
    refreshTime: json["refreshTime"] == null ? null : json["refreshTime"],
    tokenJsonStr: json["tokenJsonStr"],
    expiresIn: json["expiresIn"] == null ? null : json["expiresIn"],
    bindingTime: json["bindingTime"] == null ? null : json["bindingTime"],
    expired: json["expired"] == null ? null : json["expired"],
    url: json["url"] == null ? null : json["url"],
    userId: json["userId"] == null ? null : json["userId"],
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "refreshTime": refreshTime == null ? null : refreshTime,
    "tokenJsonStr": tokenJsonStr,
    "expiresIn": expiresIn == null ? null : expiresIn,
    "bindingTime": bindingTime == null ? null : bindingTime,
    "expired": expired == null ? null : expired,
    "url": url == null ? null : url,
    "userId": userId == null ? null : userId,
    "id": id == null ? null : id,
    "type": type == null ? null : type,
  };
}

class Identify {
  Identify({
    this.imageUrl,
     this.imageDesc,
    required this.actionUrl,
  });

  String ? imageUrl;
  String ? imageDesc;
  dynamic actionUrl;

  factory Identify.fromJson(Map<String, dynamic> json) => Identify(
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    imageDesc: json["imageDesc"] == null ? null : json["imageDesc"],
    actionUrl: json["actionUrl"],
  );

  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl == null ? null : imageUrl,
    "imageDesc": imageDesc == null ? null : imageDesc,
    "actionUrl": actionUrl,
  };
}

class Profile {
  Profile({
    required this.privacyItemUnlimit,
     this.avatarDetail,
    required this.avatarImgIdStr,
    required this.backgroundImgIdStr,
    required this.mutual,
     this.remarkName,
    required this.birthday,
    required this.nickname,
    required this.avatarImgId,
    required this.gender,
    required this.vipType,
    required this.userType,
    required this.createTime,
    required this.avatarUrl,
    required this.followed,
    required this.authStatus,
    required this.detailDescription,
//     this.experts,
     this.expertTags,
    required this.djStatus,
    required this.accountStatus,
    required this.province,
    required this.city,
    required this.defaultAvatar,
    required this.backgroundImgId,
    required this.backgroundUrl,
    required this.description,
    required this.userId,
    required this.signature,
    required this.authority,
     this.allAuthTypes,
    required this.followeds,
    required this.follows,
    required this.blacklist,
     this.artistId,
    required this.eventCount,
    required this.allSubscribedCount,
    required this.playlistBeSubscribedCount,
     this.mainAuthType,
     this.profileAvatarImgIdStr,
     this.followTime,
    required this.followMe,
    required this.artistIdentity,
    required this.cCount,
    required this.inBlacklist,
    required this.sDjpCount,
     this.artistName,
    required this.playlistCount,
    required this.sCount,
    required this.newFollows,
  });

  PrivacyItemUnlimit privacyItemUnlimit;
  AvatarDetail ? avatarDetail;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  bool mutual;
  dynamic remarkName;
  int birthday;
  String nickname;
  double avatarImgId;
  int gender;
  int vipType;
  int userType;
  int createTime;
  String avatarUrl;
  bool followed;
  int authStatus;
  String detailDescription;
//  Experts ? experts;
  dynamic expertTags;
  int djStatus;
  int accountStatus;
  int province;
  int city;
  bool defaultAvatar;
  double backgroundImgId;
  String backgroundUrl;
  String description;
  int userId;
  String signature;
  int authority;
  List<AuthType> ? allAuthTypes;
  int followeds;
  int follows;
  bool blacklist;
  int ? artistId;
  int eventCount;
  int allSubscribedCount;
  int playlistBeSubscribedCount;
  AuthType ? mainAuthType;
  String ? profileAvatarImgIdStr;
  dynamic followTime;
  bool followMe;
  List<dynamic> artistIdentity;
  int cCount;
  bool inBlacklist;
  int sDjpCount;
  String ? artistName;
  int playlistCount;
  int sCount;
  int newFollows;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    privacyItemUnlimit:  PrivacyItemUnlimit.fromJson(json["privacyItemUnlimit"]),
    avatarDetail: json["avatarDetail"]==null?null: AvatarDetail.fromJson(json["avatarDetail"]),
    avatarImgIdStr: json["avatarImgIdStr"] == null ? null : json["avatarImgIdStr"],
    backgroundImgIdStr: json["backgroundImgIdStr"] == null ? null : json["backgroundImgIdStr"],
    mutual: json["mutual"] == null ? null : json["mutual"],
    remarkName: json["remarkName"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    avatarImgId: json["avatarImgId"] == null ? null : json["avatarImgId"].toDouble(),
    gender: json["gender"] == null ? null : json["gender"],
    vipType: json["vipType"] == null ? null : json["vipType"],
    userType: json["userType"] == null ? null : json["userType"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    followed: json["followed"] == null ? null : json["followed"],
    authStatus: json["authStatus"] == null ? null : json["authStatus"],
    detailDescription: json["detailDescription"] == null ? null : json["detailDescription"],
//    experts:  Experts.fromJson(json["experts"]),
    expertTags: json["expertTags"],
    djStatus: json["djStatus"] == null ? null : json["djStatus"],
    accountStatus: json["accountStatus"] == null ? null : json["accountStatus"],
    province: json["province"] == null ? null : json["province"],
    city: json["city"] == null ? null : json["city"],
    defaultAvatar: json["defaultAvatar"] == null ? null : json["defaultAvatar"],
    backgroundImgId: json["backgroundImgId"] == null ? null : json["backgroundImgId"].toDouble(),
    backgroundUrl: json["backgroundUrl"] == null ? null : json["backgroundUrl"],
    description: json["description"] == null ? null : json["description"],
    userId: json["userId"] == null ? null : json["userId"],
    signature: json["signature"] == null ? null : json["signature"],
    authority: json["authority"] == null ? null : json["authority"],
    allAuthTypes:json["allAuthTypes"]==null?null: List<AuthType>.from(json["allAuthTypes"].map((x) => AuthType.fromJson(x))),
    followeds: json["followeds"] == null ? null : json["followeds"],
    follows: json["follows"] == null ? null : json["follows"],
    blacklist: json["blacklist"] == null ? null : json["blacklist"],
    artistId: json["artistId"] == null ? null : json["artistId"],
    eventCount: json["eventCount"] == null ? null : json["eventCount"],
    allSubscribedCount: json["allSubscribedCount"] == null ? null : json["allSubscribedCount"],
    playlistBeSubscribedCount: json["playlistBeSubscribedCount"] == null ? null : json["playlistBeSubscribedCount"],
    mainAuthType:json["mainAuthType"]==null?null:  AuthType.fromJson(json["mainAuthType"]),
    profileAvatarImgIdStr: json["avatarImgId_str"] == null ? null : json["avatarImgId_str"],
    followTime: json["followTime"],
    followMe: json["followMe"] == null ? null : json["followMe"],
    artistIdentity: List<int>.from(json["artistIdentity"].map((x) => x)),
    cCount: json["cCount"] == null ? null : json["cCount"],
    inBlacklist: json["inBlacklist"] == null ? null : json["inBlacklist"],
    sDjpCount: json["sDJPCount"] == null ? null : json["sDJPCount"],
    artistName: json["artistName"] == null ? null : json["artistName"],
    playlistCount: json["playlistCount"] == null ? null : json["playlistCount"],
    sCount: json["sCount"] == null ? null : json["sCount"],
    newFollows: json["newFollows"] == null ? null : json["newFollows"],
  );

  Map<String, dynamic> toJson() => {
    "privacyItemUnlimit": privacyItemUnlimit == null ? null : privacyItemUnlimit.toJson(),
    "avatarDetail": avatarDetail == null ? null : avatarDetail!.toJson(),
    "avatarImgIdStr": avatarImgIdStr == null ? null : avatarImgIdStr,
    "backgroundImgIdStr": backgroundImgIdStr == null ? null : backgroundImgIdStr,
    "mutual": mutual == null ? null : mutual,
    "remarkName": remarkName,
    "birthday": birthday == null ? null : birthday,
    "nickname": nickname == null ? null : nickname,
    "avatarImgId": avatarImgId == null ? null : avatarImgId,
    "gender": gender == null ? null : gender,
    "vipType": vipType == null ? null : vipType,
    "userType": userType == null ? null : userType,
    "createTime": createTime == null ? null : createTime,
    "avatarUrl": avatarUrl == null ? null : avatarUrl,
    "followed": followed == null ? null : followed,
    "authStatus": authStatus == null ? null : authStatus,
    "detailDescription": detailDescription == null ? null : detailDescription,
//    "experts": experts == null ? null : experts.toJson(),
    "expertTags": expertTags==null?null:expertTags,
    "djStatus": djStatus == null ? null : djStatus,
    "accountStatus": accountStatus == null ? null : accountStatus,
    "province": province == null ? null : province,
    "city": city == null ? null : city,
    "defaultAvatar": defaultAvatar == null ? null : defaultAvatar,
    "backgroundImgId": backgroundImgId == null ? null : backgroundImgId,
    "backgroundUrl": backgroundUrl == null ? null : backgroundUrl,
    "description": description == null ? null : description,
    "userId": userId == null ? null : userId,
    "signature": signature == null ? null : signature,
    "authority": authority == null ? null : authority,
    "allAuthTypes": allAuthTypes == null ? null : List<dynamic>.from(allAuthTypes!.map((x) => x.toJson())),
    "followeds": followeds == null ? null : followeds,
    "follows": follows == null ? null : follows,
    "blacklist": blacklist == null ? null : blacklist,
    "artistId": artistId == null ? null : artistId,
    "eventCount": eventCount == null ? null : eventCount,
    "allSubscribedCount": allSubscribedCount == null ? null : allSubscribedCount,
    "playlistBeSubscribedCount": playlistBeSubscribedCount == null ? null : playlistBeSubscribedCount,
    "mainAuthType": mainAuthType == null ? null : mainAuthType!.toJson(),
    "avatarImgId_str": profileAvatarImgIdStr == null ? null : profileAvatarImgIdStr,
    "followTime": followTime,
    "followMe": followMe == null ? null : followMe,
    "artistIdentity": artistIdentity == null ? null : List<dynamic>.from(artistIdentity.map((x) => x)),
    "cCount": cCount == null ? null : cCount,
    "inBlacklist": inBlacklist == null ? null : inBlacklist,
    "sDJPCount": sDjpCount == null ? null : sDjpCount,
    "artistName": artistName == null ? null : artistName,
    "playlistCount": playlistCount == null ? null : playlistCount,
    "sCount": sCount == null ? null : sCount,
    "newFollows": newFollows == null ? null : newFollows,
  };
}

class AuthType {
  AuthType({
    required this.type,
    required this.desc,
     this.tags,
  });

  int type;
  String desc;
  List<String> ? tags;

  factory AuthType.fromJson(Map<String, dynamic> json) => AuthType(
    type: json["type"] == null ? null : json["type"],
    desc: json["desc"] == null ? null : json["desc"],
    tags: json["tags"]==null?null: List<String>.from(json["tags"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "desc": desc == null ? null : desc,
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
  };
}

class AvatarDetail {
  AvatarDetail({
    required this.userType,
    required this.identityLevel,
    required this.identityIconUrl,
  });

  dynamic userType;
  int identityLevel;
  String identityIconUrl;

  factory AvatarDetail.fromJson(Map<String, dynamic> json) => AvatarDetail(
    userType: json["userType"],
    identityLevel: json["identityLevel"] == null ? null : json["identityLevel"],
    identityIconUrl: json["identityIconUrl"] == null ? null : json["identityIconUrl"],
  );

  Map<String, dynamic> toJson() => {
    "userType": userType,
    "identityLevel": identityLevel == null ? null : identityLevel,
    "identityIconUrl": identityIconUrl == null ? null : identityIconUrl,
  };
}

class Experts {
  Experts();

  factory Experts.fromJson(Map<String, dynamic> json) => Experts(
  );

  Map<String, dynamic> toJson() => {
  };
}

class PrivacyItemUnlimit {
  PrivacyItemUnlimit({
    required this.area,
    required this.college,
    required this.gender,
    required this.age,
    required this.villageAge,
  });

  bool area;
  bool college;
  bool gender;
  bool age;
  bool villageAge;

  factory PrivacyItemUnlimit.fromJson(Map<String, dynamic> json) => PrivacyItemUnlimit(
    area: json["area"] == null ? null : json["area"],
    college: json["college"] == null ? null : json["college"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    villageAge: json["villageAge"] == null ? null : json["villageAge"],
  );

  Map<String, dynamic> toJson() => {
    "area": area == null ? null : area,
    "college": college == null ? null : college,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "villageAge": villageAge == null ? null : villageAge,
  };
}

class ProfileVillageInfo {
  ProfileVillageInfo({
    required this.title,
    required this.imageUrl,
    required this.targetUrl,
  });

  String title;
  String imageUrl;
  String targetUrl;

  factory ProfileVillageInfo.fromJson(Map<String, dynamic> json) => ProfileVillageInfo(
    title: json["title"] == null ? null : json["title"],
    imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
    targetUrl: json["targetUrl"] == null ? null : json["targetUrl"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "imageUrl": imageUrl == null ? null : imageUrl,
    "targetUrl": targetUrl == null ? null : targetUrl,
  };
}

class UserPoint {
  UserPoint({
    required this.userId,
    required this.balance,
    required this.updateTime,
    required this.version,
    required this.status,
    required this.blockBalance,
  });

  int userId;
  int balance;
  int updateTime;
  int version;
  int status;
  int blockBalance;

  factory UserPoint.fromJson(Map<String, dynamic> json) => UserPoint(
    userId: json["userId"] == null ? null : json["userId"],
    balance: json["balance"] == null ? null : json["balance"],
    updateTime: json["updateTime"] == null ? null : json["updateTime"],
    version: json["version"] == null ? null : json["version"],
    status: json["status"] == null ? null : json["status"],
    blockBalance: json["blockBalance"] == null ? null : json["blockBalance"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId == null ? null : userId,
    "balance": balance == null ? null : balance,
    "updateTime": updateTime == null ? null : updateTime,
    "version": version == null ? null : version,
    "status": status == null ? null : status,
    "blockBalance": blockBalance == null ? null : blockBalance,
  };
}
