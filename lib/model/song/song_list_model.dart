
// To parse this JSON data, do

import 'dart:convert';

SongListModel songListFromJson(String str) => SongListModel.fromJson(json.decode(str));

String songListToJson(SongListModel data) => json.encode(data.toJson());

///每日歌单实体类
class SongListModel {
  SongListModel({
    required this.code,
    required this.featureFirst,
    required  this.haveRcmdSongs,
    required this.recommend,
  });

  int code;
  bool ? featureFirst;
  bool ? haveRcmdSongs;
  List<RecommendModel> recommend;

  factory SongListModel.fromJson(Map<String, dynamic> json) => SongListModel(
    code: json["code"],
    featureFirst: json["featureFirst"],
    haveRcmdSongs: json["haveRcmdSongs"],
    recommend: List<RecommendModel>.from(json["recommend"].map((x) => RecommendModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "featureFirst": featureFirst,
    "haveRcmdSongs": haveRcmdSongs,
    "recommend": List<dynamic>.from(recommend.map((x) => x.toJson())),
  };
}

class RecommendModel {
  RecommendModel({
    required this.id,
    required  this.type,
    required  this.name,
    required  this.copywriter,
    required  this.picUrl,
    required  this.playcount,
    required  this.createTime,
    required  this.creator,
    required  this.trackCount,
    required this.userId,
    required this.alg,
  });

  int id;
  int type;
  String name;
  String copywriter;
  String picUrl;
  int playcount;
  int createTime;
  Creator creator;
  int trackCount;
  int userId;
  String alg;

  factory RecommendModel.fromJson(Map<String, dynamic> json) => RecommendModel(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    copywriter: json["copywriter"],
    picUrl: json["picUrl"],
    playcount: json["playcount"],
    createTime: json["createTime"],
    creator: Creator.fromJson(json["creator"]),
    trackCount: json["trackCount"],
    userId: json["userId"],
    alg: json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "name": name,
    "copywriter": copywriter,
    "picUrl": picUrl,
    "playcount": playcount,
    "createTime": createTime,
    "creator": creator.toJson(),
    "trackCount": trackCount,
    "userId": userId,
    "alg": alg,
  };
}

class Creator {
  Creator({
    this.remarkName,
    required  this.mutual,
    required  this.avatarImgId,
    required  this.backgroundImgId,
      this.avatarImgIdStr,
      this.detailDescription,
    required  this.defaultAvatar,
    required this.expertTags,
    required  this.djStatus,
    required  this.followed,
    required  this.backgroundUrl,
     this.backgroundImgIdStr,
    required  this.userId,
    required this.accountStatus,
    required  this.vipType,
    required this.province,
    required this.avatarUrl,
    required this.authStatus,
    required this.userType,
    required this.nickname,
    required  this.gender,
    required this.birthday,
    required  this.city,
    required this.description,
    required this.signature,
    required this.authority,
  });

  dynamic remarkName;
  bool mutual;
  double avatarImgId;
  double backgroundImgId;
  String ? avatarImgIdStr;
  String ? detailDescription;
  bool defaultAvatar;
  dynamic expertTags;
  int djStatus;
  bool followed;
  String ? backgroundUrl;
  String ? backgroundImgIdStr;
  int userId;
  int accountStatus;
  int vipType;
  int province;
  String avatarUrl;
  int authStatus;
  int userType;
  String nickname;
  int gender;
  int birthday;
  int city;
  String description;
  String signature;
  int authority;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    remarkName: json["remarkName"],
    mutual: json["mutual"],
    avatarImgId: json["avatarImgId"].toDouble(),
    backgroundImgId: json["backgroundImgId"].toDouble(),
    avatarImgIdStr: json["avatarImgIdStr"] ?? "",
    detailDescription: json["detailDescription"],
    defaultAvatar: json["defaultAvatar"],
    expertTags: json["expertTags"],
    djStatus: json["djStatus"],
    followed: json["followed"],
    backgroundUrl: json["backgroundUrl"],
    backgroundImgIdStr: json["backgroundImgIdStr"],
    userId: json["userId"],
    accountStatus: json["accountStatus"],
    vipType: json["vipType"],
    province: json["province"],
    avatarUrl: json["avatarUrl"],
    authStatus: json["authStatus"],
    userType: json["userType"],
    nickname: json["nickname"],
    gender: json["gender"],
    birthday: json["birthday"],
    city: json["city"],
    description: json["description"],
    signature: json["signature"],
    authority: json["authority"],
  );

  Map<String, dynamic> toJson() => {
    "remarkName": remarkName,
    "mutual": mutual,
    "avatarImgId": avatarImgId,
    "backgroundImgId": backgroundImgId,
    "avatarImgIdStr": avatarImgIdStr,
    "detailDescription": detailDescription,
    "defaultAvatar": defaultAvatar,
    "expertTags": expertTags,
    "djStatus": djStatus,
    "followed": followed,
    "backgroundUrl": backgroundUrl,
    "backgroundImgIdStr": backgroundImgIdStr,
    "userId": userId,
    "accountStatus": accountStatus,
    "vipType": vipType,
    "province": province,
    "avatarUrl": avatarUrl,
    "authStatus": authStatus,
    "userType": userType,
    "nickname": nickname,
    "gender": gender,
    "birthday": birthday,
    "city": city,
    "description": description,
    "signature": signature,
    "authority": authority,
  };
}
