
import 'dart:convert';

DjBannerModel djBannerModelFromJson(String str) => DjBannerModel.fromJson(json.decode(str));

String djBannerModelToJson(DjBannerModel data) => json.encode(data.toJson());

class DjBannerModel {
  DjBannerModel({
    required this.targetId,
    required this.targetType,
    required this.pic,
    required this.url,
    required this.typeTitle,
    required this.exclusive,
  });

  int targetId;
  int targetType;
  String pic;
  String url;
  String typeTitle;
  bool exclusive;

  factory DjBannerModel.fromJson(Map<String, dynamic> json) => DjBannerModel(
    targetId: json["targetId"] == null ? null : json["targetId"],
    targetType: json["targetType"] == null ? null : json["targetType"],
    pic: json["pic"] == null ? null : json["pic"],
    url: json["url"] == null ? null : json["url"],
    typeTitle: json["typeTitle"] == null ? null : json["typeTitle"],
    exclusive: json["exclusive"] == null ? null : json["exclusive"],
  );

  Map<String, dynamic> toJson() => {
    "targetId": targetId == null ? null : targetId,
    "targetType": targetType == null ? null : targetType,
    "pic": pic == null ? null : pic,
    "url": url == null ? null : url,
    "typeTitle": typeTitle == null ? null : typeTitle,
    "exclusive": exclusive == null ? null : exclusive,
  };
}
