
import 'dart:convert';

import 'package:qq_music/model/song/song_list_model.dart';

SongPlayDetails songPlayDetailsFromJson(String str) => SongPlayDetails.fromJson(json.decode(str));

String songPlayDetailsToJson(SongPlayDetails data) => json.encode(data.toJson());

///歌单详情
class SongPlayDetails {
  SongPlayDetails({
    required this.id,
    required this.creator,
    required this.name,
    required this.coverImgId,
    required this.coverImgUrl,
    required this.coverImgIdStr,
    required this.adType,
    required this.userId,
    required this.createTime,
    required this.status,
     this.opRecommend,
    required this.highQuality,
    required this.newImported,
    required this.updateTime,
    required this.trackCount,
    required this.specialType,
    required this.privacy,
    required this.trackUpdateTime,
    required this.commentThreadId,
    required this.playCount,
    required this.trackNumberUpdateTime,
    required this.subscribedCount,
    required this.cloudTrackCount,
    required this.ordered,
    required this.description,
    required this.updateFrequency,
     this.backgroundCoverId,
    required this.backgroundCoverUrl,
     this.titleImage,
    required this.titleImageUrl,
    required this.englishTitle,
    required this.officialPlaylistType,
     this.copied,
    required this.bannedTrackIds,
    required this.shareCount,
    required this.commentCount,
    required this.remixVideo,
    required this.sharedUsers,
    required this.historySharedUsers,
     this.gradeStatus,
    required this.score,
    required this.algTags,
    required this.videoIds,
    required this.videos,
     this.tags,
    required this.subscribed,
  });

  int id;
  Creator creator;
  String name;
  double coverImgId;
  String coverImgUrl;
  String ? coverImgIdStr;
  int adType;
  int userId;
  int createTime;
  int status;
  bool ? opRecommend;
  bool highQuality;
  bool newImported;
  int updateTime;
  int trackCount;
  int specialType;
  int privacy;
  int trackUpdateTime;
  String commentThreadId;
  int playCount;
  int trackNumberUpdateTime;
  int subscribedCount;
  int cloudTrackCount;
  bool ordered;
  String description;
  dynamic updateFrequency;
  int ? backgroundCoverId;
  dynamic backgroundCoverUrl;
  int ? titleImage;
  dynamic titleImageUrl;
  dynamic englishTitle;
  dynamic officialPlaylistType;
  bool ? copied;
  dynamic bannedTrackIds;
  int shareCount;
  int commentCount;
  dynamic remixVideo;
  dynamic sharedUsers;
  dynamic historySharedUsers;
  String ? gradeStatus;
  dynamic score;
  dynamic algTags;
  dynamic videoIds;
  dynamic videos;
  List<String> ? tags;
  bool subscribed;

