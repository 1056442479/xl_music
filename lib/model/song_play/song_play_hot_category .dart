// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SongPlayHotCategoryModel songPlayHotCategoryModelFromJson(String str) => SongPlayHotCategoryModel.fromJson(json.decode(str));

String songPlayHotCategoryModelToJson(SongPlayHotCategoryModel data) => json.encode(data.toJson());

///热门歌单分类标签
class SongPlayHotCategoryModel {
  SongPlayHotCategoryModel({
    required this.playlistTag,
    required this.activity,
    required this.hot,
    required this.usedCount,
    required this.position,
    required this.category,
    required this.createTime,
    required this.name,
    required this.id,
    required this.type,
  });

  PlaylistTag playlistTag;
  bool activity;
  bool hot;
  int usedCount;
  int position;
  int category;
  int createTime;
  String name;
  int id;
  int type;

  factory SongPlayHotCategoryModel.fromJson(Map<String, dynamic> json) => SongPlayHotCategoryModel(
    playlistTag:  PlaylistTag.fromJson(json["playlistTag"]),
    activity: json["activity"] == null ? null : json["activity"],
    hot: json["hot"] == null ? null : json["hot"],
    usedCount: json["usedCount"] == null ? null : json["usedCount"],
    position: json["position"] == null ? null : json["position"],
    category: json["category"] == null ? null : json["category"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
  );

  Map<String, dynamic> toJson() => {
    "playlistTag": playlistTag == null ? null : playlistTag.toJson(),
    "activity": activity == null ? null : activity,
    "hot": hot == null ? null : hot,
    "usedCount": usedCount == null ? null : usedCount,
    "position": position == null ? null : position,
    "category": category == null ? null : category,
    "createTime": createTime == null ? null : createTime,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "type": type == null ? null : type,
  };
}

class PlaylistTag {
  PlaylistTag({
    required this.id,
    required this.name,
    required this.category,
    required this.usedCount,
    required this.type,
    required this.position,
    required this.createTime,
    required this.highQuality,
    required this.highQualityPos,
    required this.officialPos,
  });

  int id;
  String name;
  int category;
  int usedCount;
  int type;
  int position;
  int createTime;
  int highQuality;
  int highQualityPos;
  int officialPos;

  factory PlaylistTag.fromJson(Map<String, dynamic> json) => PlaylistTag(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    category: json["category"] == null ? null : json["category"],
    usedCount: json["usedCount"] == null ? null : json["usedCount"],
    type: json["type"] == null ? null : json["type"],
    position: json["position"] == null ? null : json["position"],
    createTime: json["createTime"] == null ? null : json["createTime"],
    highQuality: json["highQuality"] == null ? null : json["highQuality"],
    highQualityPos: json["highQualityPos"] == null ? null : json["highQualityPos"],
    officialPos: json["officialPos"] == null ? null : json["officialPos"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "category": category == null ? null : category,
    "usedCount": usedCount == null ? null : usedCount,
    "type": type == null ? null : type,
    "position": position == null ? null : position,
    "createTime": createTime == null ? null : createTime,
    "highQuality": highQuality == null ? null : highQuality,
    "highQualityPos": highQualityPos == null ? null : highQualityPos,
    "officialPos": officialPos == null ? null : officialPos,
  };
}
