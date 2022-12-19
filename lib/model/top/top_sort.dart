// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

TopSortModel topSortModelFromJson(String str) => TopSortModel.fromJson(json.decode(str));

String topSortModelToJson(TopSortModel data) => json.encode(data.toJson());

class TopSortModel {
  TopSortModel({
    required this.subscribers,
    required this.subscribed,
    required this.creator,
    required this.artists,
    required this.tracks,
    required this.updateFrequency,
    required this.backgroundCoverId,
    required this.backgroundCoverUrl,
    required this.titleImage,
    required this.titleImageUrl,
    required this.englishTitle,
    required this.opRecommend,
    required this.recommendInfo,
    required this.trackNumberUpdateTime,
    required this.adType,
    required this.subscribedCount,
    required this.cloudTrackCount,
    required this.userId,
    required this.highQuality,
    required this.createTime,
    required this.specialType,
    required this.anonimous,
    required this.coverImgId,
    required this.newImported,
    required this.updateTime,
    required this.trackCount,
    required this.coverImgUrl,
    required this.trackUpdateTime,
    required this.commentThreadId,
    required this.totalDuration,
    required this.privacy,
    required this.playCount,
    required this.description,
    required this.ordered,
    required this.tags,
    required this.status,
    required this.name,
    required this.id,
    required this.coverImgIdStr,
    required this.toplistType,
  });

  List<dynamic> subscribers;
  dynamic subscribed;
  dynamic creator;
  dynamic artists;
  List<Track> tracks;
  String ? updateFrequency;
  int backgroundCoverId;
  dynamic backgroundCoverUrl;
  int titleImage;
  dynamic titleImageUrl;
  dynamic englishTitle;
  bool opRecommend;
  dynamic recommendInfo;
  int trackNumberUpdateTime;
  int adType;
  int subscribedCount;
  int cloudTrackCount;
  int userId;
  bool highQuality;
  int createTime;
  int specialType;
  bool anonimous;
  double coverImgId;
  bool newImported;
  int updateTime;
  int trackCount;
  String coverImgUrl;
  int trackUpdateTime;
  String ? commentThreadId;
  int totalDuration;
  int privacy;
  int playCount;
  String ? description;
  bool ordered;
  List<dynamic> tags;
  int status;
  String ? name;
  int id;
  String ? coverImgIdStr;
  String ? toplistType;

  factory TopSortModel.fromJson(Map<String, dynamic> json) => TopSortModel(
    subscribers:  List<dynamic>.from(json["subscribers"].map((x) => x)),
    subscribed: json["subscribed"],
    creator: json["creator"],
    artists: json["artists"],
    tracks:  List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
    updateFrequency: json["updateFrequency"] == null ? null : json["updateFrequency"],
    backgroundCoverId: json["backgroundCoverId"] == null ? null : json["backgroundCoverId"],
    backgroundCoverUrl: json["backgroundCoverUrl"],
    titleImage: json["titleImage"] == null ? null : json["titleImage"],
    titleImageUrl: json["titleImageUrl"],
    englishTitle: json["englishTitle"],
    opRecommend: json["opRecommend"] == null ? null : json["opRecommend"],
    recommendInfo: json["recommendInfo"],
    trackNumberUpdateTime: json["trackNumberUpdateTime"] == null ? null : json["trackNumberUpdateTime"],
    adType: json["adType"] == null ? null : json["adType"],
    subscribedCount: json["subscribedCount"] == null ? null : json["subscribedCount"],
    cloudTrackCount: json["cloudTrackCount"] == null ? null : json["cloudTrackCount"],
    userId: json["userId"] == null ? null : json["userId"],
    highQuality: json["highQuality"] == null ? null : json["highQuality"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    specialType: json["specialType"] == null ? null : json["specialType"],
    anonimous: json["anonimous"] == null ? null : json["anonimous"],
    coverImgId: json["coverImgId"] == null ? null : json["coverImgId"].toDouble(),
    newImported: json["newImported"] == null ? null : json["newImported"],
    updateTime: json["updateTime"] == null ? null : json["updateTime"],
    trackCount: json["trackCount"] == null ? null : json["trackCount"],
    coverImgUrl: json["coverImgUrl"] == null ? null : json["coverImgUrl"],
    trackUpdateTime: json["trackUpdateTime"] == null ? null : json["trackUpdateTime"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    totalDuration: json["totalDuration"] == null ? null : json["totalDuration"],
    privacy: json["privacy"] == null ? null : json["privacy"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    description: json["description"] == null ? null : json["description"],
    ordered: json["ordered"] == null ? null : json["ordered"],
    tags:List<dynamic>.from(json["tags"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    coverImgIdStr: json["coverImgId_str"] == null ? null : json["coverImgId_str"],
    toplistType: json["ToplistType"] == null ? null : json["ToplistType"],
  );

  Map<String, dynamic> toJson() => {
    "subscribers": subscribers == null ? null : List<dynamic>.from(subscribers.map((x) => x)),
    "subscribed": subscribed,
    "creator": creator,
    "artists": artists,
    "tracks": tracks == null ? null : List<dynamic>.from(tracks.map((x) => x.toJson())),
    "updateFrequency": updateFrequency == null ? null : updateFrequency,
    "backgroundCoverId": backgroundCoverId == null ? null : backgroundCoverId,
    "backgroundCoverUrl": backgroundCoverUrl,
    "titleImage": titleImage == null ? null : titleImage,
    "titleImageUrl": titleImageUrl,
    "englishTitle": englishTitle,
    "opRecommend": opRecommend == null ? null : opRecommend,
    "recommendInfo": recommendInfo,
    "trackNumberUpdateTime": trackNumberUpdateTime == null ? null : trackNumberUpdateTime,
    "adType": adType == null ? null : adType,
    "subscribedCount": subscribedCount == null ? null : subscribedCount,
    "cloudTrackCount": cloudTrackCount == null ? null : cloudTrackCount,
    "userId": userId == null ? null : userId,
    "highQuality": highQuality == null ? null : highQuality,
    "createTime": createTime == null ? null : createTime,
    "specialType": specialType == null ? null : specialType,
    "anonimous": anonimous == null ? null : anonimous,
    "coverImgId": coverImgId == null ? null : coverImgId,
    "newImported": newImported == null ? null : newImported,
    "updateTime": updateTime == null ? null : updateTime,
    "trackCount": trackCount == null ? null : trackCount,
    "coverImgUrl": coverImgUrl == null ? null : coverImgUrl,
    "trackUpdateTime": trackUpdateTime == null ? null : trackUpdateTime,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "totalDuration": totalDuration == null ? null : totalDuration,
    "privacy": privacy == null ? null : privacy,
    "playCount": playCount == null ? null : playCount,
    "description": description == null ? null : description,
    "ordered": ordered == null ? null : ordered,
    "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
    "status": status == null ? null : status,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "coverImgId_str": coverImgIdStr == null ? null : coverImgIdStr,
    "ToplistType": toplistType == null ? null : toplistType,
  };
}

class Track {
  Track({
    required this.first,
    required this.second,
  });

  String first;
  String second;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    first: json["first"] == null ? null : json["first"],
    second: json["second"] == null ? null : json["second"],
  );

  Map<String, dynamic> toJson() => {
    "first": first == null ? null : first,
    "second": second == null ? null : second,
  };
}
