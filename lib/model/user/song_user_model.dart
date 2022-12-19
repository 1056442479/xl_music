// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';

SongUserModel songUserModelFromJson(String str) => SongUserModel.fromJson(json.decode(str));

String songUserModelToJson(SongUserModel data) => json.encode(data.toJson());

///歌单详情
class SongUserModel {
  SongUserModel({
     this.artist,
    required this.hotSongs,
    required this.code,
    required this.more,
  });

  Artist ? artist;
  List<Song> hotSongs;
  int code;
  bool more;

  factory SongUserModel.fromJson(Map<String, dynamic> json) => SongUserModel(
    artist: json['artist']==null?null: Artist.fromJson(json['artist']),
    hotSongs: List<Song>.from(json["hotSongs"].map((x) => Song.fromJson(x))),
    code: json["code"],
    more: json["more"],
  );

  Map<String, dynamic> toJson() => {
    "artist": artist==null?null: artist!.toJson(),
    "hotSongs": List<Song>.from(hotSongs.map((x) => x.toJson())),
    "code": code,
    "more": more,
  };
}


class Artist {
  Artist({
     this.img1V1Id,
     this.topicPerson,
     this.alias,
     this.picId,
    this.cover,
     this.briefDesc,
      this.musicSize,
      this.albumSize,
      this.picUrl,
      this.img1V1Url,
      this.followed,
       this.trans,
    required  this.name,
    required  this.id,
       this.publishTime,
       this.accountId,
       this.picIdStr,
     this.img1V1IdStr,
     this.mvSize,
  });

  double ? img1V1Id;
  int ? topicPerson;
  List<dynamic> ? alias;
  double ? picId;
  String ? briefDesc;
  int ? musicSize;
  int ? albumSize;
  String ? picUrl;
  String ? img1V1Url;
  bool ? followed;
  String ? trans;
  String ? name;
  String ? cover;
  int id;
  int ? publishTime;
  int ? accountId;
  String ? picIdStr;
  String ? img1V1IdStr;
  int ? mvSize;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    img1V1Id: json["img1v1Id"] == null ? null : json["img1v1Id"].toDouble(),
    topicPerson: json["topicPerson"] == null ? null : json["topicPerson"],
    alias: json["alias"]==null?null: List<dynamic>.from(json["alias"].map((x) => x)),
    picId: json["picId"] == null ? null : json["picId"].toDouble(),
    briefDesc: json["briefDesc"] == null ? null : json["briefDesc"],
    cover: json["cover"] == null ? null : json["cover"],
    musicSize: json["musicSize"] == null ? null : json["musicSize"],
    albumSize: json["albumSize"] == null ? null : json["albumSize"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    img1V1Url: json["img1v1Url"] == null ? null : json["img1v1Url"],
    followed: json["followed"] == null ? null : json["followed"],
    trans: json["trans"] == null ? null : json["trans"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    publishTime: json["publishTime"] == null ? null : json["publishTime"],
    accountId: json["accountId"] == null ? null : json["accountId"],
    picIdStr: json["picId_str"] == null ? null : json["picId_str"],
    img1V1IdStr: json["img1v1Id_str"] == null ? null : json["img1v1Id_str"],
    mvSize: json["mvSize"] == null ? null : json["mvSize"],
  );

  Map<String, dynamic> toJson() => {
    "img1v1Id": img1V1Id == null ? null : img1V1Id,
    "topicPerson": topicPerson == null ? null : topicPerson,
    "alias":  alias ?? List<dynamic>.from(alias!.map((x) => x)),
    "picId":  picId,
    "briefDesc": briefDesc == null ? null : briefDesc,
    "cover": cover == null ? null : cover,
    "musicSize": musicSize == null ? null : musicSize,
    "albumSize": albumSize == null ? null : albumSize,
    "picUrl": picUrl == null ? null : picUrl,
    "img1v1Url": img1V1Url == null ? null : img1V1Url,
    "followed": followed == null ? null : followed,
    "trans": trans == null ? null : trans,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "publishTime": publishTime == null ? null : publishTime,
    "accountId": accountId == null ? null : accountId,
    "picId_str": picIdStr == null ? null : picIdStr,
    "img1v1Id_str": img1V1IdStr == null ? null : img1V1IdStr,
    "mvSize": mvSize == null ? null : mvSize,
  };
}
