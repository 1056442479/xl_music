
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);


import 'dart:convert';

SongUserSelect songUserSelectFromJson(String str) => SongUserSelect.fromJson(json.decode(str));

String songUserSelectToJson(SongUserSelect data) => json.encode(data.toJson());
///歌手筛选实体类
class SongUserSelect {
  SongUserSelect({
     this.accountId,
     this.albumSize,
    required this.alias,
    required this.briefDesc,
    required this.fansCount,
    required this.followed,
    required this.id,
     this.img1V1Id,
     this.img1V1IdStr,
     this.img1V1Url,
     this.musicSize,
    required this.name,
    required this.picId,
     this.picIdStr,
    required this.picUrl,
     this.topicPerson,
     this.trans,
  });

  int ? accountId;
  int ? albumSize;
  List<String> alias;
  String briefDesc;
  int fansCount;
  bool followed;
  int id;
  double ? img1V1Id;
  String ? img1V1IdStr;
  String ? img1V1Url;
  int ? musicSize;
  String name;
  double picId;
  String ? picIdStr;
  String picUrl;
  int  ? topicPerson;
  String ? trans;

  factory SongUserSelect.fromJson(Map<String, dynamic> json) => SongUserSelect(
    accountId: json["accountId"] == null ? null : json["accountId"],
    albumSize: json["albumSize"] == null ? null : json["albumSize"],
    alias: List<String>.from(json["alias"].map((x) => x)),
    briefDesc: json["briefDesc"] == null ? null : json["briefDesc"],
    fansCount: json["fansCount"] == null ? null : json["fansCount"],
    followed: json["followed"] == null ? null : json["followed"],
    id: json["id"] == null ? null : json["id"],
    img1V1Id: json["img1v1Id"] == null ? null : json["img1v1Id"].toDouble(),
    img1V1IdStr: json["img1v1Id_str"] == null ? null : json["img1v1Id_str"],
    img1V1Url: json["img1v1Url"] == null ? null : json["img1v1Url"],
    musicSize: json["musicSize"] == null ? null : json["musicSize"],
    name: json["name"] == null ? null : json["name"],
    picId: json["picId"] == null ? null : json["picId"].toDouble(),
    picIdStr: json["picId_str"] == null ? null : json["picId_str"],
    picUrl: json["picUrl"] == null ? null : json["picUrl"],
    topicPerson: json["topicPerson"] == null ? null : json["topicPerson"],
    trans: json["trans"] == null ? null : json["trans"],
  );

  Map<String, dynamic> toJson() => {
    "accountId": accountId == null ? null : accountId,
    "albumSize": albumSize == null ? null : albumSize,
    "alias": alias == null ? null : List<dynamic>.from(alias.map((x) => x)),
    "briefDesc": briefDesc == null ? null : briefDesc,
    "fansCount": fansCount == null ? null : fansCount,
    "followed": followed == null ? null : followed,
    "id": id == null ? null : id,
    "img1v1Id": img1V1Id == null ? null : img1V1Id,
    "img1v1Id_str": img1V1IdStr == null ? null : img1V1IdStr,
    "img1v1Url": img1V1Url == null ? null : img1V1Url,
    "musicSize": musicSize == null ? null : musicSize,
    "name": name == null ? null : name,
    "picId": picId == null ? null : picId,
    "picId_str": picIdStr == null ? null : picIdStr,
    "picUrl": picUrl == null ? null : picUrl,
    "topicPerson": topicPerson == null ? null : topicPerson,
    "trans": trans == null ? null : trans,
  };
}
