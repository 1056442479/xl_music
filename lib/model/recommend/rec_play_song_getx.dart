
import 'dart:convert';


RecommendPlaySongModel recommendPlaySongModelFromJson(String str) => RecommendPlaySongModel.fromJson(json.decode(str));

String recommendPlaySongModelToJson(RecommendPlaySongModel data) => json.encode(data.toJson());

///每日推荐歌单实体
class RecommendPlaySongModel {
  RecommendPlaySongModel({
    required this.id,
    required this.type,
    required this.name,
    required this.copywriter,
    required this.picUrl,
    required this.canDislike,
    required this.trackNumberUpdateTime,
    required this.playCount,
    required this.trackCount,
    required this.highQuality,
    required this.alg,
  });

  int id;
  int type;
  String name;
  String copywriter;
  String picUrl;
  bool canDislike;
  int trackNumberUpdateTime;
  int playCount;
  int trackCount;
  bool highQuality;
  String alg;

  factory RecommendPlaySongModel.fromJson(Map<String, dynamic> json) => RecommendPlaySongModel(
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    name: json["name"] == null ? null : json["name"],
    copywriter: json["copywriter"] == null ? null : json["copywriter"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    canDislike: json["canDislike"] == null ? null : json["canDislike"],
    trackNumberUpdateTime: json["trackNumberUpdateTime"] == null ? null : json["trackNumberUpdateTime"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    trackCount: json["trackCount"] == null ? null : json["trackCount"],
    highQuality: json["highQuality"] == null ? null : json["highQuality"],
    alg: json["alg"] == null ? null : json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "name": name == null ? null : name,
    "copywriter": copywriter == null ? null : copywriter,
    "picUrl": picUrl == null ? null : picUrl,
    "canDislike": canDislike == null ? null : canDislike,
    "trackNumberUpdateTime": trackNumberUpdateTime == null ? null : trackNumberUpdateTime,
    "playCount": playCount == null ? null : playCount,
    "trackCount": trackCount == null ? null : trackCount,
    "highQuality": highQuality == null ? null : highQuality,
    "alg": alg == null ? null : alg,
  };

}


