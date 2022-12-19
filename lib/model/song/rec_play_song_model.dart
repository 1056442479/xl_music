// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';

RecPlaySongModel welcomeFromJson(String str) => RecPlaySongModel.fromJson(json.decode(str));

String welcomeToJson(RecPlaySongModel data) => json.encode(data.toJson());

///歌曲播放历时
class RecPlaySongModel {
  RecPlaySongModel({
    required this.resourceId,
    required this.playTime,
    required this.resourceType,
    required this.banned,
    required this.data,
  });

  String resourceId;
  int playTime;
  String resourceType;
  bool banned;
  Song data;

  factory RecPlaySongModel.fromJson(Map<String, dynamic> json) => RecPlaySongModel(
    resourceId: json["resourceId"] == null ? null : json["resourceId"],
    playTime: json["playTime"] == null ? null : json["playTime"],
    resourceType: json["resourceType"] == null ? null : json["resourceType"],
    banned: json["banned"] == null ? null : json["banned"],
    data:  Song.fromJson(json["data"]) ,
  );

  Map<String, dynamic> toJson() => {
    "resourceId": resourceId == null ? null : resourceId,
    "data": data == null ? null : data.toJson(),
    "playTime": playTime == null ? null : playTime,
    "resourceType": resourceType == null ? null : resourceType,
    "banned": banned == null ? null : banned,
  };
}
