
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/album/album_model.dart';
import 'package:qq_music/model/song/song_list_details.dart';

AlbumSongListModel albumSongListModelFromJson(String str) => AlbumSongListModel.fromJson(json.decode(str));

String albumSongListModelToJson(AlbumSongListModel data) => json.encode(data.toJson());

///[songs] 歌曲列表
///[album] 专辑的详细信息
class AlbumSongListModel {
  AlbumSongListModel({
    required this.songs,
    required this.album,
  });

  List<Song> songs;
  AlbumDetailsModel album;


  factory AlbumSongListModel.fromJson(Map<String, dynamic> json) => AlbumSongListModel(
    songs:   List<Song>.from(json["songs"].map((x) => Song.fromJson(x))),
    album: AlbumDetailsModel.fromJson( json["album"]),
  );

  Map<String, dynamic> toJson() => {
    "songs":  songs == null ? null : List<Song>.from(songs.map((x) => x)),
    "album": album.toJson(),
  };
}
