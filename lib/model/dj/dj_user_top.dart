// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DjUserTopModel djUserTopModelFromJson(String str) => DjUserTopModel.fromJson(json.decode(str));

String djUserTopModelToJson(DjUserTopModel data) => json.encode(data.toJson());

///人气主播排行榜
class DjUserTopModel {
  DjUserTopModel({
    required this.id,
    required this.rank,
    required  this.lastRank,
    required  this.score,
    required  this.nickName,
    required this.avatarUrl,
    required  this.userType,
    required  this.userFollowedCount,
    required  this.mainAuthDesc,
    required  this.liveStatus,
    required  this.liveType,
    required  this.liveId,
    this.avatarDetail,
    required this.roomNo,
  });

  int id;
  int rank;
  int lastRank;
  int score;
  String nickName;
  String avatarUrl;
  int userType;
  int userFollowedCount;
  String mainAuthDesc;
  int liveStatus;
  int liveType;
  int liveId;
  dynamic avatarDetail;
  int roomNo;

  factory DjUserTopModel.fromJson(Map<String, dynamic> json) => DjUserTopModel(
    id: json["id"] == null ? null : json["id"],
    rank: json["rank"] == null ? null : json["rank"],
    lastRank: json["lastRank"] == null ? null : json["lastRank"],
    score: json["score"] == null ? null : json["score"],
    nickName: json["nickName"] == null ? null : json["nickName"],
    avatarUrl: json["avatarUrl"] == null ? null : json["avatarUrl"],
    userType: json["userType"] == null ? null : json["userType"],
    userFollowedCount: json["userFollowedCount"] == null ? null : json["userFollowedCount"],
    mainAuthDesc: json["mainAuthDesc"] == null ? null : json["mainAuthDesc"],
    liveStatus: json["liveStatus"] == null ? null : json["liveStatus"],
    liveType: json["liveType"] == null ? null : json["liveType"],
    liveId: json["liveId"] == null ? null : json["liveId"],
    avatarDetail: json["avatarDetail"],
    roomNo: json["roomNo"] == null ? null : json["roomNo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "rank": rank == null ? null : rank,
    "lastRank": lastRank == null ? null : lastRank,
    "score": score == null ? null : score,
    "nickName": nickName == null ? null : nickName,
    "avatarUrl": avatarUrl == null ? null : avatarUrl,
    "userType": userType == null ? null : userType,
    "userFollowedCount": userFollowedCount == null ? null : userFollowedCount,
    "mainAuthDesc": mainAuthDesc == null ? null : mainAuthDesc,
    "liveStatus": liveStatus == null ? null : liveStatus,
    "liveType": liveType == null ? null : liveType,
    "liveId": liveId == null ? null : liveId,
    "avatarDetail": avatarDetail,
    "roomNo": roomNo == null ? null : roomNo,
  };
}
