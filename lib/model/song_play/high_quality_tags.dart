
import 'dart:convert';

HighQualityTagsModel welcomeFromJson(String str) => HighQualityTagsModel.fromJson(json.decode(str));

String welcomeToJson(HighQualityTagsModel data) => json.encode(data.toJson());

///精品歌单的标签
class HighQualityTagsModel {
  HighQualityTagsModel({
    required this.id,
    required this.name,
    required this.type,
    required this.category,
    required this.hot,
  });

  int id;
  String name;
  int type;
  int category;
  bool hot;

  factory HighQualityTagsModel.fromJson(Map<String, dynamic> json) => HighQualityTagsModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    category: json["category"] == null ? null : json["category"],
    hot: json["hot"] == null ? null : json["hot"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "category": category == null ? null : category,
    "hot": hot == null ? null : hot,
  };
}
