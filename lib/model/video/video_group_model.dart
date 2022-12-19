
import 'dart:convert';

VideoGroupModel videoGroupModelFromJson(String str) => VideoGroupModel.fromJson(json.decode(str));

String videoGroupModelToJson(VideoGroupModel data) => json.encode(data.toJson());

class VideoGroupModel {
  VideoGroupModel({
    required this.id,
    required this.name,
    required this.url,
    required this.relatedVideoType,
    required this.selectTab,
    required this.abExtInfo,
  });

  int id;
  String name;
  dynamic url;
  dynamic relatedVideoType;
  bool selectTab;
  dynamic abExtInfo;

  factory VideoGroupModel.fromJson(Map<String, dynamic> json) => VideoGroupModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    url: json["url"],
    relatedVideoType: json["relatedVideoType"],
    selectTab: json["selectTab"] == null ? null : json["selectTab"],
    abExtInfo: json["abExtInfo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "url": url,
    "relatedVideoType": relatedVideoType,
    "selectTab": selectTab == null ? null : selectTab,
    "abExtInfo": abExtInfo,
  };
}
