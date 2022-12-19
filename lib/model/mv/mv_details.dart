// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/user/song_user_model.dart';

MvDetailsModel mvDetailsModelFromJson(String str) => MvDetailsModel.fromJson(json.decode(str));

String mvDetailsModelToJson(MvDetailsModel data) => json.encode(data.toJson());

class MvDetailsModel {
  MvDetailsModel({
    required this.id,
     this.type,
     this.artist,
    required this.name,
     this.copywriter,
     this.cover,
    this.status,
     this.picUrl,
     this.canDislike,
      this.imgurl,
     this.imgurl16v9,
     this.trackNumberUpdateTime,
    required this.duration,
    required this.playCount,
     this.subed,
     this.artists,
    this.publishTime,
    required this.artistName,
     this.artistId,
     this.alg,
  });

  int id;
  int ? type;
  int ? status;
  String name;
  Artist ? artist;
  String ? copywriter;
  String ? cover;
  String ? imgurl16v9;
  String ? imgurl;
  String ? publishTime;
  String ? picUrl;
  bool ? canDislike;
  dynamic trackNumberUpdateTime;
  int duration;
  int playCount;
  bool ? subed;
  List<Artist> ? artists;
  String artistName;
  int ? artistId;
  String ? alg;

  factory MvDetailsModel.fromJson(Map<String, dynamic> json) => MvDetailsModel(
    id: json["id"] == null ? null : json["id"],
    status: json["status"] == null ? null : json["status"],
    imgurl16v9: json["imgurl16v9"] == null ? null : json["imgurl16v9"],
    imgurl: json["imgurl"] == null ? null : json["imgurl"],
    cover: json["cover"] == null ? null : json["cover"],
    type: json["type"] == null ? null : json["type"],
    name: json["name"] == null ? null : json["name"],
    artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
    copywriter: json["copywriter"] == null ? null : json["copywriter"],
    publishTime: json["publishTime"] == null ? null : json["publishTime"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    canDislike: json["canDislike"] == null ? null : json["canDislike"],
    trackNumberUpdateTime: json["trackNumberUpdateTime"],
    duration: json["duration"] == null ? null : json["duration"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    subed: json["subed"] == null ? null : json["subed"],
    artists: json["artists"] == null ? null : List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    artistName: json["artistName"] == null ? null : json["artistName"],
    artistId: json["artistId"] == null ? null : json["artistId"],
    alg: json["alg"] == null ? null : json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "status": status,
    "imgurl16v9": imgurl16v9,
    "imgurl": imgurl,
    "artists":artists==null?null:artists!.toSet(),
    "type": type == null ? null : type,
    "name": name == null ? null : name,
    "cover": cover == null ? null : cover,
    "copywriter": copywriter == null ? null : copywriter,
    "publishTime": publishTime == null ? null : publishTime,
    "picUrl": picUrl == null ? null : picUrl,
    "canDislike": canDislike == null ? null : canDislike,
    "trackNumberUpdateTime": trackNumberUpdateTime,
    "duration": duration == null ? null : duration,
    "playCount": playCount == null ? null : playCount,
    "subed": subed == null ? null : subed,
    "artists": artists == null ? null : List<dynamic>.from(artists!.map((x) => x.toJson())),
    "artistName": artistName == null ? null : artistName,
    "artistId": artistId == null ? null : artistId,
    "alg": alg == null ? null : alg,
  };
}


