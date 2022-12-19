
import 'dart:convert';

SongPlayAllCategoryModel songPlayAllCategoryModelFromJson(String str) => SongPlayAllCategoryModel.fromJson(json.decode(str));

String songPlayAllCategoryModelToJson(SongPlayAllCategoryModel data) => json.encode(data.toJson());

///歌单的全部分类，不包含热梦歌单分类
class SongPlayAllCategoryModel {
  SongPlayAllCategoryModel({
    required this.code,
    required this.all,
    required this.sub,
    required this.categories,
  });

  int code;
  All all;
  List<All> sub;
  Map<String, String> categories;

  factory SongPlayAllCategoryModel.fromJson(Map<String, dynamic> json) => SongPlayAllCategoryModel(
    code: json["code"] == null ? null : json["code"],
    all:  All.fromJson(json["all"]),
    sub:  List<All>.from(json["sub"].map((x) => All.fromJson(x))),
    categories:  Map.from(json["categories"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "all": all == null ? null : all.toJson(),
    "sub": sub == null ? null : List<dynamic>.from(sub.map((x) => x.toJson())),
    "categories": categories == null ? null : Map.from(categories).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}

class All {
  All({
    required this.name,
    required this.resourceCount,
    required this.imgId,
    required this.imgUrl,
    required this.type,
    required this.category,
    required this.resourceType,
    required this.hot,
    required this.activity,
  });

  String name;
  int resourceCount;
  int imgId;
  dynamic imgUrl;
  int type;
  int category;
  int resourceType;
  bool hot;
  bool activity;

  factory All.fromJson(Map<String, dynamic> json) => All(
    name: json["name"] == null ? null : json["name"],
    resourceCount: json["resourceCount"] == null ? null : json["resourceCount"],
    imgId: json["imgId"] == null ? null : json["imgId"],
    imgUrl: json["imgUrl"],
    type: json["type"] == null ? null : json["type"],
    category: json["category"] == null ? null : json["category"],
    resourceType: json["resourceType"] == null ? null : json["resourceType"],
    hot: json["hot"] == null ? null : json["hot"],
    activity: json["activity"] == null ? null : json["activity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "resourceCount": resourceCount == null ? null : resourceCount,
    "imgId": imgId == null ? null : imgId,
    "imgUrl": imgUrl,
    "type": type == null ? null : type,
    "category": category == null ? null : category,
    "resourceType": resourceType == null ? null : resourceType,
    "hot": hot == null ? null : hot,
    "activity": activity == null ? null : activity,
  };
}