  factory SongPlayDetails.fromJson(Map<String, dynamic> json) => SongPlayDetails(
    id: json["id"] == null ? null : json["id"],
    creator: Creator.fromJson(json["creator"]) ,
    name: json["name"] == null ? null : json["name"],
    coverImgId: json["coverImgId"] == null ? null : json["coverImgId"].toDouble(),
    coverImgUrl: json["coverImgUrl"] == null ? null : json["coverImgUrl"],
    coverImgIdStr: json["coverImgId_str"] == null ? null : json["coverImgId_str"],
    adType: json["adType"] == null ? null : json["adType"],
    userId: json["userId"] == null ? null : json["userId"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    status: json["status"] == null ? null : json["status"],
    opRecommend: json["opRecommend"] == null ? null : json["opRecommend"],
    highQuality: json["highQuality"] == null ? null : json["highQuality"],
    newImported: json["newImported"] == null ? null : json["newImported"],
    updateTime: json["updateTime"] == null ? null : json["updateTime"],
    trackCount: json["trackCount"] == null ? null : json["trackCount"],
    specialType: json["specialType"] == null ? null : json["specialType"],
    privacy: json["privacy"] == null ? null : json["privacy"],
    trackUpdateTime: json["trackUpdateTime"] == null ? null : json["trackUpdateTime"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    trackNumberUpdateTime: json["trackNumberUpdateTime"] == null ? null : json["trackNumberUpdateTime"],
    subscribedCount: json["subscribedCount"] == null ? null : json["subscribedCount"],
    cloudTrackCount: json["cloudTrackCount"] == null ? null : json["cloudTrackCount"],
    ordered: json["ordered"] == null ? null : json["ordered"],
    description: json["description"] == null ? null : json["description"],
    updateFrequency: json["updateFrequency"],
    backgroundCoverId: json["backgroundCoverId"] == null ? null : json["backgroundCoverId"],
    backgroundCoverUrl: json["backgroundCoverUrl"],
    titleImage: json["titleImage"] == null ? null : json["titleImage"],
    titleImageUrl: json["titleImageUrl"],
    englishTitle: json["englishTitle"],
    officialPlaylistType: json["officialPlaylistType"],
    copied: json["copied"] == null ? null : json["copied"],
    bannedTrackIds: json["bannedTrackIds"],
    shareCount: json["shareCount"] == null ? null : json["shareCount"],
    commentCount: json["commentCount"] == null ? null : json["commentCount"],
    remixVideo: json["remixVideo"],
    sharedUsers: json["sharedUsers"],
    historySharedUsers: json["historySharedUsers"],
    gradeStatus: json["gradeStatus"] == null ? null : json["gradeStatus"],
    score: json["score"],
    algTags: json["algTags"],
    videoIds: json["videoIds"],
    videos: json["videos"],
    tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
    subscribed: json["subscribed"] == null ? null : json["subscribed"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "creator": creator.toJson(),
    "name": name == null ? null : name,
    "coverImgId": coverImgId == null ? null : coverImgId,
    "coverImgUrl": coverImgUrl == null ? null : coverImgUrl,
    "coverImgId_str": coverImgIdStr == null ? null : coverImgIdStr,
    "adType": adType == null ? null : adType,
    "userId": userId == null ? null : userId,
    "createTime": createTime == null ? null : createTime,
    "status": status == null ? null : status,
    "opRecommend": opRecommend == null ? null : opRecommend,
    "highQuality": highQuality == null ? null : highQuality,
    "newImported": newImported == null ? null : newImported,
    "updateTime": updateTime == null ? null : updateTime,
    "trackCount": trackCount == null ? null : trackCount,
    "specialType": specialType == null ? null : specialType,
    "privacy": privacy == null ? null : privacy,
    "trackUpdateTime": trackUpdateTime == null ? null : trackUpdateTime,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "playCount": playCount == null ? null : playCount,
    "trackNumberUpdateTime": trackNumberUpdateTime == null ? null : trackNumberUpdateTime,
    "subscribedCount": subscribedCount == null ? null : subscribedCount,
    "cloudTrackCount": cloudTrackCount == null ? null : cloudTrackCount,
    "ordered": ordered == null ? null : ordered,
    "description": description == null ? null : description,
    "updateFrequency": updateFrequency,
    "backgroundCoverId": backgroundCoverId == null ? null : backgroundCoverId,
    "backgroundCoverUrl": backgroundCoverUrl,
    "titleImage": titleImage == null ? null : titleImage,
    "titleImageUrl": titleImageUrl,
    "englishTitle": englishTitle,
    "officialPlaylistType": officialPlaylistType,
    "copied": copied == null ? null : copied,
    "bannedTrackIds": bannedTrackIds,
    "shareCount": shareCount == null ? null : shareCount,
    "commentCount": commentCount == null ? null : commentCount,
    "remixVideo": remixVideo,
    "sharedUsers": sharedUsers,
    "historySharedUsers": historySharedUsers,
    "gradeStatus": gradeStatus == null ? null : gradeStatus,
    "score": score,
    "algTags": algTags,
    "videoIds": videoIds,
    "videos": videos,
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
    "subscribed": subscribed == null ? null : subscribed,
  };
}
