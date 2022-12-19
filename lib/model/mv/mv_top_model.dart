// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

 MvTopModel welcomeFromJson(String str) =>  MvTopModel.fromJson(json.decode(str));

String welcomeToJson( MvTopModel data) => json.encode(data.toJson());

class  MvTopModel {
   MvTopModel({
     required this.id,
     required this.cover,
     required this.name,
     required this.playCount,
     required this.briefDesc,
     required this.desc,
     required this.artistName,
     required this.artistId,
     required this.duration,
     required this.mark,
     required this.mv,
     required this.lastRank,
     required this.score,
     required this.subed,
     required this.artists,
     required this.alias,
  });

  int id;
  String cover;
  String name;
  int playCount;
  dynamic briefDesc;
  dynamic desc;
  String artistName;
  int artistId;
  int duration;
  int mark;
  Mv mv;
  int lastRank;
  int score;
  bool subed;
  List<Artist> artists;
  List<String> ? alias;

  factory  MvTopModel.fromJson(Map<String, dynamic> json) =>  MvTopModel(
    id: json["id"] == null ? null : json["id"],
    cover: json["cover"] == null ? null : json["cover"],
    name: json["name"] == null ? null : json["name"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    briefDesc: json["briefDesc"],
    desc: json["desc"],
    artistName: json["artistName"] == null ? null : json["artistName"],
    artistId: json["artistId"] == null ? null : json["artistId"],
    duration: json["duration"] == null ? null : json["duration"],
    mark: json["mark"] == null ? null : json["mark"],
    mv: Mv.fromJson(json["mv"]),
    lastRank: json["lastRank"] == null ? null : json["lastRank"],
    score: json["score"] == null ? null : json["score"],
    subed: json["subed"] == null ? null : json["subed"],
    artists:  List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    alias: json["alias"]==null?null: List<String>.from(json["alias"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "cover": cover == null ? null : cover,
    "name": name == null ? null : name,
    "playCount": playCount == null ? null : playCount,
    "briefDesc": briefDesc,
    "desc": desc,
    "artistName": artistName == null ? null : artistName,
    "artistId": artistId == null ? null : artistId,
    "duration": duration == null ? null : duration,
    "mark": mark == null ? null : mark,
    "mv": mv == null ? null : mv.toJson(),
    "lastRank": lastRank == null ? null : lastRank,
    "score": score == null ? null : score,
    "subed": subed == null ? null : subed,
    "artists": artists == null ? null : List<dynamic>.from(artists.map((x) => x.toJson())),
    "alias": alias == null ? null : List<dynamic>.from(alias!.map((x) => x)),
  };
}

class Artist {
  Artist({
     required this.id,
     required this.name,
  });

  int id;
  String name;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
  };
}

class Mv {
  Mv({
     required this.authId,
     required this.status,
     required this.id,
     required this.title,
     required this.subTitle,
     required this.appTitle,
     required this.aliaName,
     required this.transName,
     required this.pic4V3,
     required this.pic16V9,
     required this.caption,
     required this.captionLanguage,
     required this.style,
     required this.mottos,
     required this.oneword,
     required this.appword,
     required this.stars,
     required this.desc,
     required this.area,
     required this.type,
     required this.subType,
     required this.neteaseonly,
     required this.upban,
     required this.topWeeks,
     required this.publishTime,
     required this.online,
     required this.score,
     required this.plays,
     required this.monthplays,
     required this.weekplays,
     required this.dayplays,
     required this.fee,
     required this.artists,
     required this.videos,
  });

  int authId;
  int status;
  int id;
  String title;
  String ? subTitle;
  String ? appTitle;
  String ? aliaName;
  String ? transName;
  double pic4V3;
  double pic16V9;
  int caption;
  String ? captionLanguage;
  dynamic style;
  String ? mottos;
  dynamic oneword;
  String ? appword;
  dynamic stars;
  String ? desc;
  String ? area;
  String ? type;
  String ? subType;
  int neteaseonly;
  int upban;
  String ? topWeeks;
  DateTime publishTime;
  int online;
  int score;
  int plays;
  int monthplays;
  int weekplays;
  int dayplays;
  int fee;
  List<Artist> artists;
  List<Video> videos;

  factory Mv.fromJson(Map<String, dynamic> json) => Mv(
    authId: json["authId"] == null ? null : json["authId"],
    status: json["status"] == null ? null : json["status"],
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    subTitle: json["subTitle"] == null ? null : json["subTitle"],
    appTitle: json["appTitle"] == null ? null : json["appTitle"],
    aliaName: json["aliaName"] == null ? null : json["aliaName"],
    transName: json["transName"] == null ? null : json["transName"],
    pic4V3: json["pic4v3"] == null ? null : json["pic4v3"].toDouble(),
    pic16V9: json["pic16v9"] == null ? null : json["pic16v9"].toDouble(),
    caption: json["caption"] == null ? null : json["caption"],
    captionLanguage: json["captionLanguage"] == null ? null : json["captionLanguage"],
    style: json["style"],
    mottos: json["mottos"] == null ? null : json["mottos"],
    oneword: json["oneword"],
    appword: json["appword"] == null ? null : json["appword"],
    stars: json["stars"],
    desc: json["desc"] == null ? null : json["desc"],
    area: json["area"] == null ? null : json["area"],
    type: json["type"] == null ? null : json["type"],
    subType: json["subType"] == null ? null : json["subType"],
    neteaseonly: json["neteaseonly"] == null ? null : json["neteaseonly"],
    upban: json["upban"] == null ? null : json["upban"],
    topWeeks: json["topWeeks"] == null ? null : json["topWeeks"],
    publishTime: DateTime.parse(json["publishTime"]),
    online: json["online"] == null ? null : json["online"],
    score: json["score"] == null ? null : json["score"],
    plays: json["plays"] == null ? null : json["plays"],
    monthplays: json["monthplays"] == null ? null : json["monthplays"],
    weekplays: json["weekplays"] == null ? null : json["weekplays"],
    dayplays: json["dayplays"] == null ? null : json["dayplays"],
    fee: json["fee"] == null ? null : json["fee"],
    artists: List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    videos:  List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "authId": authId == null ? null : authId,
    "status": status == null ? null : status,
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "subTitle": subTitle == null ? null : subTitle,
    "appTitle": appTitle == null ? null : appTitle,
    "aliaName": aliaName == null ? null : aliaName,
    "transName": transName == null ? null : transName,
    "pic4v3": pic4V3 == null ? null : pic4V3,
    "pic16v9": pic16V9 == null ? null : pic16V9,
    "caption": caption == null ? null : caption,
    "captionLanguage": captionLanguage == null ? null : captionLanguage,
    "style": style,
    "mottos": mottos == null ? null : mottos,
    "oneword": oneword,
    "appword": appword == null ? null : appword,
    "stars": stars,
    "desc": desc == null ? null : desc,
    "area": area == null ? null : area,
    "type": type == null ? null : type,
    "subType": subType == null ? null : subType,
    "neteaseonly": neteaseonly == null ? null : neteaseonly,
    "upban": upban == null ? null : upban,
    "topWeeks": topWeeks == null ? null : topWeeks,
    "publishTime": publishTime == null ? null : "${publishTime.year.toString().padLeft(4, '0')}-${publishTime.month.toString().padLeft(2, '0')}-${publishTime.day.toString().padLeft(2, '0')}",
    "online": online == null ? null : online,
    "score": score == null ? null : score,
    "plays": plays == null ? null : plays,
    "monthplays": monthplays == null ? null : monthplays,
    "weekplays": weekplays == null ? null : weekplays,
    "dayplays": dayplays == null ? null : dayplays,
    "fee": fee == null ? null : fee,
    "artists": artists == null ? null : List<dynamic>.from(artists.map((x) => x.toJson())),
    "videos": videos == null ? null : List<dynamic>.from(videos.map((x) => x.toJson())),
  };
}

class Video {
  Video({
     required this.tagSign,
     required this.tag,
     required this.url,
     required this.duration,
     required this.size,
     required this.width,
     required this.height,
     required this.container,
     required this.md5,
     required this.check,
  });

  TagSign tagSign;
  String tag;
  String url;
  int duration;
  int size;
  int width;
  int height;
  String container;
  String md5;
  bool check;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    tagSign:  TagSign.fromJson(json["tagSign"]),
    tag: json["tag"] == null ? null : json["tag"],
    url: json["url"] == null ? null : json["url"],
    duration: json["duration"] == null ? null : json["duration"],
    size: json["size"] == null ? null : json["size"],
    width: json["width"] == null ? null : json["width"],
    height: json["height"] == null ? null : json["height"],
    container: json["container"] == null ? null : json["container"],
    md5: json["md5"] == null ? null : json["md5"],
    check: json["check"] == null ? null : json["check"],
  );

  Map<String, dynamic> toJson() => {
    "tagSign": tagSign == null ? null : tagSign.toJson(),
    "tag": tag == null ? null : tag,
    "url": url == null ? null : url,
    "duration": duration == null ? null : duration,
    "size": size == null ? null : size,
    "width": width == null ? null : width,
    "height": height == null ? null : height,
    "container": container == null ? null : container,
    "md5": md5 == null ? null : md5,
    "check": check == null ? null : check,
  };
}

class TagSign {
  TagSign({
     required this.br,
     required this.type,
     required this.tagSign,
     required this.resolution,
     required this.mvtype,
  });

  int br;
  String type;
  String tagSign;
  int resolution;
  String mvtype;

  factory TagSign.fromJson(Map<String, dynamic> json) => TagSign(
    br: json["br"] == null ? null : json["br"],
    type: json["type"] == null ? null : json["type"],
    tagSign: json["tagSign"] == null ? null : json["tagSign"],
    resolution: json["resolution"] == null ? null : json["resolution"],
    mvtype: json["mvtype"] == null ? null : json["mvtype"],
  );

  Map<String, dynamic> toJson() => {
    "br": br == null ? null : br,
    "type": type == null ? null : type,
    "tagSign": tagSign == null ? null : tagSign,
    "resolution": resolution == null ? null : resolution,
    "mvtype": mvtype == null ? null : mvtype,
  };
}
