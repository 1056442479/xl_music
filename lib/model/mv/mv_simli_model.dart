// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


import 'dart:convert';

SimilarMvModel similarMvModelFromJson(String str) => SimilarMvModel.fromJson(json.decode(str));

String similarMvModelToJson(SimilarMvModel data) => json.encode(data.toJson());

///相似mv实体
class SimilarMvModel {
  SimilarMvModel({
    required this.id,
    required this.cover,
    required this.name,
    required this.playCount,
     this.briefDesc,
    required this.desc,
    required this.artistName,
    required this.artistId,
    required this.duration,
    required this.mark,
    required this.artists,
    required this.alg,
  });

  int id;
  String cover;
  String name;
  int playCount;
  String ? briefDesc;
  dynamic desc;
  String artistName;
  int artistId;
  int duration;
  int mark;
  List<Artist> artists;
  String alg;

  factory SimilarMvModel.fromJson(Map<String, dynamic> json) => SimilarMvModel(
    id: json["id"] == null ? null : json["id"],
    cover: json["cover"] == null ? null : json["cover"],
    name: json["name"] == null ? null : json["name"],
    playCount: json["playCount"] == null ? null : json["playCount"],
    briefDesc: json["briefDesc"] == null ? null : json["briefDesc"],
    desc: json["desc"],
    artistName: json["artistName"] == null ? null : json["artistName"],
    artistId: json["artistId"] == null ? null : json["artistId"],
    duration: json["duration"] == null ? null : json["duration"],
    mark: json["mark"] == null ? null : json["mark"],
    artists:  List<Artist>.from(json["artists"].map((x) => Artist.fromJson(x))),
    alg: json["alg"] == null ? null : json["alg"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "cover": cover == null ? null : cover,
    "name": name == null ? null : name,
    "playCount": playCount == null ? null : playCount,
    "briefDesc": briefDesc == null ? null : briefDesc,
    "desc": desc,
    "artistName": artistName == null ? null : artistName,
    "artistId": artistId == null ? null : artistId,
    "duration": duration == null ? null : duration,
    "mark": mark == null ? null : mark,
    "artists": artists == null ? null : List<dynamic>.from(artists.map((x) => x.toJson())),
    "alg": alg == null ? null : alg,
  };
}

class Artist {
  Artist({
    required this.id,
    required this.name,
    required this.alias,
    required this.transNames,
  });

  int id;
  String name;
  List<dynamic> alias;
  dynamic transNames;

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    alias:  List<dynamic>.from(json["alias"].map((x) => x)),
    transNames: json["transNames"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "alias": alias == null ? null : List<dynamic>.from(alias.map((x) => x)),
    "transNames": transNames,
  };
}
