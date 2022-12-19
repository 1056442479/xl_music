// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:qq_music/model/song/song_list_details.dart';
import 'package:qq_music/model/user/song_user_model.dart';

AlbumDetailsModel albumDetailsModelFromJson(String str) => AlbumDetailsModel.fromJson(json.decode(str));

String albumDetailsModelToJson(AlbumDetailsModel data) => json.encode(data.toJson());

class AlbumDetailsModel {
  AlbumDetailsModel({
     this.songs,
     this.paid,
      this.onSale,
     this.mark,
       this.awardTags,
    required  this.companyId,
      this.blurPicUrl,
    required this.alias,
     this.artist,
//     this.artists,
    required  this.copyrightId,
    required  this.picId,
    required this.publishTime,
      this.company,
    required   this.briefDesc,
    required   this.picUrl,
    required   this.commentThreadId,
    required  this.pic,
    required  this.tags,
      this.description,
    required   this.status,
       this.subType,
    required  this.name,
    required  this.id,
    required this.type,
    required this.size,
     this.picIdStr,
       this.isSub,
  });

  List<Song> ? songs;
  List<Artist> ? artists;
  bool ? paid;
  bool ? onSale;
  int ? mark;
  dynamic awardTags;
  Artist ? artist;
  int companyId;
  String ? blurPicUrl;
  List<dynamic> alias;
  int copyrightId;
  dynamic picId;
  int publishTime;
  String ? company;
  String ? briefDesc;
  String picUrl;
  String ? commentThreadId;
  dynamic pic;
  String tags;
  String ? description;
  int status;
  String ? subType;
  String name;
  int id;
  String ? type;
  int size;
  String ? picIdStr;
  bool ? isSub;

  factory AlbumDetailsModel.fromJson(Map<String, dynamic> json) => AlbumDetailsModel(
    songs:json["songs"]==null?null:List<Song>.from(json["songs"].map((x) => x)),
    paid: json["paid"] == null ? null : json["paid"],
    onSale: json["onSale"] == null ? null : json["onSale"],
    mark: json["mark"] == null ? null : json["mark"],
    awardTags: json["awardTags"],
    artist: json["artist"]==null?null : Artist.fromJson(json["artist"]) ,
//    artists: json["artists"] ??  List<Artist>.from(json["artists"].map((x) => x)),
    companyId: json["companyId"] == null ? null : json["companyId"],
    blurPicUrl: json["blurPicUrl"] == null ? null : json["blurPicUrl"],
    alias:  List<dynamic>.from(json["alias"].map((x) => x)),
    copyrightId: json["copyrightId"] == null ? null : json["copyrightId"],
    picId: json["picId"] == null ? null : json["picId"].toDouble(),
    publishTime: json["publishTime"] == null ? null : json["publishTime"],
    company: json["company"] == null ? null : json["company"],
    briefDesc: json["briefDesc"] == null ? null : json["briefDesc"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    commentThreadId: json["commentThreadId"] == null ? null : json["commentThreadId"],
    pic: json["pic"] == null ? null : json["pic"].toDouble(),
    tags: json["tags"] == null ? null : json["tags"],
    description: json["description"] == null ? null : json["description"],
    status: json["status"] == null ? null : json["status"],
    subType: json["subType"] == null ? null : json["subType"],
    name: json["name"] == null ? null : json["name"],
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    size: json["size"] == null ? null : json["size"],
    picIdStr: json["picId_str"] == null ? null : json["picId_str"],
    isSub: json["isSub"] == null ? null : json["isSub"],
  );

  Map<String, dynamic> toJson() => {
    "songs": songs == null ? null : List<Song>.from(songs!.map((x) => x)),
    "paid": paid == null ? null : paid,
    "onSale": onSale == null ? null : onSale,
    "mark": mark == null ? null : mark,
    "awardTags": awardTags,
    "companyId": companyId == null ? null : companyId,
    "blurPicUrl": blurPicUrl == null ? null : blurPicUrl,
    "alias": alias == null ? null : List<dynamic>.from(alias.map((x) => x)),
    "artist": artist ==null?null: artist!.toJson(),
//    "artists": artists ??  List<Artist>.from(artists!.map((x) => x)),
    "copyrightId": copyrightId == null ? null : copyrightId,
    "picId": picId == null ? null : picId,
    "publishTime": publishTime == null ? null : publishTime,
    "company": company == null ? null : company,
    "briefDesc": briefDesc == null ? null : briefDesc,
    "picUrl": picUrl == null ? null : picUrl,
    "commentThreadId": commentThreadId == null ? null : commentThreadId,
    "pic": pic == null ? null : pic,
    "tags": tags == null ? null : tags,
    "description": description == null ? null : description,
    "status": status == null ? null : status,
    "subType": subType == null ? null : subType,
    "name": name == null ? null : name,
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "size": size == null ? null : size,
    "picId_str": picIdStr == null ? null : picIdStr,
    "isSub": isSub == null ? null : isSub,
  };
}
