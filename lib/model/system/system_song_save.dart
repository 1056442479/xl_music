
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';

SystemSongSaveModel systemSongSaveModelFromJson(String str) => SystemSongSaveModel.fromJson(json.decode(str));

String systemSongSaveModelToJson(SystemSongSaveModel data) => json.encode(data.toJson());

///[playList] 当前播放歌曲的列表
///
/// [playIndex] 当前列表播放的索引
///
/// [recommendPlayId] 正在播放的专辑或者歌单的id
///
/// [nowTimeMs] 播放位置的毫秒数
///
/// [url] 记录的播放的url（会过期，需要重新接口获取）
class SystemSongSaveModel {
  SystemSongSaveModel({
     this.playList,
    required this.playIndex,
    required this.recommendPlayId,
     this.url,
    required  this.nowTimeMs,
  });

  List<Song> ? playList;
  int playIndex;
  int recommendPlayId;
  double nowTimeMs;
  String ? url;

  factory SystemSongSaveModel.fromJson(Map<String, dynamic> json) => SystemSongSaveModel(
    playList: json["playList"] ==null?null: List<Song>.from(json["playList"].map((e)=> Song.fromJson(e))),
    playIndex: json["playIndex"],
    nowTimeMs: json["nowTimeMs"],
    recommendPlayId: json["recommendPlayId"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "playList": playList==null?null: List<Song>.from(playList!.map((e)=> e)),
    "playIndex": playIndex,
    "recommendPlayId": recommendPlayId,
    "url": url,
    "nowTimeMs": nowTimeMs,
  };
}
