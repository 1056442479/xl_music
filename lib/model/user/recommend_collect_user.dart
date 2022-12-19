
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

RecommendCollectUser recommendCollectUserFromJson(String str) => RecommendCollectUser.fromJson(json.decode(str));

String recommendCollectUserToJson(RecommendCollectUser data) => json.encode(data.toJson());

class RecommendCollectUser {
  RecommendCollectUser({
    required   this.defaultAvatar,
    required  this.province,
    required this.authStatus,
    required this.followed,
    required  this.avatarUrl,
    required this.accountStatus,
    required  this.gender,
    required this.city,
    required this.birthday,
    required this.userId,
    required this.userType,
    required this.nickname,
    required this.signature,
    required  this.description,
    required  this.detailDescription,
    required this.avatarImgId,
    required this.backgroundImgId,
      this.backgroundUrl,
    required this.authority,
    required this.mutual,
    this.expertTags,
    this.experts,
    required this.djStatus,
    required  this.vipType,
    this.remarkName,
    required this.subscribeTime,
    required this.backgroundImgIdStr,
    required this.avatarImgIdStr,
    this.vipRights,
    required this.welcomeAvatarImgIdStr,
    this.avatarDetail,
  });

  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String ? signature;
  String ? description;
  String ? detailDescription;
  double avatarImgId;
  double backgroundImgId;
  String ? backgroundUrl;
  int authority;
  bool mutual;
  dynamic expertTags;
  dynamic experts;
  int djStatus;
  int vipType;
  dynamic remarkName;
  int subscribeTime;
  String ? backgroundImgIdStr;
  String ? avatarImgIdStr;
  dynamic vipRights;
  String ? welcomeAvatarImgIdStr;
  dynamic avatarDetail;

  factory RecommendCollectUser.fromJson(Map<String, dynamic> json) => RecommendCollectUser(
    defaultAvatar: json["defaultAvatar"] == null ? null : json["defaultAvatar"],
    province: json["province"] == null ? null : json["province"],
    authStatus: json["authStatus"] == null ? null : json["authStatus"],
    followed: json["followed"] == null ? null : json["followed"],
    avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    accountStatus: json["accountStatus"] == null ? null : json["accountStatus"],
    gender: json["gender"] == null ? null : json["gender"],
    city: json["city"] == null ? null : json["city"],
    birthday: json["birthday"] == null ? null : json["birthday"],
    userId: json["userId"] == null ? null : json["userId"],
    userType: json["userType"] == null ? null : json["userType"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    signature: json["signature"] == null ? null : json["signature"],
    description: json["description"] == null ? null : json["description"],
    detailDescription: json["detailDescription"] == null ? null : json["detailDescription"],
    avatarImgId: json["avatarImgId"] == null ? null : json["avatarImgId"].toDouble(),
    backgroundImgId: json["backgroundImgId"] == null ? null : json["backgroundImgId"].toDouble(),
    backgroundUrl: json["backgroundUrl"] == null ? null : json["backgroundUrl"],
    authority: json["authority"] == null ? null : json["authority"],
    mutual: json["mutual"] == null ? null : json["mutual"],
    expertTags: json["expertTags"],
    experts: json["experts"],
    djStatus: json["djStatus"] == null ? null : json["djStatus"],
    vipType: json["vipType"] == null ? null : json["vipType"],
    remarkName: json["remarkName"],
    subscribeTime: json["subscribeTime"] == null ? null : json["subscribeTime"],
    backgroundImgIdStr: json["backgroundImgIdStr"] == null ? null : json["backgroundImgIdStr"],
    avatarImgIdStr: json["avatarImgIdStr"] == null ? null : json["avatarImgIdStr"],
    vipRights: json["vipRights"],
    welcomeAvatarImgIdStr: json["avatarImgId_str"] == null ? null : json["avatarImgId_str"],
    avatarDetail: json["avatarDetail"],
  );

  Map<String, dynamic> toJson() => {
    "defaultAvatar": defaultAvatar == null ? null : defaultAvatar,
    "province": province == null ? null : province,
    "authStatus": authStatus == null ? null : authStatus,
    "followed": followed == null ? null : followed,
    "avatarUrl": avatarUrl == null ? null : avatarUrl,
    "accountStatus": accountStatus == null ? null : accountStatus,
    "gender": gender == null ? null : gender,
    "city": city == null ? null : city,
    "birthday": birthday == null ? null : birthday,
    "userId": userId == null ? null : userId,
    "userType": userType == null ? null : userType,
    "nickname": nickname == null ? null : nickname,
    "signature": signature == null ? null : signature,
    "description": description == null ? null : description,
    "detailDescription": detailDescription == null ? null : detailDescription,
    "avatarImgId": avatarImgId == null ? null : avatarImgId,
    "backgroundImgId": backgroundImgId == null ? null : backgroundImgId,
    "backgroundUrl": backgroundUrl == null ? null : backgroundUrl,
    "authority": authority == null ? null : authority,
    "mutual": mutual == null ? null : mutual,
    "expertTags": expertTags,
    "experts": experts,
    "djStatus": djStatus == null ? null : djStatus,
    "vipType": vipType == null ? null : vipType,
    "remarkName": remarkName,
    "subscribeTime": subscribeTime == null ? null : subscribeTime,
    "backgroundImgIdStr": backgroundImgIdStr == null ? null : backgroundImgIdStr,
    "avatarImgIdStr": avatarImgIdStr == null ? null : avatarImgIdStr,
    "vipRights": vipRights,
    "avatarImgId_str": welcomeAvatarImgIdStr == null ? null : welcomeAvatarImgIdStr,
    "avatarDetail": avatarDetail,
  };
}
