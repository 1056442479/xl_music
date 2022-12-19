// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

 MvDuModel welcomeFromJson(String str) =>  MvDuModel.fromJson(json.decode(str));

String welcomeToJson( MvDuModel data) => json.encode(data.toJson());

///mv独家放送
class  MvDuModel {
   MvDuModel({
     required this.id,
     required this.url,
     required this.picUrl,
     required this.sPicUrl,
     required this.type,
     required this.copywriter,
     required this.name,
     required this.time,
  });

  int id;
  String url;
  String picUrl;
  String sPicUrl;
  int type;
  String copywriter;
  String name;
  int time;

  factory  MvDuModel.fromJson(Map<String, dynamic> json) =>  MvDuModel(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    sPicUrl: json["sPicUrl"] == null ? null : json["sPicUrl"],
    type: json["type"] == null ? null : json["type"],
    copywriter: json["copywriter"] == null ? null : json["copywriter"],
    name: json["name"] == null ? null : json["name"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "picUrl": picUrl == null ? null : picUrl,
    "sPicUrl": sPicUrl == null ? null : sPicUrl,
    "type": type == null ? null : type,
    "copywriter": copywriter == null ? null : copywriter,
    "name": name == null ? null : name,
    "time": time == null ? null : time,
  };
}
