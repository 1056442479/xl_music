// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/song/song_list_model.dart';

SongCollectModel songCollectModelFromJson(String str) => SongCollectModel.fromJson(json.decode(str));

String songCollectModelToJson(SongCollectModel data) => json.encode(data.toJson());

class SongCollectModel {
  SongCollectModel({
    required this.subscribers,
    required this.subscribed,
    required this.creator,
    this.artists,
    this.tracks,
    this.updateFrequency,
    this.backgroundCoverId,
    this.backgroundCoverUrl,
    this.titleImage,
    this.titleImageUrl,
    this.englishTitle,
    this.opRecommend,
    this.recommendInfo,
    this.subscribedCount,
    this.cloudTrackCount,
    required this.userId,
    required this.totalDuration,
    this.coverImgId,
    this.privacy,
    this.trackUpdateTime,
    required this.trackCount,
    this.updateTime,
    this.commentThreadId,
    required this.coverImgUrl,
    this.specialType,
    this.anonimous,
    this.createTime,
    this.highQuality,
    this.newImported,
    this.trackNumberUpdateTime,
    required this.playCount,
    this.adType,
    this.description,
    required this.tags,
    required this.ordered, //true：是收藏，false：是歌单
    required this.status,
    required this.name,
    required this.id,
    this.coverImgIdStr,
    this.sharedUsers,
    this.shareStatus,
    this.copied,
  });

  List<dynamic> subscribers;
  bool subscribed;
  Creator creator;
  dynamic artists;
  dynamic tracks;
  dynamic updateFrequency;
  int ? backgroundCoverId;
  dynamic backgroundCoverUrl;
  int  ? titleImage;
  dynamic titleImageUrl;
  dynamic englishTitle;
  bool  ? opRecommend;
  dynamic recommendInfo;
  int  ? subscribedCount;
  int  ? cloudTrackCount;
  int  userId;
  int totalDuration;
  double  ? coverImgId;
  int  ? privacy;
  int  ? trackUpdateTime;
  int trackCount;
  int  ? updateTime;
  String  ? commentThreadId;
  String ? coverImgUrl;
  int  ? specialType;
  bool  ? anonimous;
  int  ? createTime;
  bool  ? highQuality;
  bool  ? newImported;
  int  ? trackNumberUpdateTime;
  int  playCount;
  int  ? adType;
  dynamic description;
  List<dynamic> tags;
  bool ordered;
  int status;
  String ? name;
  int id;
  String  ? coverImgIdStr;
  dynamic sharedUsers;
  dynamic shareStatus;
  bool  ? copied;

  factory SongCollectModel.fromJson(Map<String, dynamic> json) => SongCollectModel(
    subscribers:List<dynamic>.from(json["subscribers"].map((x) => x)),
    subscribed: json["subscribed"] == null ? null : json["subscribed"],
    creator:  Creator.fromJson(json["creator"]),
    artists: json["artists"],
    tracks: json["tracks"],
    updateFrequency: json["updateFrequency"],
    backgroundCoverId: json["backgroundCoverId"] == null ? null : json["backgroundCoverId"],
    backgroundCoverUrl: json["backgroundCoverUrl"],
    titleImage: json["titleImage"] == null ? null : json["titleImage"],
    titleImageUrl: json["titleImageUrl"],
    englishTitle: json["englishTitle"],
    opRecommend: json["opRecommend"] == null ? null : json["opRecommend"],
    recommendInfo: json["recommendInfo"],
    subscribedCount: json["subscribedCount"] == null ? null : json["subscribedCount"],
    cloudTrackCount: json["cloudTrackCount"] == null ? null : json["cloudTrackCount"],
    userId: json["userId"] == null ? null : json["userId"],
    totalDuration: json["totalDuration"] == null ? null : json["totalDuration"],
    coverImgId: json["coverImgId"] == null ? null : json["coverImgId"].toDouble(),
    privacy: json["privacy"] == null ? null : json["privacy"],
    trackUpdateTime: json["trackUpdateTime"] == null ? null : json["trackUpdateTime"],
    trackCount: json["trackCount"] == null ? null : json["trackCount"],
    updateTime: json["updateTime"] == null ? null : json["updateTime"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    coverImgUrl: json["coverImgUrl"] == null ? null : json["coverImgUrl"],
    specialType: json["specialType"] == null ? null : json["specialType"],
    anonimous: json["anonimous"] == null ? null : json["anonimous"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    highQuality: json["highQuality"] == null ? null : json["highQuality"],
    newImported: json["newImported"] == null ? null : json["newImported"],
    trackNumberUpdateTime: json["trackNumberUpdateTime"] == null ? null : json["trackNumberUpdateTime"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    adType: json["adType"] == null ? null : json["adType"],
    description: json["description"],
    tags:  List<dynamic>.from(json["tags"].map((x) => x)),
    ordered: json["ordered"] == null ? null : json["ordered"],
    status: json["status"] == null ? null : json["status"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    coverImgIdStr: json["coverImgId_str"] == null ? null : json["coverImgId_str"],
    sharedUsers: json["sharedUsers"],
    shareStatus: json["shareStatus"],
    copied: json["copied"] == null ? null : json["copied"],
  );

  Map<String, dynamic> toJson() => {
    "subscribers": subscribers == null ? null : List<dynamic>.from(subscribers.map((x) => x)),
    "subscribed": subscribed == null ? null : subscribed,
    "creator": creator == null ? null : creator.toJson(),
    "artists": artists,
    "tracks": tracks,
    "updateFrequency": updateFrequency,
    "backgroundCoverId": backgroundCoverId == null ? null : backgroundCoverId,
    "backgroundCoverUrl": backgroundCoverUrl,
    "titleImage": titleImage == null ? null : titleImage,
    "titleImageUrl": titleImageUrl,
    "englishTitle": englishTitle,
    "opRecommend": opRecommend == null ? null : opRecommend,
    "recommendInfo": recommendInfo,
    "subscribedCount": subscribedCount == null ? null : subscribedCount,
    "cloudTrackCount": cloudTrackCount == null ? null : cloudTrackCount,
    "userId": userId == null ? null : userId,
    "totalDuration": totalDuration == null ? null : totalDuration,
    "coverImgId": coverImgId == null ? null : coverImgId,
    "privacy": privacy == null ? null : privacy,
    "trackUpdateTime": trackUpdateTime == null ? null : trackUpdateTime,
    "trackCount": trackCount == null ? null : trackCount,
    "updateTime": updateTime == null ? null : updateTime,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "coverImgUrl": coverImgUrl == null ? null : coverImgUrl,
    "specialType": specialType == null ? null : specialType,
    "anonimous": anonimous == null ? null : anonimous,
    "createTime": createTime == null ? null : createTime,
    "highQuality": highQuality == null ? null : highQuality,
    "newImported": newImported == null ? null : newImported,
    "trackNumberUpdateTime": trackNumberUpdateTime == null ? null : trackNumberUpdateTime,
    "playCount": playCount == null ? null : playCount,
    "adType": adType == null ? null : adType,
    "description": description,
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    "ordered": ordered == null ? null : ordered,
    "status": status == null ? null : status,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "coverImgId_str": coverImgIdStr == null ? null : coverImgIdStr,
    "sharedUsers": sharedUsers,
    "shareStatus": shareStatus,
    "copied": copied == null ? null : copied,
  };
}


