
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/model/song/song_url_detail.dart';

PlayingSongListModel playingSongListModelFromJson(String str) => PlayingSongListModel.fromJson(json.decode(str));

String playingSongListModelToJson(PlayingSongListModel data) => json.encode(data.toJson());

///正在播放的歌曲列表
class PlayingSongListModel {
  PlayingSongListModel({
    required this.songList,
    required this.songUrlList,
  });

  List<Song> songList;
  List<SongUrlDetails> songUrlList;



  factory PlayingSongListModel.fromJson(Map<String, dynamic> json) => PlayingSongListModel(
    songUrlList: List<SongUrlDetails>.from(json["songUrlList"].map((e)=> SongUrlDetails.fromJson(e))),
    songList: List<Song>.from(json["songList"].map((e)=> Song.fromJson(e))),

  );

  Map<String, dynamic> toJson() => {
    "songUrlList":List<SongUrlDetails>.from(songUrlList.map((x) => x)),
    "songList": List<Song>.from(songList.map((x) => x)),

  };
}
