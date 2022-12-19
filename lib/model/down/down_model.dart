
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

DownModel downModelFromJson(String str) => DownModel.fromJson(json.decode(str));

String downModelToJson(DownModel data) => json.encode(data.toJson());

///[songId] 歌曲id
///[songName] 歌曲名字
///[songUserId] 歌手id
///[songUserName] 歌手名字
///[albumId] 专辑id
///[albumName]专辑名字
///[cover] 歌曲封面
///[duration] 音乐总时长，毫秒数
///[size] 大小
///[absolutePath] 绝对路径
class DownModel {
  DownModel({
    required this.songId,
    required this.songName,

    required this.songUserId,
    required this.songUserName,

    required this.albumId,
    required this.albumName,
    required this.cover,
    required this.duration,
    required this.absolutePath,
     this.size,

  });

  int songId;
  String songName;
  int songUserId;
  String songUserName;
  int albumId;
  String albumName;
  String cover;
  String ? size;
  int duration;
  String  absolutePath;

  factory DownModel.fromJson(Map<String, dynamic> json) => DownModel(
    songId: json["songId"],
    size: json["size"],
    songName: json["songName"],
    duration: json["duration"],
    cover: json["cover"],
    songUserId: json["songUserId"],
    songUserName: json["songUserName"],
    albumId: json["albumId"],
    albumName: json["albumName"],
    absolutePath: json["absolutePath"],
  );

  Map<String, dynamic> toJson() => {
    "songId": songId,
    "songName": songName,
    "size": size,
    "cover": cover,
    "songUserId": songUserId,
    "duration": duration,
    "songUserName": songUserName,
    "albumId": albumId,
    "albumName": albumName,
    "absolutePath": absolutePath,
  };
}
