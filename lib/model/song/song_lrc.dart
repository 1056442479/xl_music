
import 'dart:convert';

SongLrcModel songLrcModelFromJson(String str) => SongLrcModel.fromJson(json.decode(str));

String songLrcModelToJson(SongLrcModel data) => json.encode(data.toJson());

///[needDesc] 为true时时纯音乐
class SongLrcModel {
  SongLrcModel({
    required this.sgc,
    required this.sfy,
    required this.qfy,
    required this.lrc,
    required this.klyric,
    required this.tlyric,
    required this.romalrc,
    required this.code,
     this.needDesc,
  });

  bool sgc;
  bool sfy;
  bool qfy;
  bool ? needDesc;
  Klyric lrc;
  Klyric ? klyric;
  Klyric ? tlyric;
  Klyric ? romalrc;
  int code;

  factory SongLrcModel.fromJson(Map<String, dynamic> json) => SongLrcModel(
    sgc: json["sgc"] == null ? null : json["sgc"],
    sfy: json["sfy"] == null ? null : json["sfy"],
    needDesc: json["needDesc"] == null ? null : json["needDesc"],
    qfy: json["qfy"] == null ? null : json["qfy"],
    lrc: Klyric.fromJson(json["lrc"]),
    klyric: json["klyric"]==null?null: Klyric.fromJson(json["klyric"]),
    tlyric:  json["tlyric"]==null?null: Klyric.fromJson(json["tlyric"]),
    romalrc: json["romalrc"]==null?null: Klyric.fromJson(json["romalrc"]),
    code: json["code"] == null ? null : json["code"],
  );

  Map<String, dynamic> toJson() => {
    "sgc": sgc == null ? null : sgc,
    "sfy": sfy == null ? null : sfy,
    "needDesc": sfy == null ? null : needDesc,
    "qfy": qfy == null ? null : qfy,
    "lrc": lrc == null ? null : lrc.toJson(),
    "klyric": klyric == null ? null : klyric!.toJson(),
    "tlyric": tlyric == null ? null : tlyric!.toJson(),
    "romalrc": romalrc == null ? null : romalrc!.toJson(),
    "code": code == null ? null : code,
  };
}

class Klyric {
  Klyric({
    required this.version,
    required this.lyric,
  });

  int version;
  String lyric;

  factory Klyric.fromJson(Map<String, dynamic> json) => Klyric(
    version: json["version"] == null ? null : json["version"],
    lyric: json["lyric"] == null ? null : json["lyric"],
  );

  Map<String, dynamic> toJson() => {
    "version": version == null ? null : version,
    "lyric": lyric == null ? null : lyric,
  };
}
